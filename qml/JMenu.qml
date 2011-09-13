import QtQuick 1.0
import com.nokia.meego 1.0

Rectangle {
    id: menu

    signal closed
    
    function show() {
        menu.opacity = 1;
    }

    function hide() {
        menu.opacity = 0;
        menu.closed();
    }

    // width: dialogText.width + 20
    // height: dialogText.height + okButton.height + 40

    border { color: "black"; width: 2 }
    radius: 2

    opacity: 0

    visible: opacity > 0
}
