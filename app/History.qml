import QtQuick 2.0
import QtQuick.Layouts 1.12
//import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.15
//import QtQuick.Controls.Styles 1.4

Flickable{
    id: h
    property string wal
    property string currentline
    onWalChanged: currentline = ""
    function opr(wal){
        frame.opnum = func.getOpNum(wal)
        var oli = func.getData(wal)
        for(var i = 0; i < frame.opnum; i++){
            ol.itemAt(i).text = oli[i]
        }
    }
    function denial(){
        for(var i = 0; i < frame.opnum; i++){
            ol.itemAt(i).isActive = false
        }
    }

    contentHeight: (50)*frame.opnum
    ScrollBar.vertical: ScrollBar {
        width: 10
        active: true
    }
    Rectangle{
        color: "lightblue"
        id:frame
        height: w.height - walletlist.height + (50)*frame.opnum
        width: w.width - 5
        x: 3
        property int opnum
        Column{
            spacing: 4

            Repeater{
                id:ol
                model: frame.opnum
                Rectangle{
//                    property string text
//                    property bool isActive: false

//                    height: 80
//                    Text{
//                        x: 10
//                        y: 5
//                        text: " " + parent.text
//                        lineHeight: 1.5
//                        font.pointSize: 11
//                        fontSizeMode: Text.Fit
//                    }
//                    width: frame.width - 10
//                    border.color: "black"
//                    border.width: 1
//                    color: isActive ? "#D0F1B9" : "white"
//                    MouseArea {
//                        anchors.fill: parent
//                        onClicked: {
//                            denial()
//                            parent.isActive = !parent.isActive
//                            h.currentline = parent.text
//                        }
//                    }
                    id: fram
                    property string text
                    property var parsedData
                    onTextChanged: {
                        parsedData = func.parseAll(text);
                        date.text = parsedData[0]
                        sum.text = parsedData[1]
                        parsedData[2] === "1" ? sum.color = "red" : sum.color = "green"
                        desc.text = parsedData[3]
                    }

                    property bool isActive: false
                    width: w.width - 5
                    height: 50
                    /*border.color: "black"
                    border.width: 1*/
                    color: isActive ? "#D0F1B9" : "white"
                    RowLayout{
                        width: parent.width
                        height: parent.height
                        spacing: 0
                        Rectangle{
                            x: 0
                            width: parent.width / 6
                            height: fram.height
                            border.color: "black"
                            border.width: 1
                            color: fram.isActive ? "#D0F1B9" : "white"
                            Text{
                                anchors.centerIn: parent
                                font.pointSize: 13
                                font.bold: true
                                id: date
                                //property string log: fram.text
                                //property var date: func.parseDate(log)
                                //text: fram.parsedData[1]
                            }
                        }
                        Rectangle{
                            x: parent.width / 6
                            width: parent.width / 6
                            height: fram.height
                            border.color: "black"
                            border.width: 1
                            color: fram.isActive ? "#D0F1B9" : "white"
                            Text{
                                anchors.centerIn: parent
                                font.pointSize: 13
                                font.bold: true
                                id: sum
                                //property var sum: func.parseSum(fram.text)
                                //text: sum
                                //color: sum.second ? "red" : "green"
                            }
                        }
                        Rectangle{
                            x: parent.width / 6 * 2
                            width: parent.width - parent.width / 6 * 2
                            height: fram.height
                            border.color: "black"
                            border.width: 1
                            color: fram.isActive ? "#D0F1B9" : "white"
                            Text{
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
