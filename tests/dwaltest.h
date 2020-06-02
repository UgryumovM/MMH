#ifndef DWALTEST_H
#define DWALTEST_H

#include <QString>
#include <fstream>
#include <gtest/gtest.h>
#include <gmock/gmock-matchers.h>

/* using namespace testing; */
extern "C++" {
    #include "func.h"
}

TEST(deleteWallet, pos){
    Func f;
    f.createWallet("test");
    f.createWallet("test2");
    f.deleteWallet("test2");
    std::fstream file;
    file.open("test2.txt", std::ios::in);
    int isOpen = 0;
    if(file)
        isOpen = 1;
    ASSERT_EQ(isOpen, 0);
    remove("test.txt");
}

#endif // DWALTEST_H
