import QtQuick 2.0
import QtQuick.Layouts 1.12
//import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.15

//import QtQuick.Controls.Styles 1.4
Flickable {
    id: h
    property string wal
    property string currentline
    property var parsedData: ["","","",""]
    onWalChanged: currentline = ""
    function opr(wal) {
        //frame.opnum = func.getOpNum(wal)
        var oli = func.getYearData(wal, footer.year)
        var len = oli.length;
        frame.opnum = len;
        for (var i = 0; i < len; i++) {
            ol.itemAt(i).text = oli[i]
        }
        //footer.update()
    }
    function denial() {
        for (var i = 0; i < frame.opnum; i++) {
            ol.itemAt(i).isActive = false
        }
    }
    contentHeight: (50) * frame.opnum
    ScrollBar.vertical: ScrollBar {
        width: 10
        active: true
    }
    height: w.height - walletlist.height - 10 - footer.height
    Rectangle {
        color: "lightblue"
        id: frame
        height: w.height - walletlist.height - 10 - footer.height
        width: w.width - 15
        x: 3
        property int opnum
        Column {
            spacing: 4

            Repeater {
                id: ol
                model: frame.opnum
                Rectangle {
                    id: fram
                    property string text

                    onTextChanged: {
                        parsedData = func.parseAll(text)
                        date.text = parsedData[0]
                        parsedData[2] === "1" ? sum.text = '-' + parsedData[1] : sum.text
                                                = parsedData[1]
                        parsedData[2] === "1" ? sum.color = "red" : sum.color = "green"
                        desc.text = parsedData[3]
                    }

                    property bool isActive: false
                    width: w.width - 15
                    height: 50

                    /*border.color: "black"
                        border.width: 1*/
                    color: isActive ? "#D0F1B9" : "white"
                    RowLayout {
                        width: parent.width
                        height: parent.height
                        spacing: 0
                        Rectangle {
                            x: 0
                            width: parent.width / 6
                            height: fram.height
                            border.color: "black"
                            border.width: 1
                            color: fram.isActive ? "#D0F1B9" : "white"
                            Text {
                                anchors.centerIn: parent
                                font.pointSize: 13
                                font.bold: true
                                id: date
                            }
                        }
                        Rectangle {
                            x: parent.width / 6
                            width: parent.width / 6
                            height: fram.height
                            border.color: "black"
                            border.width: 1
                            color: fram.isActive ? "#D0F1B9" : "white"
                            Text {
                                anchors.centerIn: parent
                                font.pointSize: 13
                                font.bold: true
                                id: sum
                            }
                        }
                        Rectangle {
                            x: parent.width / 6 * 2
                            width: parent.width - parent.width / 6 * 2
                            height: fram.height
                            border.color: "black"
                            border.width: 1
                            color: fram.isActive ? "#D0F1B9" : "white"
                            Text {
                                x: 10
                                anchors.verticalCenter: parent.verticalCenter
                                font.pointSize: 14
                                id: desc
                                //text: "e"
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            denial()
                            parent.isActive = !parent.isActive
                            h.currentline = parent.text
                        }
                    }
                }
            }
        }
    }
}
