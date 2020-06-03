include(gtest_dependency.pri)

TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG += thread
CONFIG += c++11
QT += quick
QMAKE_CXXFLAGS += -Wall -Wextra -Werror
QMAKE_CFLAGS += -Wall -Wextra -Werror

# gcov
QMAKE_CXXFLAGS += -fprofile-arcs -ftest-coverage
QMAKE_CFLAGS += -fprofile-arcs -ftest-coverage
LIBS += -lgcov
LIBS += -lstdc++fs

INCLUDEPATH += ../app

SOURCES += \
    ../app/func.cpp \
    main.cpp

HEADERS += \
    ../app/func.h \
    cwaltest.h \
    deletest.h \
    dwaltest.h \
    getbtest.h \
    getdtest.h \
    gontest.h \
    gwntest.h \
    newetest.h \
    wltest.h




