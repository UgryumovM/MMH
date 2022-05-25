import QtQuick 2.0
import QtQuick.Layouts 1.12
//import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.15

RowLayout {
    width: parent.width
    height: 70
    Layout.leftMargin: 10
    id: foot
    visible: false
    property var year
    function ffill() {
        fti.clear()
        var list = func.parseYears(history.wal)
        //var len = func.getYearData(history.wal, list[0]).length
        for (var j = 0; j < list.length; j++) {
            fti.insert(j, {
                           "text": list[j]
                       })
        }
        ft.currentIndex = list.length  - 1
        year = ft.currentText
        history.opr(history.wal)
        dsum.text = func.getYearDohod(history.wal, year)
        rsum.text = func.getYearRashod(history.wal, year)
        var x = func.getYearSum(history.wal, year)
        res.text = x
        if(x >= 0)
            res.color = "green"
        else res.color = "red"
        visible = true
    }
    function dfill(){
        year = ft.currentText
        history.opr(history.wal)
        dsum.text = func.getYearDohod(history.wal, year)
        rsum.text = func.getYearRashod(history.wal, year)
        var x = func.getYearSum(history.wal, year)
        res.text = x
        if(x >= 0)
            res.color = "green"
        else res.color = "red"
    }

    ComboBox {
        Layout.rightMargin: 10
        width: 50
        height: 50
        id: ft
        textRole: "text"

        model: ListModel {
            id: fti
        }
        onActivated: {
            year = ft.currentText
            history.opr(history.wal)
            dsum.text = func.getYearDohod(history.wal, year)
            rsum.text = func.getYearRashod(history.wal, year)
            var x = func.getYearSum(history.wal, year)
            res.text = x
            x >= 0 ? res.color = "green" : res.color = "red"

        }
    }
    RowLayout{
        spacing: 5
        anchors.right: parent.right
        Layout.leftMargin: 100
        TextInput{
            readOnly: true
            font.pointSize: 13

            text: "Доход:"
        }
        TextInput{
            id: dsum
            readOnly: true
            font.pointSize: 13
            color: "green"
            Layout.rightMargin: 20
            text: ""
        }
        TextInput{
            readOnly: true
            font.pointSize: 13
            text: "Расход:"
        }
        TextInput{
            id: rsum
            readOnly: true
            font.pointSize: 13
            color: "red"
            Layout.rightMargin: 20
            text: ""
        }
        TextInput{
            readOnly: true
            font.pointSize: 13
            text: "Остаток:"
        }
        TextInput{
            id: res
            readOnly: true
            font.pointSize: 13
            text: ""
        }
    }
}
