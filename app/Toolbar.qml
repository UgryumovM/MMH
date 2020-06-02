import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2

Rectangle{
    id:toolbarr
    width: 200
    height: 290
    color: "lightyellow"

    signal newD()
    signal newR()
    signal delZ()
    signal newW()
    signal delW()


    Button{
        x: 0
        y: 0
        text: "Запись доходов"
        Layout.fillWidth: true
        width: parent.width

        onClicked: newD()
    }

    Button{
        x: 0
        y: 60
        text: "Запись расходов"
        width: parent.width

        onClicked: newR()
    }
    Button{
        x: 0
        y: 120
        text: "Удалить запись"
        width: parent.width

        onClicked: delZ()
    }
    Button{
        x: 0
        y: 180
        text: "Добавить новый кошелёк"
        width: parent.width

        onClicked: newW()
    }
    Button{
        x: 0
        y: 240
        text: "Удалить кошелек"
        width: parent.width

        onClicked: delW()
    }
}
