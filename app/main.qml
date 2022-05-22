import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs
import QtQuick.Controls 2.15

Window {
    id: w

    visible: true
    property string log
    property int balance
    property var a: func.wlist()
    width: 810
    minimumWidth: 650
    //maximumWidth: 810
    height: 700
    //minimumHeight: 700
    //maximumHeight: 700
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

    ColumnLayout{
        x: 5
        RowLayout{
            spacing: 0
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
                    walletlist.refresh()
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
        History{
            id: history
            Layout.preferredHeight: 700
            Layout.preferredWidth: 600
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        }

        Dialog{
            id: errd
            visible: false
            modal: true
            title: "Ошибка"
            standardButtons: Dialog.Ok
            topMargin: w.height / 2 - height / 2
            leftMargin: w.width / 2 - width / 2
            TextInput{
                text: "Сначала выберите запись, щелкнув по ней мышью, или создайте новую"
                readOnly: true
            }
        }

        Dialog{
            id: errc
            visible: false
            modal: true
            title: "Ошибка"
            standardButtons: Dialog.Ok
            topMargin: w.height / 2 - height / 2
            leftMargin: w.width / 2 - width / 2
            TextInput{
                text: "Для начала работы создайте новый кошелёк"
                readOnly: true
            }
        }

        Dialog{
            id: dateD
            visible: false
            modal: true
            title: "Ввод данных"
            standardButtons: Dialog.Save | Dialog.Cancel
            topMargin: w.height / 2 - height / 2
            leftMargin: w.width / 2 - width / 2
            onAccepted:{
                if(cb.currentText){
                    w.log = calendard.text + '$' + ms.text + '&' + cm.text
                    addD(cb.currentText)
                } else errnumr.visible = true;
            }
            ColumnLayout{
                anchors.centerIn: parent
                TextField{
                   id: calendard
                   Layout.fillWidth: true
                   validator: RegularExpressionValidator { regularExpression: /^([1-9]|0[1-9]|[12][0-9]|3[01])[-\.]([1-9]|0[1-9]|1[012])[-\.](19|20)\d\d$/ }
                   placeholderText: "Дата"
                }
                TextField{
                   id: ms
                   Layout.fillWidth: true
                   validator: RegularExpressionValidator { regularExpression: /[0-9.]+/ }
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

            modal: true
            title: "Ввод данных"
            standardButtons: Dialog.Save | Dialog.Cancel
            topMargin: w.height / 2 - height / 2
            leftMargin: w.width / 2 - width / 2
            onAccepted:{
                if(cbr.currentText){
                    w.log = calendar.text + '$-' + msr.text + '&' + cmr.text
                    addR(cbr.currentText)
                } else errnumr.visible = true;
            }
            ColumnLayout{
                anchors.centerIn: parent
                TextField{
                   id: calendar
                   Layout.fillWidth: true
                   validator: RegularExpressionValidator { regularExpression: /^([1-9]|0[1-9]|[12][0-9]|3[01])[-\.]([1-9]|0[1-9]|1[012])[-\.](19|20)\d\d$/ }
                   placeholderText: "Дата"
                }
                TextField{
                    id: msr
                    Layout.fillWidth: true
                    validator: RegularExpressionValidator { regularExpression: /[0-9.]+/ }
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
            modal: true

            title: "Новый кошелек"
            standardButtons: Dialog.Save | Dialog.Cancel
            topMargin: w.height / 2 - height / 2
            leftMargin: w.width / 2 - width / 2
            onAccepted:{
                if(wname.text)
                    newW(wname.text);
                else
                    len.visible = true
            }
            TextField{
                id: wname
                Layout.fillWidth: true
                width: parent.width

                placeholderText: "Название кошелька (латиница)"
                validator: RegularExpressionValidator { regularExpression: /[0-9a-zA-Z ]+/ }
            }
        }
        Dialog{
            id: len
            visible:false
            modal: true

            title: "Ошибка!"
            TextInput{
                text: "Вы не ввели имя"
                readOnly: true
            }
            standardButtons: Dialog.Ok
            topMargin: w.height / 2 - height / 2
            leftMargin: w.width / 2 - width / 2
        }

        Dialog{
            id: errnumd
            visible: false
            modal: true

            title: "Ошибка!"
            TextInput{
                text: "Сначала нужно выбрать кошелек"
                readOnly: true
            }
            onAccepted: dateD.visible = true
            standardButtons: Dialog.Ok
            topMargin: w.height / 2 - height / 2
            leftMargin: w.width / 2 - width / 2
        }
        Dialog{
            id: errnumr
            visible: false
            modal: true

            title: "Ошибка!"
            TextInput{
                text: "Сначала нужно выбрать кошелек"
                readOnly: true
            }
            onAccepted: dateR.visible = true
            standardButtons: Dialog.Ok
            topMargin: w.height / 2 - height / 2
            leftMargin: w.width / 2 - width / 2
        }

        Dialog{
            id: delwa
            title: "Выберите кошелек"
            standardButtons: Dialog.Ok | Dialog.Cancel
            onAccepted:{
                func.deleteWallet(dw.currentText)
                walletlist.refresh()
            }
            topMargin: w.height / 2 - height / 2
            leftMargin: w.width / 2 - width / 2
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
