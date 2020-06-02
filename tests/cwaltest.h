#ifndef CWALTEST_H
#define CWALTEST_H

#include <QString>
#include <fstream>
#include <gtest/gtest.h>
#include <gmock/gmock-matchers.h>

/* using namespace testing; */
extern "C++" {
    #include "func.h"
}

TEST(createWal, pos){
    QString wal = "test";
    Func f;
    f.createWallet(wal);
    std::fstream file;
    file.open("test.txt", std::ios::in);
    int isOpen = 0;
    if(file)
        isOpen = 1;
    ASSERT_EQ(isOpen, 1);
    if(isOpen)
        remove("test.txt");
    file.close();
}

TEST(createWal, neg){
    QString wal = "";
    Func f;
    f.createWallet(wal);
    std::fstream file;
    file.open(".txt", std::ios::in);
    int isOpen = 0;
    if(file)
        isOpen = 1;
    ASSERT_EQ(isOpen, 0);
    if(isOpen)
        remove(".txt");
    file.close();
}
#endif // CWALTEST_H
