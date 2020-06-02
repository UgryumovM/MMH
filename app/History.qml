import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.4

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

    contentHeight: (84)*frame.opnum
    ScrollBar.vertical: ScrollBar {
        width: 10
        active: true
    }
    Rectangle{
        id:frame
        height: 900
        width: 597
        x: 3
        property int opnum
        Column{
            spacing: 4

            Repeater{
                id:ol
                model: frame.opnum
                Rectangle{
                    property string text
                    property bool isActive: false

                    height: 80
                    Text{
                        x: 10
                        y: 5
                        text: " " + parent.text
                        lineHeight: 1.5
                        font.pointSize: 11
                        fontSizeMode: Text.Fit
                    }
                    width: frame.width - 10
                    border.color: "black"
                    border.width: 1
                    color: isActive ? "#D0F1B9" : "white"
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
