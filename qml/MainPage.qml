import QtQuick 1.0
import com.nokia.meego 1.0

/* For Desktop */
import "../js/jewels.js" as Jewels
Rectangle {

/* For Harmattan */
// import "qrc:///js/jewels.js" as Jewels
// Page {
        
    id: mainPage

    signal animDone()
    signal jewelKilled();

    SystemPalette { id: activePalette }

    Component.onCompleted: {
        Jewels.startNewGame();
        animDone.connect(Jewels.onChanges);
        jewelKilled.connect(Jewels.onChanges);
        okDialog.closed.connect(Jewels.startNewGame);
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
        width: parent.width; height: 32
        color: activePalette.window
        anchors.bottom: mainPage.bottom

        JewelButton {
            id: startButton
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            text: "New Game"
            onClicked: Jewels.startNewGame()
        }

        // Button {
        //     id: fallButton
        //     anchors {
        //         left: startButton.right
        //         verticalCenter: parent.verticalCenter
        //     }
        //     text: "Fall"
        //     onClicked: Jewels.fallDown()
        // }

        Text {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            text: "Jewels"
        }
    }
}

