import QtQuick 1.0
import com.nokia.meego 1.0

Item {
    id: jewel

    width: mainPage.block_width
    height: mainPage.block_height

    property int type;
    property bool spawned: false;
    property bool selected: false;
    property bool to_remove: false;
    property bool dying: false;

    property variant xAnim: xAnimation;
    property variant yAnim: yAnimation;

    Image {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        
        width: jewel.width; height: jewel.width

        source: "qrc:///images/"+(
        type == 1 ? "circle" :
        type == 2 ? "polygon" :
        type == 3 ? "square" :
        type == 4 ? "triangle_down" :
        type == 5 ? "triangle_up" :
        "empty")+".png"
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
