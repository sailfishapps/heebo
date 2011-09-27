import QtQuick 1.0
import com.nokia.meego 1.0

Rectangle {
    id: block

    property bool cleared: false;
    property bool blocking: false;

    width: mainPage.block_width
    height: mainPage.block_height
    
    z: -1
    
    color:
    blocking ? "black" :
    cleared ? "yellow" :
    "#2E2E2F";
}
