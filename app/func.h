#ifndef FUNC_H
#define FUNC_H

#include <QString>
#include <QVector>
#include <QObject>
#include <QFile>

class Func : public QObject
{
    Q_OBJECT
public:
    explicit Func(QObject *parent = nullptr);

signals:

public slots:
    int getWalletNum();
    void newEntry(QString log, QString wal);
    double getBal(QString wal);
    QVector<QString> wlist();
    void createWallet(QString wal);
    void deleteWallet(QString wal);
    QStringList getData(QString wal);
    int getOpNum(QString wal);
    void deleteEntry(QString log, QString wal);
};


#endif // FUNC_H
