import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15

//Rectangle{
//    id:q
//    width: 200
//    height: 400
//    color: "lightblue"
//    property int wnum
//    wnum: func.getWalletNum()
//    function wnames(){
//        var wli = func.wlist()
//        for(var i = 0; i < q.wnum; i++){
//            wl.itemAt(i).text = wli[i] + '      Баланс: ' + func.getBal(wli[i])
//            wl.itemAt(i).wallet = wli[i]
//        }
//    }
//    ColumnLayout{
//        Repeater{
//            id:wl
//            model: wnum
//            TextField{
//                property string wallet
//                readOnly: true
//                MouseArea {
//                    anchors.fill: parent
//                    onClicked: {
//                        history.wal = parent.wallet
//                        history.opr(parent.wallet)
//                    }
//                }
//            }
//        }
//    }
//    function refresh(){
//        walletlist.wnum = func.getWalletNum()
//        walletlist.wnames()
//    }

//    Component.onCompleted: {
//        wnames()
//    }
//}

Rectangle{
    id: q
    width: 400
    height: 50
    color: "lightyellow"
    property int wnum
    wnum: func.getWalletNum()
    property var a: func.wlist()
    function wnames(){
        a = func.wlist()
    }
    function refresh(){
        walletlist.wnum = func.getWalletNum()
        walletlist.wnames()
        var i = dw.currentIndex
        dw.fill()
        if(i <= wnum)
            dw.currentIndex = i
        else dw.currentIndex = i - 1
        history.wal = dw.currentText
        history.opr(dw.currentText)
        var ccc = func.getBal(dw.currentText)
        if(ccc){
            balance.text = "Баланс: " + ccc
        }
        else balance.text = ""
    }
    RowLayout{
        id: rows
        anchors.verticalCenter: parent.verticalCenter
        x: 10
        ComboBox{
            width: 200 + 2*leftPadding + 2*rightPadding
            height: 40
            id: dw
            property var wal_bal
            textRole: "text"
            function fill(){
                dwi.clear()
                for(var j = 0; j < func.getWalletNum(); j++){
                    dwi.insert(j, {"text": q.a[j]})
                }
            }
            model: ListModel{
                id: dwi
            }
            Component.onCompleted: {
                fill()
            }
            onActivated: {
                history.wal = dw.currentText
                history.opr(dw.currentText)
                wal_bal = func.getBal(dw.currentText)
                wal_bal ? balance.text = "Баланс: " + wal_bal : balance.text = ""
            }
        }
        TextInput{
            font.pointSize: 13
            id: balance
            text: ""
            readOnly: true
        }
    }
    Component.onCompleted: {
        wnames()
    }
}
