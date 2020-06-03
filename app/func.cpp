#include "func.h"
#include <QDebug>
#include <QVector>
#include <QThread>
#include <QString>
#include <QString>
#include <iostream>
#include <fstream>
#include <experimental/filesystem>

namespace fs = std::experimental::filesystem;

Func::Func(QObject *parent) : QObject(parent)
{

}

int Func::getWalletNum()
{
    int wallets = 0;
    for(auto& p: fs::recursive_directory_iterator(fs::current_path())){
        if (!fs::is_regular_file(p.status()))
            continue;
        std::string s = p.path().filename().string();
        if(strstr(s.c_str(), ".txt"))
            wallets++;
    }
    return wallets;
}

void Func::newEntry(QString log, QString wal)
{
    std::ofstream file;
    QString s = wal + ".txt";
    file.open(s.toStdString(), std::ios::app);
    file << log.toStdString();
    file << '\n';
    file.close();
}

double Func::getBal(QString wal){
    double sum = 0;
    QString s = wal + ".txt";
    std::fstream f;
    f.open(s.toStdString(), std::ios::in);
    if (f)
    {
        std::string buf;
        while (getline(f, buf))
        {
             QString num = "";
             for(unsigned int i = 1; i < buf.length(); i++){
                 if(buf[i-1] == '$'){
                    for(int j = 0;buf[i]!='&';j++){
                        num[j] = buf[i];
                        i++;
                    }
                }
            }
            sum += num.toDouble(nullptr);
        }
    }
    f.close();
    return sum;
}

QVector<QString> Func::wlist(){
    QVector<QString> walist;
    for(auto& p: fs::recursive_directory_iterator(fs::current_path())){
        if (!fs::is_regular_file(p.status()))
            continue;
        std::string s = p.path().filename().string();
        if(strstr(s.c_str(), ".txt")){
            std::string file = p.path().stem().string();
            QString wa;
            for(unsigned int i = 0; i < file.length(); i++){
                wa[i] = file[i];
            }
            walist.push_back(wa.toUtf8());
        }
    }
    return walist;
}

void Func::createWallet(QString wal){
    QString a = wal.toUtf8() + ".txt";
    for(auto& p: fs::recursive_directory_iterator(fs::current_path())){
        if (!fs::is_regular_file(p.status()))
            continue;
        std::string s = p.path().filename().string();
        if(strstr(s.c_str(), a.toStdString().c_str()))
            return;
    }
    std::ofstream file(a.toStdString());
    file << "";
    file.close();
}
void Func::deleteWallet(QString wal){
    QString a = wal + ".txt";
    remove(a.toStdString().c_str());
}

QStringList Func::getData(QString wal){
    QString a = wal + ".txt";
    QFile file(a);
    file.open(QIODevice::ReadOnly);
    QTextStream in(&file);
    in.setCodec("UTF-8");

    QStringList text;
    QString b;

    QString line;
    while(!in.atEnd()){
        line = in.readLine();
        int k = line.length();
        for(int i = 0; i < k; i++){
            if((line[i] == '$') || (line[i] == '&')){
                b[i] = '\n';
                continue;
            }
            if(line[i] == '\n')
                continue;
            b[i] = line[i];
        }
        b.append('\n');
        text.push_back(b);
        b.clear();
    }
    file.close();

    int i = 0;
    for(int j = text.length() - 1; i < j; j--){
        QString t;
        t = text[j];
        text[j] = text[i];
        text[i] = t;
        i++;
    }

    return text;
}

int Func::getOpNum(QString wal){
    QString a = wal + ".txt";
    QFile file(a);
    file.open(QIODevice::ReadOnly);
    QTextStream in(&file);
    in.setCodec("UTF-8");
    int num = 0;

    QString line;
    while(!in.atEnd()){
        line = in.readLine();
        num++;
    }
    file.close();
    return num;
}

void Func::deleteEntry(QString log, QString wal){
    int o;
    for(o = 0; o < log.length() - 1; o++){
        if(log[o] == '\n'){
            log[o] = '$';
            break;
        }
    }
    for(; o < log.length() - 1; o++){
        if(log[o] == '\n'){
            log[o] = '&';
            break;
        }
    }
    QString a = wal + ".txt";
    QFile file(a);
    file.open(QIODevice::ReadOnly);
    QTextStream in(&file);
    in.setCodec("UTF-8");
    QStringList text;
    int i = 0;
    int entryline = 0;
    QString line;
    while(!in.atEnd()){
        i++;
        line = in.readLine();
        if(strstr(log.toStdString().c_str(), line.toStdString().c_str())){
            entryline = i;
        }
        text.push_back(line);
    }
    file.close();
    for(i = entryline - 1; i < text.length() - 1; i++){
        text[i] = text[i+1];
    }
    text[text.length()-1] = '\0';
    std::ofstream f(a.toStdString());
    for(int j = 0; j < text.length() - 1; j++){
        f << text[j].toStdString() << std::endl;
    }
    f.close();
}
