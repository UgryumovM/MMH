#ifndef DELETEST_H
#define DELETEST_H

#include <gtest/gtest.h>
#include <fstream>
#include <gmock/gmock-matchers.h>

/* using namespace testing; */
extern "C++" {
    #include "func.h"
}

TEST(delEntry, pos){
    Func f;
    f.createWallet("test");
    f.newEntry("aaa$0&a","test");
    f.newEntry("bbb$1&b","test");
    f.deleteEntry("aaa\n0\na", "test");
    std::fstream file;
    file.open("test.mh", std::ios::in);
    std::string buf;
    getline(file, buf);
    ASSERT_EQ(buf, "bbb$1&b");
    file.close();
    remove("test.mh");
}

#endif // DELETEST_H
