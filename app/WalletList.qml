import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Rectangle{
    id:q
    width: 200
    height: 400
    color: "lightblue"
    property int wnum
    wnum: func.getWalletNum()
    function wnames(){
        var wli = func.wlist()
        for(var i = 0; i < q.wnum; i++){
            wl.itemAt(i).text = wli[i] + '      Баланс: ' + func.getBal(wli[i])
            wl.itemAt(i).wallet = wli[i]
        }
    }
    ColumnLayout{
        Repeater{
            id:wl
            model: wnum
            TextField{
                property string wallet
                readOnly: true
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        history.wal = parent.wallet
                        history.opr(parent.wallet)
                    }
                }
            }
        }
    }
    function refresh(){
        walletlist.wnum = func.getWalletNum()
        walletlist.wnames()
    }

    Component.onCompleted: {
        wnames()
    }
}
