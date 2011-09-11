import QtQuick 1.0
import com.nokia.meego 1.0

import "qrc:///js/jewels.js" as Jewels

JewelPage {
    id: mainPage
    
    property int block_width: Jewels.block_width;
    property int block_height: Jewels.block_height;
    property int toolbar_height: 99

    property int font_size: 42
    
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
            onClicked: Jewels.clicked(mouse.x, mouse.y)
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
            text: "New Game"
            //onClicked: Jewels.startNewGame()
            onClicked: Jewels.nextLevel()
        }
    }
}

