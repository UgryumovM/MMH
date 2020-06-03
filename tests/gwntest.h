#ifndef GWNTEST_H
#define GWNTEST_H

#include <QString>
#include <gtest/gtest.h>
#include <gmock/gmock-matchers.h>

/* using namespace testing; */
extern "C++" {
    #include "func.h"
}

TEST(getWalNum, pos){
    Func f;
    f.createWallet("test");
    f.createWallet("test2");
    int wnum = f.getWalletNum();
    ASSERT_EQ(wnum, 2);
    remove("test.mh");
    remove("test2.mh");
}

TEST(getWalNum, neg){
    Func f;
    int wnum = f.getWalletNum();
    ASSERT_EQ(wnum, 0);
}

#endif // GWNTEST_H
