import QtQuick 1.0
import com.nokia.meego 1.0

Rectangle {
    id: block

    property bool cleared: false;
    property bool blocking: false;

    width: 60; height: 60

    z: -1
    
    color:
    blocking ? "black" :
    cleared ? "lightgray" :
    "white";
}
