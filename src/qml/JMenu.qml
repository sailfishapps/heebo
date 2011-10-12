import QtQuick 1.0
import com.nokia.meego 1.0

Rectangle {
    id: menu

    signal closed

    function toggle() {
        visible ? hide() : show();
    }
    
    function show() {
        menu.opacity = 1;
    }

    function hide() {
        menu.opacity = 0;
        menu.closed();
    }

    border { color: "black"; width: 2 }
    radius: 2

    opacity: 0

    visible: opacity > 0
}
