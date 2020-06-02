#ifndef WLTEST_H
#define WLTEST_H

#include <gtest/gtest.h>
#include <gmock/gmock-matchers.h>

/* using namespace testing; */
extern "C++" {
    #include "func.h"
}

TEST(wlist, pos){
    Func f;
    f.createWallet("test");
    f.createWallet("test2");
    QVector<QString> list = f.wlist();
    QVector<QString> ide;
    ide.push_back("test");
    ide.push_back("test2");
    ASSERT_EQ(list, ide);
    remove("test.txt");
    remove("test2.txt");
}

#endif // WLTEST_H
