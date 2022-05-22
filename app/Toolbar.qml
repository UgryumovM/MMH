import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
//import QtQuick.Dialogs 1.2

Rectangle{
    id:toolbarr
    width: w.width - walletlist.width - 10
    height: 50
    color: "lightyellow"

    property bool show: false

    onShowChanged: {
        if(show){
            doxod.visible = true
            rasxod.visible = true
            trash.visible = true
            delwallet.visible = true
        } else {
            doxod.visible = false
            rasxod.visible = false
            trash.visible = false
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
        anchors.right: parent.right
        anchors.rightMargin: 10
        Button{
            //text: "Запись доходов"
            id: doxod
            Layout.minimumHeight: toolbarr.height - 10
            Layout.minimumWidth: toolbarr.height - 10
            icon.width: toolbarr.height - 10
            icon.height: toolbarr.height - 10
            Layout.fillWidth: true
            Layout.fillHeight: true
            width: parent.width
            icon.color: "transparent"
            icon.source: "/e/doxod.png"
            visible: false
            onClicked: newD()
        }

        Button{
            //text: "Запись расходов"
            id: rasxod
            Layout.minimumHeight: toolbarr.height - 10
            Layout.minimumWidth: toolbarr.height - 10
            icon.width: toolbarr.height - 10
            icon.height: toolbarr.height - 10
            width: parent.width
            icon.color: "transparent"
            icon.source: "/e/rasxod.png"
            visible: false
            onClicked: newR()
        }
        Button{

            //text: "Удалить запись"
            id: trash
            Layout.minimumHeight: toolbarr.height - 10
            Layout.minimumWidth: toolbarr.height - 10
            icon.width: toolbarr.height - 10
            icon.height: toolbarr.height - 10
            width: parent.width
            icon.color: "transparent"
            icon.source: "/e/trash.png"
            visible: false
            onClicked: delZ()
        }
        Button{
            id: delwallet
            //text: "Удалить кошелек"
            Layout.minimumHeight: toolbarr.height - 10
            Layout.minimumWidth: toolbarr.height - 10
            icon.width: toolbarr.height - 10
            icon.height: toolbarr.height - 10
            width: parent.width
            icon.color: "transparent"
            icon.source: "/e/delwallet.png"
            visible: false
            onClicked: delW()
        }
        Button{
            id: addwallet
            //text: "Добавить новый кошелёк"
            Layout.minimumHeight: toolbarr.height - 10
            Layout.minimumWidth: toolbarr.height - 10
            icon.width: toolbarr.height - 10
            icon.height: toolbarr.height - 10
            width: parent.width
            icon.color: "transparent"
            icon.source: "/e/newwallet.png"
            onClicked: newW()
        }

    }
}
