# -*- makefile -*-

TEMPLATE = app
TARGET = heebo
DEPENDPATH += .
INCLUDEPATH += .
QT += declarative 
OBJECTS_DIR = obj

# Input
HEADERS += ../../src/cpp/gameview.h ../../src/cpp/gamemapset.h	\
           ../../src/cpp/gamemap.h
SOURCES += ../../src/cpp/gameview.cpp ../../src/cpp/heebo.cpp	\
           ../../src/cpp/gamemapset.cpp ../../src/cpp/gamemap.cpp

OTHER_FILES += \
    debian/rules \
    debian/README \
    debian/copyright \
    debian/control \
    debian/compat \
    debian/changelog

RESOURCES += ../../common.qrc ../../game80.qrc ../../harmattan.qrc
DEFINES += HARMATTAN

# Please do not modify the following two lines. Required for deployment.
include(deployment.pri)
qtcAddDeployment()

# enable booster
CONFIG += qdeclarative-boostable
QMAKE_CXXFLAGS += -fPIC -fvisibility=hidden -fvisibility-inlines-hidden
QMAKE_LFLAGS += -pie -rdynamic
