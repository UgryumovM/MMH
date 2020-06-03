#ifndef NEWETEST_H
#define NEWETEST_H

#include <gtest/gtest.h>
#include <fstream>
#include <gmock/gmock-matchers.h>

/* using namespace testing; */
extern "C++" {
    #include "func.h"
}

TEST(newEntry, pos){
    Func f;
    f.createWallet("test");
    f.newEntry("aaa","test");
    std::fstream file;
    file.open("test.mh", std::ios::in);
    std::string buf;
    getline(file, buf);
    ASSERT_EQ(buf, "aaa");
    file.close();
    remove("test.mh");
}

#endif // NEWETEST_H
