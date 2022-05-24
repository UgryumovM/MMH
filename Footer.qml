import QtQuick 2.0
import QtQuick.Layouts 1.12
//import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.15

RowLayout {
    width: parent.width
    height: 50
    Layout.leftMargin: 10
    property var year
    function ffill() {
        fti.clear()
        var list = func.parseYears(history.wal)
        var len = func.getYearData(history.wal, list[0]).length
        for (var j = 0; j < len; j++) {
            fti.insert(j, {
                           "text": list[j]
                       })
        }
        ft.currentIndex = 0
        year = ft.currentText
        history.opr(history.wal)
        dsum.text = func.getYearDohod(history.wal, year)
        rsum.text = func.getYearRashod(history.wal, year)
        res.text = func.getYearSum(history.wal, year)
    }

    ComboBox {
        Layout.rightMargin: 10
        width: 40
        height: 40
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
            res.text = func.getYearSum(history.wal, year)
        }
    }
    RowLayout{
        spacing: 5

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
        text: "Итог:"
    }
    TextInput{
        id: res
        readOnly: true
        font.pointSize: 13
        text: ""
    }
    }
}
