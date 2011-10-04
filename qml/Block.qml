import QtQuick 1.0
import com.nokia.meego 1.0

Image {
    id: block

    property bool cleared: false;
    property bool blocking: false;

    width: mainPage.block_width
    height: mainPage.block_height
    
    z: blocking ? 1 : -1
    
    source: "qrc:///images/"+(blocking ? "empty" :
                              cleared ? "block_gold" :
                              "bg" )+".png"
}
