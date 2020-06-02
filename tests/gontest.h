#ifndef GONTEST_H
#define GONTEST_H

#include <gtest/gtest.h>
#include <fstream>
#include <gmock/gmock-matchers.h>

/* using namespace testing; */
extern "C++" {
    #include "func.h"
}

TEST(getOperationNum, pos){
    Func f;
    f.createWallet("test");
    f.newEntry("aaa","test");
    f.newEntry("bbb", "test");
    f.newEntry("ccc", "test");
    int num = f.getOpNum("test");
    ASSERT_EQ(num, 3);
    remove("test.txt");
}

TEST(getOperationNum, neg){
    Func f;
    f.createWallet("test");
    int num = f.getOpNum("test");
    ASSERT_EQ(num, 0);
    remove("test.txt");
}

#endif // GONTEST_H
