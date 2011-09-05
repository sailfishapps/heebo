import QtQuick 1.0

Rectangle {
    id: block

    property bool cleared: false;

    width: 64; height: 64

    z: -1
    
    color: cleared ? "lightgray" : "white";
}
