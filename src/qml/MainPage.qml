/*
  Copyright 2011 Mats Sjöberg
  
  This file is part of the Heebo programme.
  
  Heebo is free software: you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  
  Heebo is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
  License for more details.
  
  You should have received a copy of the GNU General Public License
  along with Heebo.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 1.0

import "qrc:///js/constants.js" as Constants
import "qrc:///js/jewels.js" as Jewels

JewelPage {
    id: mainPage
    
    property real buttonOffset: 0.0

    property bool isRunning: false
    
    signal animDone()
    signal jewelKilled();
    
    SystemPalette { id: activePalette }

    Component.onCompleted: {
        Jewels.init();
        animDone.connect(Jewels.onChanges);
        jewelKilled.connect(Jewels.onChanges);
        okDialog.closed.connect(Jewels.dialogClosed);
        /* okDialog.closed.connect(tintRectangle.hide); */
        okDialog.opened.connect(tintRectangle.show);

        /* These are for testing dialogs, menu easily. */
        /* okDialog.mode = 42; */
        /* okDialog.show("ZÖMG! You just cleared that level! "+ */
        /*               "The next one won't be that easy!", */
        /*               "Yeah, right!"); */

        /* mainMenu.show() */
    }

    function openFile(file) {
        var component = Qt.createComponent(file)

        if (component.status == Component.Ready)
            pageStack.push(component);
        else
            console.log("Error loading component:", component.errorString());
    }

    JewelDialog {
        id: okDialog
        anchors.centerIn: background
        z: 50
    }

    Item {
        id: background;
        width: parent.width
        anchors { top: parent.top; bottom: toolBar.top }

        MouseArea {
            anchors.fill: parent
            onPressed: Jewels.mousePressed(mouse.x, mouse.y)
            onPositionChanged: if (pressed) Jewels.mouseMoved(mouse.x, mouse.y)
        }
    }

    ToolBar {
        id: toolBar

        Row {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: 100
            }
            Text {
                text: "Level: "
                font.family: Constants.font_family
                font.pixelSize: Constants.fontsize_main
                color: Constants.color_uiaccent
            }
            Text {
                id: currentLevelText
                text: "??"
                font.family: Constants.font_family
                font.pixelSize: Constants.fontsize_main
                color: Constants.color_main
            }                
            Text {
                text: "/"
                font.family: Constants.font_family
                font.pixelSize: Constants.fontsize_main
                color: Constants.color_uiaccent
            }                
            Text {
                id: lastLevelText
                text: "??"
                font.family: Constants.font_family
                font.pixelSize: Constants.fontsize_main
                color: Constants.color_main
            }                
        }
        Image {
            id: menuButton
            source: "qrc:///images/icon_menu.png"
            width: 64; height: 64

            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: -40*mainPage.buttonOffset
                rightMargin: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: mainMenu.toggle()
                onPressed: menuButton.source="qrc:///images/icon_menu_pressed.png"
                onReleased: menuButton.source="qrc:///images/icon_menu.png"
            }

            Behavior on anchors.verticalCenterOffset {
                SpringAnimation {
                    epsilon: 0.25
                    damping: 0.1
                    spring: 3
                }
            }

        }
    }

    Rectangle {
        id: tintRectangle
        anchors.fill: parent
        color: "#3399FF"
        opacity: 0.0
        visible: opacity > 0

        z: 10

        function show() {
            var colors = ["#3399FF", "#11FF00", "#7300E6", "#FF3C26",
                          "#B300B3" /*, "#FFD500"*/];

            tintRectangle.color = colors[Jewels.random(0,4)];
            tintRectangle.opacity = 0.65;
        }

        function hide() {
            tintRectangle.opacity = 0;
        }            

        MouseArea {
            anchors.fill: parent
            onClicked: {
                mainMenu.hide();
                if (!okDialog.isClosed())
                  okDialog.hide();
            }
        }

        Behavior on opacity {
            SmoothedAnimation { velocity: 2.0 }
        }
    }

   Image {
        id: mainMenu
        z: 50

        source: "qrc:///images/main_menu_bg.png"

        signal closed

        function toggle() {
            visible ? hide() : show();
        }
    
        function show() {
            mainMenu.opacity = 1;
            tintRectangle.show();
            mainPage.buttonOffset = 1.0;
        }
        
        function hide() {
            mainMenu.opacity = 0;
            tintRectangle.hide();
            mainMenu.closed();
            mainPage.buttonOffset = 0.0;
        }

        opacity: 0
        visible: opacity > 0
        
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: -16
        }

        Image {
            source: "qrc:///images/heebo_logo.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.baseline: parent.top
            anchors.baselineOffset: -32
        }

        Grid {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10
            columns: 2

            MenuButton {
                text: "New game"
                buttonImage: "qrc:///images/icon_newgame.png"
                pressedButtonImage: "qrc:///images/icon_newgame_pressed.png"
                onClicked: { mainMenu.hide(); Jewels.firstLevel() }
            }
            MenuButton {
                text: "Restart level"
                buttonImage: "qrc:///images/icon_restart.png"
                pressedButtonImage: "qrc:///images/icon_restart_pressed.png"
                onClicked: { mainMenu.hide(); Jewels.startNewGame() }
            }

            MenuButton {
                text: "Help"
                buttonImage: "qrc:///images/icon_help.png"
                pressedButtonImage: "qrc:///images/icon_help_pressed.png"
                onClicked: { mainMenu.hide(); openFile("HelpPage.qml") }
                /* For testing levels... */
                /* onClicked: { mainMenu.hide(); Jewels.nextLevel() } */
            }
            MenuButton {
                text: "About"
                buttonImage: "qrc:///images/icon_about.png"
                pressedButtonImage: "qrc:///images/icon_about_pressed.png"
                onClicked: { mainMenu.hide(); openFile("AboutPage.qml") }
            }
        }
    }

}

