import QtQuick 2.3
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4

Window {
    id: w

    visible: true
    property string log
    property int balance
    property var a: func.wlist()
    width: 810
    minimumWidth: 810
    maximumWidth: 810
    height: 700
    minimumHeight: 700
    maximumHeight: 700
    function addD(a){
        func.newEntry(w.log, a)
        walletlist.refresh()
        history.opr(a)
    }

    function addR(a){
        func.newEntry(w.log, a)
        walletlist.refresh()
        history.opr(a)
    }
    function newW(a){
        if(walletlist.wnum > 8){
            errnum.visible = true
            return
        }

        func.createWallet(a)
        walletlist.refresh()
    }

    title: qsTr("Money management helper")

    RowLayout{
        History{
            id: history
            Layout.preferredHeight: 700
            Layout.preferredWidth: 600
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        ColumnLayout{
            WalletList{
                id: walletlist
            }

            Toolbar{
                onNewD:{
                    if(func.getWalletNum() > 0){
                        w.a = func.wlist()
                        cb.fill()
                        dateD.visible = true
                    }
                    else{
                        errc.visible = true
                    }
                }
                onNewR:{
                    if(func.getWalletNum() > 0){
                        w.a = func.wlist()
                        cbr.fill()
                        dateR.visible = true
                    }
                    else{
                        errc.visible = true
                    }
                }
                onNewW: addWa.visible = true
                onDelW:{
                    w.a = func.wlist()
                    dw.fill()
                    delwa.visible = true
                }

                onDelZ:{
                    if(history.currentline){
                        func.deleteEntry(history.currentline, history.wal)
                        walletlist.refresh()
                        history.opr(history.wal)
                        history.currentline = ""
                    }
                    else{
                        errd.visible = true
                    }
                }
            }
        }

        Dialog{
            id: errd
            visible: false
            modality: Qt.WindowModal
            title: "Ошибка"
            standardButtons: StandardButton.Ok
            TextInput{
                text: "Сначала выберите запись, щелкнув по ней мышью, или создайте новую"
                readOnly: true
            }
        }

        Dialog{
            id: errc
            visible: false
            modality: Qt.WindowModal
            title: "Ошибка"
            standardButtons: StandardButton.Ok
            TextInput{
                text: "Для начала работы создайте новый кошелёк"
                readOnly: true
            }
        }

        Dialog{
            id: dateD
            visible: false
            modality: Qt.WindowModal
            title: "Ввод данных"
            standardButtons: StandardButton.Save | StandardButton.Cancel

            onAccepted:{
                w.log = calendard.selectedDate.toLocaleDateString() + '$' + ms.text + '&' + cm.text
                addD(cb.currentText)
            }
            ColumnLayout{
                Calendar{
                   id: calendard
                }
                TextField{
                   id: ms
                   Layout.fillWidth: true
                   validator: RegExpValidator { regExp: /[0-9.]+/ }
                   placeholderText: "Сумма"
                }
                TextField{
                   id: cm
                   Layout.fillWidth: true
                   placeholderText: "Комментарий"
                   maximumLength: 70
                }
                ComboBox{
                    id: cb
                    textRole: "text"
                    function fill(){
                        cbitems.clear()
                        for(var j = 0; j < func.getWalletNum(); j++){
                            cbitems.insert(j, {"text": w.a[j]})
                        }
                    }
                    model: ListModel{
                        id: cbitems
                    }
                    Layout.fillWidth: true
                }
            }
        }
        Dialog{
            id: dateR
            visible: false

            modality: Qt.WindowModal
            title: "Ввод данных"
            standardButtons: StandardButton.Save | StandardButton.Cancel

            onAccepted:{
                w.log = calendar.selectedDate.toLocaleDateString() + '$-' + msr.text + '&' + cmr.text
                addR(cbr.currentText)
            }
            ColumnLayout{
                Calendar{
                   id: calendar
                }
                TextField{
                    id: msr
                    Layout.fillWidth: true
                    validator: RegExpValidator { regExp: /[0-9.]+/ }
                    placeholderText: "Сумма"
                }
                TextField{
                    id: cmr
                    Layout.fillWidth: true
                    placeholderText: "Комментарий"
                }
                ComboBox{
                    id: cbr
                    textRole: "text"
                    function fill(){
                        cbritems.clear()
                        for(var j = 0; j < func.getWalletNum(); j++){
                            cbritems.insert(j, {"text": w.a[j]})
                        }
                    }
                    model: ListModel{
                        id: cbritems
                    }
                    Layout.fillWidth: true
                }
            }
        }
        Dialog{
            id: addWa
            visible: false
            modality: Qt.WindowModal

            title: "Новый кошелек"
            standardButtons: StandardButton.Save | StandardButton.Cancel

            onAccepted:{
                newW(wname.text);
            }
            TextField{
                id: wname
                Layout.fillWidth: true
                width: parent.width

                placeholderText: "Название кошелька (латиница)"
                validator: RegExpValidator { regExp: /[0-9a-zA-Z ]+/ }
            }
        }
        Dialog{
            id: errnum
            visible: false
            modality: Qt.WindowModal

            title: "Ошибка!"
            TextInput{
                text: "У вас не может быть больше 9 кошельков"
                readOnly: true
            }
            standardButtons: StandardButton.Ok
        }

        Dialog{
            id: delwa
            title: "Выберите кошелек"
            standardButtons: StandardButton.Ok | StandardButton.Cancel
            onAccepted:{
                func.deleteWallet(dw.currentText)
                walletlist.refresh()
            }
            ComboBox{
                id: dw
                textRole: "text"
                function fill(){
                    dwi.clear()
                    for(var j = 0; j < func.getWalletNum(); j++){
                        dwi.insert(j, {"text": w.a[j]})
                    }
                }
                model: ListModel{
                    id: dwi
                }
                width: parent.width
            }
        }
    }
}
