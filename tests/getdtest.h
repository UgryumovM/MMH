#ifndef GETDTEST_H
#define GETDTEST_H

#include <gtest/gtest.h>
#include <gmock/gmock-matchers.h>

/* using namespace testing; */
extern "C++" {
    #include "func.h"
}

TEST(getData, pos){
    Func f;
    f.createWallet("test");
    f.newEntry("aaa$10&a","test");
    f.newEntry("bbb$30.2&a","test");
    f.newEntry("ccc$-5&a","test");
    QStringList list = f.getData("test");
    QStringList ide;
    ide.push_back("ccc\n-5\na\n");
    ide.push_back("bbb\n30.2\na\n");
    ide.push_back("aaa\n10\na\n");
    ASSERT_EQ(list, ide);
    remove("test.mh");
}

#endif // GETDTEST_H
