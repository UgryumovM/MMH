import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
//import QtQuick.Dialogs 1.2

Rectangle{
    id:toolbarrr
    width: toolbarrr.height * 2 + 10
    height: 50
    color: "lightyellow"

    property bool show: false

    onShowChanged: {
        if(show){

            delwallet.visible = true
        } else {

            delwallet.visible = false
        }
    }

    signal newD()
    signal newR()
    signal delZ()
    signal newW()
    signal delW()

    RowLayout{

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.rightMargin: 20
        Button{
            id: addwallet
            //text: "Добавить новый кошелёк"
            Layout.minimumHeight: toolbarrr.height - 10
            Layout.minimumWidth: toolbarrr.height - 10
            icon.width: toolbarrr.height - 10
            icon.height: toolbarrr.height - 10
            width: parent.width
            icon.color: "transparent"
            icon.source: "/e/newwallet.png"
            onClicked: newW()
        }
        Button{
            id: delwallet
            //text: "Удалить кошелек"
            Layout.minimumHeight: toolbarrr.height - 10
            Layout.minimumWidth: toolbarrr.height - 10
            icon.width: toolbarrr.height - 10
            icon.height: toolbarrr.height - 10
            width: parent.width
            icon.color: "transparent"
            icon.source: "/e/delwallet.png"
            visible: false
            onClicked: delW()
        }


    }
}
