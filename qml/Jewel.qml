import QtQuick 1.0
import com.nokia.meego 1.0

Item {
    width: 60; height: 60
    id: jewel

    property int type;
    property bool spawned: false;
    property bool selected: false;
    property bool to_remove: false;
    property bool dying: false;

    property variant xAnim: xAnimation;
    property variant yAnim: yAnimation;

    Rectangle {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        
        width: 48; height: 48
        radius: 5.0
        smooth: true
        border {
            width: 5
            color: selected ? "black" : "transparent"
        }
    
        property color defaultColor:
        type == 1 ? "blue" :
        type == 2 ? "red" :
        type == 3 ? "yellow" :
        type == 4 ? "gray" :
        type == 5 ? "magenta" :
        "white"
        
        color: defaultColor
    }
    
    function animationChanged() {
        if (!yAnimation.running && !xAnimation.running)
            mainPage.animDone();
    }

    function jewelKilled() {
        mainPage.jewelKilled();
    }

    Behavior on y {
        enabled: spawned;
        SmoothedAnimation {
            id: yAnimation
            duration: 500
            onRunningChanged: animationChanged();
        }
    }

    Behavior on x {
        enabled: spawned;
        SmoothedAnimation {
            id: xAnimation
            duration: 500
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
