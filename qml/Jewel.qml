import QtQuick 1.0

Rectangle {
    id: jewel

    property int type;
    property bool spawned: false;
    property bool selected: false;
    property bool to_remove: false;

    width: 64; height: 64
    radius: 5.0
    smooth: true
    border {
        width: 5
        color: selected ? "gray" : "white"
    }
    
    color:
    type == 1 ? "blue" :
    type == 2 ? "red" :
    type == 3 ? "yellow" :
    "white"

    Behavior on y {
        enabled: spawned;
        SpringAnimation { spring: 2; damping: 0.2 }
    }
    Behavior on x {
        enabled: spawned;
        SpringAnimation { spring: 2; damping: 0.2 }
    }
}
