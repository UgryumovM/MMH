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
    property date currentDate: new Date()
    width: 810
    minimumWidth: 650
    //maximumWidth: 810
    height: 700
    //minimumHeight: 700
    //maximumHeight: 700
    function addD(a) {
        func.newEntry(w.log, a)
        walletlist.refresh()
        history.opr(a)
        footer.ffill()
    }

    function addR(a) {
        func.newEntry(w.log, a)
        walletlist.refresh()
        history.opr(a)
        footer.ffill()
    }
    function newW(a) {
        if (walletlist.wnum > 8) {
            errnum.visible = true
            return
        }

        func.createWallet(a)
        walletlist.refresh()
    }

    title: qsTr("Money management helper")

    ColumnLayout {
        x: 5
        RowLayout {
            spacing: 0
            Toolbar_wallet {
                id: tbw
                onNewW: addWa.visible = true
                onDelW: {
                    w.a = func.wlist()
                    dw.fill()
                    delwa.visible = true
                    walletlist.refresh()
                }
            }

            WalletList {
                id: walletlist
                onIAmActive: {
                    tb.show = true
                    tbw.show = true
                }
            }

            Toolbar {
                id: tb
                onNewD: {
                    if (func.getWalletNum() > 0) {
                        w.a = func.wlist()
                        cb.fill()
                        dateD.visible = true
                    } else {
                        errc.visible = true
                    }
                }
                onNewR: {
                    if (func.getWalletNum() > 0) {
                        w.a = func.wlist()
                        cbr.fill()
                        dateR.visible = true
                    } else {
                        errc.visible = true
                    }
                }

                onDelZ: {
                    if (history.currentline) {
                        func.deleteEntry(history.currentline, history.wal)
                        walletlist.refresh()
                        history.opr(history.wal)
                        history.currentline = ""
                        footer.dfill()
                        tb.show = false
                        tb.show = true
                    } else {
                        errd.visible = true
                    }
                }
                onEditZ: {
                    if (history.currentline) {
                        rbd.set()
                        rbr.set()
                        dateI.visible = true

                        footer.dfill()
                    } else {
                        errd.visible = true
                    }
                }
            }
        }

        History {
            id: history
            Layout.preferredHeight: 590
            Layout.preferredWidth: 500
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.rightMargin: 10
        }
        Footer {
            id: footer
            Layout.preferredHeight: 50
            Layout.preferredWidth: 500
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    Dialog {
        id: errd
        visible: false
        modal: true
        title: "Ошибка"
        standardButtons: Dialog.Ok
        topMargin: w.height / 2 - height / 2
        leftMargin: w.width / 2 - width / 2
        TextInput {
            text: "Сначала выберите запись, щелкнув по ней мышью"
            readOnly: true
        }
    }

    Dialog {
        id: errc
        visible: false
        modal: true
        title: "Ошибка"
        standardButtons: Dialog.Ok
        topMargin: w.height / 2 - height / 2
        leftMargin: w.width / 2 - width / 2
        TextInput {
            text: "Для начала работы создайте новый кошелёк"
            readOnly: true
        }
    }

    Dialog {
        id: dateI
        visible: false
        modal: true
        title: "Ввод данных"
        standardButtons: Dialog.Save | Dialog.Cancel
        topMargin: w.height / 2 - height / 2
        leftMargin: w.width / 2 - width / 2
        onAccepted: {
            var temp = history.currentline
            rbr.checked ? func.editEntry(
                              history.currentline, history.wal,
                              calendari.text + '$-' + msi.text + '&'
                              + cmi.text) : func.editEntry(history.currentline,
                                                           history.wal, calendari.text
                                                           + '$' + msi.text + '&' + cmi.text)
            walletlist.refresh()
            history.opr(history.wal)
            rbr.checked ? history.currentline = calendari.text + '\n-' + msi.text
                          + '\n' + cmi.text + '\n' : history.currentline
                          = calendari.text + '\n' + msi.text + '\n' + cmi.text + '\n'
            footer.dfill()
        }
        ColumnLayout {
            anchors.centerIn: parent
            TextField {
                id: calendari
                Layout.fillWidth: true
                validator: RegularExpressionValidator {
                    regularExpression: /^([1-9]|0[1-9]|[12][0-9]|3[01])[-\.]([1-9]|0[1-9]|1[012])[-\.](19|20)\d\d$/
                }
                placeholderText: "Дата"
                text: history.parsedData[0]
            }
            TextField {
                id: msi
                Layout.fillWidth: true
                validator: RegularExpressionValidator {
                    regularExpression: /[0-9.]+/
                }
                placeholderText: "Сумма"
                text: history.parsedData[1]
            }
            TextField {
                id: cmi
                Layout.fillWidth: true
                placeholderText: "Комментарий"
                maximumLength: 70
                text: history.parsedData[3]
            }
            RowLayout {
                RadioButton {
                    id: rbd
                    //checked: true
                    text: qsTr("Доход")
                    function set() {
                        if (history.parsedData[2] === "0")
                            checked = true
                    }
                }
                RadioButton {
                    id: rbr
                    text: qsTr("Расход")
                    function set() {
                        if (history.parsedData[2] === "1")
                            checked = true
                    }
                }
            }
        }
    }

    Dialog {
        id: dateD
        visible: false
        modal: true
        title: "Ввод данных"
        standardButtons: Dialog.Save | Dialog.Cancel
        topMargin: w.height / 2 - height / 2
        leftMargin: w.width / 2 - width / 2
        onAccepted: {
            if (cb.currentText) {
                w.log = calendard.text + '$' + ms.text + '&' + cm.text
                addD(cb.currentText)
                history.currentline = ""
                tb.show = false
                tb.show = true
            } else
                errnumr.visible = true
        }
        ColumnLayout {
            anchors.centerIn: parent
            TextField {
                id: calendard
                Layout.fillWidth: true
                validator: RegularExpressionValidator {
                    regularExpression: /^([1-9]|0[1-9]|[12][0-9]|3[01])[-\.]([1-9]|0[1-9]|1[012])[-\.](19|20)\d\d$/
                }
                placeholderText: "Дата"
                text: new Date().toLocaleDateString(Qt.locale("ru_RU"),
                                                    Locale.ShortFormat)
            }
            TextField {
                id: ms
                Layout.fillWidth: true
                validator: RegularExpressionValidator {
                    regularExpression: /[0-9.]+/
                }
                placeholderText: "Сумма"
            }
            TextField {
                id: cm
                Layout.fillWidth: true
                placeholderText: "Комментарий"
                maximumLength: 70
            }
            ComboBox {
                id: cb
                textRole: "text"
                function fill() {
                    cbitems.clear()
                    for (var j = 0; j < func.getWalletNum(); j++) {
                        cbitems.insert(j, {
                                           "text": w.a[j]
                                       })
                    }
                    var index = find(history.wal)
                    cb.currentIndex = index
                }
                model: ListModel {
                    id: cbitems
                }

                Layout.fillWidth: true
            }
        }
    }
    Dialog {
        id: dateR
        visible: false

        modal: true
        title: "Ввод данных"
        standardButtons: Dialog.Save | Dialog.Cancel
        topMargin: w.height / 2 - height / 2
        leftMargin: w.width / 2 - width / 2
        onAccepted: {
            if (cbr.currentText) {
                w.log = calendar.text + '$-' + msr.text + '&' + cmr.text
                addR(cbr.currentText)
                history.currentline = ""
                tb.show = false
                tb.show = true
            } else
                errnumr.visible = true
        }
        ColumnLayout {
            anchors.centerIn: parent
            TextField {
                id: calendar
                Layout.fillWidth: true
                validator: RegularExpressionValidator {
                    regularExpression: /^([1-9]|0[1-9]|[12][0-9]|3[01])[-\.]([1-9]|0[1-9]|1[012])[-\.](19|20)\d\d$/
                }
                placeholderText: "Дата"
                text: new Date().toLocaleDateString(Qt.locale("ru_RU"),
                                                    Locale.ShortFormat)
            }
            TextField {
                id: msr
                Layout.fillWidth: true
                validator: RegularExpressionValidator {
                    regularExpression: /[0-9.]+/
                }
                placeholderText: "Сумма"
            }
            TextField {
                id: cmr
                Layout.fillWidth: true
                placeholderText: "Комментарий"
            }
            ComboBox {
                id: cbr
                textRole: "text"
                function fill() {
                    cbritems.clear()
                    for (var j = 0; j < func.getWalletNum(); j++) {
                        cbritems.insert(j, {
                                            "text": w.a[j]
                                        })
                    }
                    var index = find(history.wal)
                    cbr.currentIndex = index
                }
                model: ListModel {
                    id: cbritems
                }
                Layout.fillWidth: true
            }
        }
    }
    Dialog {
        id: addWa
        visible: false
        modal: true

        title: "Новый кошелек"
        standardButtons: Dialog.Save | Dialog.Cancel
        topMargin: w.height / 2 - height / 2
        leftMargin: w.width / 2 - width / 2
        width: 200
        onAccepted: {
            if (wname.text)
                newW(wname.text)
            else
                len.visible = true
        }
        TextField {
            id: wname
            Layout.fillWidth: true
            width: parent.width

            placeholderText: "Название кошелька (латиница)"
            validator: RegularExpressionValidator {
                regularExpression: /[0-9a-zA-Z ]+/
            }
        }
    }
    Dialog {
        id: len
        visible: false
        modal: true

        title: "Ошибка!"
        TextInput {
            text: "Вы не ввели имя"
            readOnly: true
        }
        standardButtons: Dialog.Ok
        topMargin: w.height / 2 - height / 2
        leftMargin: w.width / 2 - width / 2
    }

    Dialog {
        id: errnumd
        visible: false
        modal: true

        title: "Ошибка!"
        TextInput {
            text: "Сначала нужно выбрать кошелек"
            readOnly: true
        }
        onAccepted: dateD.visible = true
        standardButtons: Dialog.Ok
        topMargin: w.height / 2 - height / 2
        leftMargin: w.width / 2 - width / 2
    }
    Dialog {
        id: errnumr
        visible: false
        modal: true

        title: "Ошибка!"
        TextInput {
            text: "Сначала нужно выбрать кошелек"
            readOnly: true
        }
        onAccepted: dateR.visible = true
        standardButtons: Dialog.Ok
        topMargin: w.height / 2 - height / 2
        leftMargin: w.width / 2 - width / 2
    }

    Dialog {
        id: delwa
        title: "Выберите кошелек"
        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: {
            func.deleteWallet(dw.currentText)
            walletlist.refresh()
        }
        topMargin: w.height / 2 - height / 2
        leftMargin: w.width / 2 - width / 2
        ComboBox {
            id: dw
            textRole: "text"
            function fill() {
                dwi.clear()
                for (var j = 0; j < func.getWalletNum(); j++) {
                    dwi.insert(j, {
                                   "text": w.a[j]
                               })
                }
                var index = find(history.wal)
                dw.currentIndex = index
            }
            model: ListModel {
                id: dwi
            }
            width: parent.width
        }
    }
}
