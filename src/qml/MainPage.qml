import QtQuick 1.0

import "qrc:///js/jewels.js" as Jewels

JewelPage {
    id: mainPage
    
    property int block_width: Jewels.block_width;
    property int block_height: Jewels.block_height;
    property int toolbar_height: 99

    property int font_size: 42

    property bool isRunning: false
    
    signal animDone()
    signal jewelKilled();
    
    SystemPalette { id: activePalette }

    Component.onCompleted: {
        Jewels.init();
        animDone.connect(Jewels.onChanges);
        jewelKilled.connect(Jewels.onChanges);
        okDialog.closed.connect(Jewels.nextLevel);
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
        color: activePalette.window
        anchors.bottom: mainPage.bottom

        JewelButton {
            id: startButton
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
                leftMargin: 20
                rightMargin: 20
            }
            text: "Menu"
            onClicked: mainMenu.toggle()
            /* onClicked: Jewels.nextLevel() */
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
            JMenuItem { text: "About" }
        }
    }

}

