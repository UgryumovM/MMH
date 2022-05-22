import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
//import QtQuick.Dialogs 1.2

Rectangle{
    id:toolbarr
    width: w.width - walletlist.width - 10
    height: 50
    color: "lightyellow"

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
            Layout.minimumHeight: toolbarr.height - 10
            Layout.minimumWidth: toolbarr.height - 10
            icon.width: toolbarr.height - 10
            icon.height: toolbarr.height - 10
            Layout.fillWidth: true
            Layout.fillHeight: true
            width: parent.width
            icon.color: "transparent"
            icon.source: "/e/doxod.png"

            onClicked: newD()
        }

        Button{
            //text: "Запись расходов"
            Layout.minimumHeight: toolbarr.height - 10
            Layout.minimumWidth: toolbarr.height - 10
            icon.width: toolbarr.height - 10
            icon.height: toolbarr.height - 10
            width: parent.width
            icon.color: "transparent"
            icon.source: "/e/rasxod.png"
            onClicked: newR()
        }
        Button{

            //text: "Удалить запись"
            Layout.minimumHeight: toolbarr.height - 10
            Layout.minimumWidth: toolbarr.height - 10
            icon.width: toolbarr.height - 10
            icon.height: toolbarr.height - 10
            width: parent.width
            icon.color: "transparent"
            icon.source: "/e/trash.png"
            onClicked: delZ()
        }
        Button{

            //text: "Удалить кошелек"
            Layout.minimumHeight: toolbarr.height - 10
            Layout.minimumWidth: toolbarr.height - 10
            icon.width: toolbarr.height - 10
            icon.height: toolbarr.height - 10
            width: parent.width
            icon.color: "transparent"
            icon.source: "/e/delwallet.png"
            onClicked: delW()
        }
        Button{

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
