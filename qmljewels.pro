# -*- makefile -*-

TEMPLATE = app
TARGET = qmljewels
DEPENDPATH += .
INCLUDEPATH += .
QT += declarative 

# Input
HEADERS += gameview.h gamemapset.h gamemap.h
SOURCES += gameview.cpp qmljewels.cpp gamemapset.cpp gamemap.cpp

# {
# 	target.path = /opt/qmljewels/bin
#         INSTALLS += target
# }

OTHER_FILES += \
    js/jewels.js \
    qml/JewelButton.qml \
    qml/Jewel.qml \
    qml/Block.qml \
    qml/JewelDialog.qml \
    qml/MainPage.qml \
    qml/main_harmattan.qml \
    qmljewels.desktop \
    qmljewels.svg \
    debian/rules \
    debian/README \
    debian/copyright \
    debian/control \
    debian/compat \
    debian/changelog

RESOURCES += \
    res.qrc

# Please do not modify the following two lines. Required for deployment.
include(deployment.pri)
qtcAddDeployment()

# enable booster
CONFIG += qdeclarative-boostable
QMAKE_CXXFLAGS += -fPIC -fvisibility=hidden -fvisibility-inlines-hidden
QMAKE_LFLAGS += -pie -rdynamic
