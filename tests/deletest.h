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
    f.deleteEntry("aaa$0&a", "test");
    std::fstream file;
    file.open("test.txt", std::ios::in);
    std::string buf;
    getline(file, buf);
    ASSERT_EQ(buf, "");
    file.close();
    remove("test.txt");
}

#endif // DELETEST_H
