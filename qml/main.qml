import QtQuick 1.0

import "../js/jewels.js" as Jewels

Rectangle {
    id: screen
    width: 512; height: 544

    SystemPalette { id: activePalette }

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
        width: parent.width; height: 32
        color: activePalette.window
        anchors.bottom: screen.bottom

        Button {
            id: startButton
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            text: "New Game"
            onClicked: Jewels.startNewGame()
        }

        Button {
            id: checkButton
            anchors {
                left: startButton.right
                verticalCenter: parent.verticalCenter
            }
            text: "Check"
            onClicked: Jewels.checkBoard()
        }

        Button {
            anchors {
                left: checkButton.right
                verticalCenter: parent.verticalCenter
            }
            text: "Fall"
            onClicked: Jewels.fallDown()
        }

        Text {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            text: "Foobar"
        }
    }
}
