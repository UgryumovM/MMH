import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
//import QtQuick.Dialogs 1.2

Rectangle{
    id:toolbarr
    width: w.width - walletlist.width - 10 - tbw.width
    height: 50
    color: "lightyellow"

    property bool show: false

    onShowChanged: {
        if (show) {
            doxod.visible = true
            rasxod.visible = true
            trash.visible = true
            edit.visible = true
        } else {
            doxod.visible = false
            rasxod.visible = false
            trash.visible = false
            edit.visible = false
        }
    }

    signal newD()
    signal newR()
    signal delZ()
    signal editZ()

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
            id: edit
            Layout.minimumHeight: toolbarr.height - 10
            Layout.minimumWidth: toolbarr.height - 10
            icon.width: toolbarr.height - 10
            icon.height: toolbarr.height - 10
            Layout.fillWidth: true
            Layout.fillHeight: true
            width: parent.width
            icon.color: "transparent"
            icon.source: "/e/pen.png"
            visible: false
            onClicked: editZ()
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


    }
}
