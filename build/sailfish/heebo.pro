# -*- makefile -*-

TEMPLATE = app
TARGET = heebo
DEPENDPATH += .
INCLUDEPATH += .
QT += qml quick
OBJECTS_DIR = obj

# Input
HEADERS += ../../src/cpp/gameview.h ../../src/cpp/gamemapset.h	\
           ../../src/cpp/gamemap.h

SOURCES += ../../src/cpp/gameview.cpp ../../src/cpp/heebo.cpp		\
           ../../src/cpp/gamemapset.cpp ../../src/cpp/gamemap.cpp

RESOURCES +=  ../../game60.qrc ../../common.qrc ../../desktop.qrc

