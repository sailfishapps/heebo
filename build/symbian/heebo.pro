# -*- makefile -*-

TEMPLATE = app
TARGET = heebo
DEPENDPATH += .
INCLUDEPATH += .
QT += declarative 
#OBJECTS_DIR = obj

# Input
HEADERS += ../../src/cpp/gameview.h ../../src/cpp/gamemapset.h	\
           ../../src/cpp/gamemap.h

SOURCES += ../../src/cpp/gameview.cpp ../../src/cpp/heebo.cpp		\
           ../../src/cpp/gamemapset.cpp ../../src/cpp/gamemap.cpp

RESOURCES += ../../symbian.qrc ../../symbian2.qrc

# enable booster
#CONFIG += qdeclarative-boostable
#QMAKE_CXXFLAGS += -fPIC -fvisibility=hidden -fvisibility-inlines-hidden
#QMAKE_LFLAGS += -pie -rdynamic

# Add more folders to ship with the application, here
#folder_01.source = ../../../src/qml/desktop
#folder_01.target = qml
#DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
#QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE5EB7848
# symbian:TARGET.EPOCHEAPSIZE = 0x20000 0x2000000

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
#symbian:TARGET.CAPABILITY += NetworkServices

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable

# Add dependency to Symbian components
# CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
#SOURCES += main.cpp

# Please do not modify the following two lines. Required for deployment.
include(symbian.pri)
qtcAddDeployment()
