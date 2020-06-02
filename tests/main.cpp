#include "cwaltest.h"
#include "gwntest.h"
#include "dwaltest.h"
#include "wltest.h"
#include "newetest.h"
#include "deletest.h"
#include "gontest.h"
#include "getbtest.h"
#include "getdtest.h"

#include <gtest/gtest.h>

int main(int argc, char *argv[]){
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
