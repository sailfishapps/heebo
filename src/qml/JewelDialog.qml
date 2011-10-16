import QtQuick 1.0

Rectangle {
    id: container

    property int mode: 0
    
    signal closed(int mode)
    
    function show(text) {
        dialogText.text = text;
        container.opacity = 1;
    }

    function hide() {
        container.opacity = 0;
        container.closed(mode);
    }

    width: dialogText.width + 20
    height: dialogText.height + okButton.height + 40

    border { color: "black"; width: 2 }
    radius: 2

    opacity: 0

    visible: opacity > 0

    Text {
        id: dialogText
        anchors {
            top: parent.top
            left: parent.left
            leftMargin: 10
            topMargin: 10
        }
        text: ""
        font.pixelSize: mainPage.font_size
    }

    JewelButton {
        id: okButton
        anchors {
            top: dialogText.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
        text: "OK"
        onClicked: container.hide()
    }
}
