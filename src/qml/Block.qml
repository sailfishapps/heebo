import QtQuick 1.0

Image {
    id: block

    property bool cleared: false;
    property bool blocking: false;
    property string wall_border: "0";

    width: mainPage.block_width
    height: mainPage.block_height
    
    z: blocking ? 1 : -1
    
    source: "qrc:///images/"+(blocking ? "block_wall_1" :
                              cleared ? "block_gold" :
                              "bg" )+".png"
    Image {
        anchors.fill: parent
        opacity: parent.wall_border !== ""
        source: "qrc:///images/"+
                (parent.wall_border==="0" ?
                 "empty" : "wb_"+parent.wall_border)+".png"
        z: 1
    }
}
