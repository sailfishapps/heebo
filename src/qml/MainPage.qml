import QtQuick 1.0

import "qrc:///js/jewels.js" as Jewels

JewelPage {
    id: mainPage
    
    property int block_width: Jewels.block_width;
    property int block_height: Jewels.block_height;
    property int toolbar_height: 99

    property string mainFont: "Nokia Pure Text"
    property int mainFontSize: 36
    property color uiAccentColour: "#D800D8"
    property color mainFontColour: "#F2F2F2"

    property int font_size: 42

    property bool isRunning: false
    
    signal animDone()
    signal jewelKilled();
    
    SystemPalette { id: activePalette }

    Component.onCompleted: {
        Jewels.init();
        animDone.connect(Jewels.onChanges);
        jewelKilled.connect(Jewels.onChanges);
        okDialog.closed.connect(Jewels.dialogClosed);
    }

    JewelDialog {
        id: okDialog
        anchors.centerIn: parent
        z: 10
    }

    Item {
        id: background;
        width: parent.width
        anchors { top: parent.top; bottom: toolBar.top }

        MouseArea {
            anchors.fill: parent
            onPressed: Jewels.mousePressed(mouse.x, mouse.y)
            /* onReleased: Jewels.released(mouse.x, mouse.y) */
            onPositionChanged: if (pressed) Jewels.mouseMoved(mouse.x, mouse.y)
        }
    }

    Rectangle {
        id: toolBar
        width: parent.width; height: mainPage.toolbar_height
        //color: activePalette.window
        anchors.bottom: mainPage.bottom

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#0C0C0C" }
            GradientStop { position: 1.0; color: "#242424" }
        }

        Row {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: 100
            }
            Text {
                text: "Level: "
                font.family: mainPage.mainFont
                font.pixelSize: mainPage.mainFontSize
                color: mainPage.uiAccentColour
            }
            Text {
                id: currentLevelText
                text: "??"
                font.family: mainPage.mainFont
                font.pixelSize: mainPage.mainFontSize
                color: mainPage.mainFontColour
            }                
            Text {
                text: "/"
                font.family: mainPage.mainFont
                font.pixelSize: mainPage.mainFontSize
                color: mainPage.uiAccentColour
            }                
            Text {
                id: lastLevelText
                text: "??"
                font.family: mainPage.mainFont
                font.pixelSize: mainPage.mainFontSize
                color: mainPage.mainFontColour
            }                
        }
        Image {
            id: menuButton
            source: "qrc:///images/icon_menu.png"
            width: 64; height: 64
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: mainMenu.toggle()
            }
        }
    }

    JMenu {
        id: mainMenu
        
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: menuLayout.width+40
        height: menuLayout.height+40
        
        JMenuLayout {
            id: menuLayout
            JMenuItem {
                text: "Restart Level"
                onClicked: Jewels.startNewGame()
            }
            JMenuItem {
                text: "New Game"
                onClicked: Jewels.firstLevel()
            }
            JMenuItem {
                text: "Help"
                onClicked: Jewels.reshuffleBlocks()
            }
            JMenuItem {
                text: "About"
                onClicked: Jewels.nextLevel()
            }
        }
    }

}

