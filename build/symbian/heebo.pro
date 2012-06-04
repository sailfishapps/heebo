# -*- makefile -*-

TEMPLATE = app
TARGET = heebo
DEPENDPATH += .
INCLUDEPATH += .
QT += declarative 

# Input
HEADERS += ../../src/cpp/gameview.h ../../src/cpp/gamemapset.h	\
           ../../src/cpp/gamemap.h

SOURCES += ../../src/cpp/gameview.cpp ../../src/cpp/heebo.cpp		\
           ../../src/cpp/gamemapset.cpp ../../src/cpp/gamemap.cpp

RESOURCES += ../../common.qrc ../../game60.qrc ../../symbian.qrc

ICON = heebo.svg
TARGET.UID3 = 0x20065C31

# symbian:TARGET.EPOCHEAPSIZE = 0x20000 0x2000000

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
TARGET.CAPABILITY = NONE
DEPLOYMENT.display_name = ""

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable

# Add dependency to Symbian components
CONFIG += qt-components

# Please do not modify the following two lines. Required for deployment.
include(symbian.pri)
qtcAddDeployment()

symbian {
    my_deployment.pkg_prerules += vendorinfo
    my_deployment.pkg_prerules += \
        "; Dependency to Symbian Qt Quick components" \
        "(0x200346DE), 1, 0, 0, {\"Qt Quick components\"}"

    DEPLOYMENT += my_deployment

    vendorinfo += "%{\"Mats Sjoberg\"}" ":\"Mats Sjoberg\""

    TARGET.UID3 += 0x20065C31

    DEPLOYMENT.display_name += Heebo
}
