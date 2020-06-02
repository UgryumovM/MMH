TEMPLATE = subdirs

CONFIG -= app_bundle

SUBDIRS = app tests
#DISTFILES += sonar-project.properties

QMAKE_CXXFLAGS += -fprofile-arcs -ftest-coverage -O0

CONFIG += ordered
