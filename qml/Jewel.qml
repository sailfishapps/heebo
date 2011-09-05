import QtQuick 1.0

Rectangle {
    id: jewel

    property int type;
    property bool spawned: false;
    property bool selected: false;
    property bool to_remove: false;
    property bool dying: false;

    property variant xAnim: xAnimation;
    property variant yAnim: yAnimation;

    width: 64; height: 64
    radius: 5.0
    smooth: true
    border {
        width: 5
        color: selected ? "black" : "white"
    }
    
    property color defaultColor:
    type == 1 ? "blue" :
    type == 2 ? "red" :
    type == 3 ? "yellow" :
    type == 4 ? "gray" :
    type == 5 ? "magenta" :
    "white"

    color: defaultColor

    function animationChanged() {
        if (!yAnimation.running && !xAnimation.running)
            screen.animDone();
    }

    function jewelKilled() {
        screen.jewelKilled();
    }

    Behavior on y {
        enabled: spawned;
        SpringAnimation {
            id: yAnimation
            spring: 2
            damping: 0.2
            onRunningChanged: animationChanged();
        }
    }

    Behavior on x {
        enabled: spawned;
        SpringAnimation {
            id: xAnimation
            spring: 2
            damping: 0.2
            onRunningChanged: animationChanged();
        }
    }

    states: [
        State {
            name: "AliveState"
            when: spawned == true && dying == false
        },
        State {
            name: "DyingState"
            when: dying == true //&& !yAnimation.running && !xAnimation.running
            StateChangeScript {
                script: { jewel.destroy(); jewelKilled(); }
            }
        }
    ]
}
