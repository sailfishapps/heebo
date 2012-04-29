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

SOURCES += ../../src/cpp/gameview.cpp ../../src/cpp/heebo.cpp		\
           ../../src/cpp/gamemapset.cpp ../../src/cpp/gamemap.cpp

RESOURCES +=  ../../game80.qrc ../../common.qrc ../../desktop.qrc

# enable booster
# CONFIG += qdeclarative-boostable
# QMAKE_CXXFLAGS += -fPIC -fvisibility=hidden -fvisibility-inlines-hidden
# QMAKE_LFLAGS += -pie -rdynamic
