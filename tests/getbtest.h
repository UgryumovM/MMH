#ifndef GETBTEST_H
#define GETBTEST_H

#include <gtest/gtest.h>
#include <gmock/gmock-matchers.h>

/* using namespace testing; */
extern "C++" {
    #include "func.h"
}

TEST(getBalance, pos){
    Func f;
    f.createWallet("test");
    f.newEntry("aaa$10&a","test");
    f.newEntry("bbb$30.2&a","test");
    f.newEntry("ccc$-5&a","test");
    double balance = f.getBal("test");
    ASSERT_EQ(balance, 35.2);
    remove("test.mh");
}

TEST(getBalance, neg){
    Func f;
    f.createWallet("test");
    double balance = f.getBal("test");
    ASSERT_EQ(balance, 0);
    remove("test.mh");
}

#endif // GETBTEST_H
