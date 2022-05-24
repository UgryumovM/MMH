#include "func.h"
#include <QDebug>
#include <QVector>
#include <QThread>
#include <QString>
#include <QString>
#include <iostream>
#include <fstream>
#include <experimental/filesystem>
#include <QStringConverter>
#include <QPair>

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
        if(strstr(s.c_str(), ".mh"))
            wallets++;
    }
    return wallets;
}

void Func::newEntry(QString log, QString wal)
{
    std::ofstream file;
    QString s = wal + ".mh";
    file.open(s.toStdString(), std::ios::app);
    file << log.toStdString();
    file << '\n';
    file.close();
}

double Func::getBal(QString wal){
    double sum = 0;
    QString s = wal + ".mh";
    std::fstream f;
    f.open(s.toStdString(), std::ios::in);
    if (f)
    {
        std::string buf;
        while (getline(f, buf))
        {
             QString num = "";
             for(unsigned int i = 1; i < buf.length(); i++){
                 std::string dollar = "$";
                 if(buf[i-1] == dollar[0]){
                    std::string mys = "";
                    for(int j = 0;buf[i]!='&';j++, i++){
                        mys.push_back(buf[i]);
                    }
                    num = QString::fromStdString(mys);
                    break;
                }
            }
            sum += num.toDouble(nullptr);
        }
    }
    f.close();
    return sum;
}

QVector<QString> Func::wlist(){
    std::cout << 'a';
    QVector<QString> walist;
    for(auto& p: fs::recursive_directory_iterator(fs::current_path())){
        if (!fs::is_regular_file(p.status()))
            continue;
        std::string s = p.path().filename().string();
        std::cout << s;
        if(strstr(s.c_str(), ".mh")){
            std::string file = p.path().stem().string();
            QString wa = QString::fromStdString(file);
            /*for(unsigned int i = 0; i < file.length() - 1; i++){
                wa[i] = file[i];
            }*/
            walist.push_back(wa.toUtf8());
        }
    }
    return walist;
}

void Func::createWallet(QString wal){
    std::cout << wal.toStdString();
    if(wal == "")
        return;
    QString a = wal.toUtf8() + ".mh";
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
    QString a = wal + ".mh";
    remove(a.toStdString().c_str());
}

QStringList Func::getData(QString wal){
    QString a = wal + ".mh";
    QFile file(a);
    file.open(QIODevice::ReadOnly);
    QTextStream in(&file);
    in.setEncoding(QStringConverter::Utf8);

    QStringList text;
    QString b;

    QString line;
    while(!in.atEnd()){
        line = in.readLine();
        int k = line.length();
        for(int i = 0; i < k; i++){
            QString test = line[i];
            if((line[i] == '$') || (line[i] == '&')){
                b.push_back('\n');
                continue;
            }
            if(line[i] == '\n')
                continue;
            b.push_back(line[i]);
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
    QString a = wal + ".mh";
    QFile file(a);
    file.open(QIODevice::ReadOnly);
    QTextStream in(&file);
    in.setEncoding(QStringConverter::Utf8);
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
    QString a = wal + ".mh";
    QFile file(a);
    file.open(QIODevice::ReadOnly);
    QTextStream in(&file);
    in.setEncoding(QStringConverter::Utf8);
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

QStringList Func::parseAll(QString log){
    QStringList res;
    QString date;
    int j = 0;
    for(int i = 0; i < log.length(); i++){
        if(log[i] == '\n'){
            j = i + 1;
            break;
        }
        date.append(log[i]);
    }
    res.push_back(date);

    QString sum;
    QString sign = "0";
    if (log[j] == '-'){
        sign = "1";
        j++;
    }
    for(int i = j; i < log.length(); i++){

        if(log[i] == '\n'){
            j = i + 1;
            break;
        }
        sum.append(log[i]);
    }

    res.push_back(sum);

    res.push_back(sign);

    QString desc;
    for(int i = j; i < log.length(); i++){
        if(log[i] == '\n')   break;

        desc.append(log[i]);
    }

    res.push_back(desc);

    return res;
}

void Func::editEntry(QString oldlog, QString wal, QString newlog){
    int o;
    for(o = 0; o < oldlog.length() - 1; o++){
        if(oldlog[o] == '\n'){
            oldlog[o] = '$';
            break;
        }
    }
    for(; o < oldlog.length() - 1; o++){
        if(oldlog[o] == '\n'){
            oldlog[o] = '&';
            break;
        }
    }
    QString a = wal + ".mh";
    QFile file(a);
    file.open(QIODevice::ReadOnly);
    QTextStream in(&file);
    in.setEncoding(QStringConverter::Utf8);
    QStringList text;
    int i = 0;
    int entryline = 0;
    QString line;
    while(!in.atEnd()){
        i++;
        line = in.readLine();
        if(strstr(oldlog.toStdString().c_str(), line.toStdString().c_str())){
            entryline = i;
        }
        text.push_back(line);
    }
    file.close();
    text[entryline - 1] = newlog.toStdString().c_str();
    for(i = entryline - 1; i < text.length() - 1; i++){
        text[i] = text[i];
    }
    text[entryline - 1] = newlog.toStdString().c_str();
    //text[text.length()-1] = '\0';
    std::ofstream f(a.toStdString());
    for(int j = 0; j < text.length(); j++){
        f << text[j].toStdString() << std::endl;
    }
    f.close();
}
