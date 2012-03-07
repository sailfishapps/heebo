/*
  Copyright 2012 Mats Sjöberg
  
  This file is part of the Heebo programme.
  
  Heebo is free software: you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  
  Heebo is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
  License for more details.
  
  You should have received a copy of the GNU General Public License
  along with Heebo.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 1.0

import "qrc:///js/constants.js" as Constants

Image {
    id: container

    property int mode: 0
    
    signal closed(int mode)
    signal opened
    
    function show(text, answer) {
        dialogText.text = text;
        answerText.text = answer;
        container.opacity = 1;
        container.opened()
    }

    function hide() {
        container.opacity = 0;
        container.closed(mode);
    }

    function isClosed() {
        return container.opacity === 0;
    }

    opacity: 0
    visible: opacity > 0

    source: "qrc:///images/dialog_small.png"
        
    Text {
        id: dialogText
        text: ""

        font.family: Constants.font_family
        font.pixelSize: Constants.fontsize_dialog
        font.bold: true
        color: Constants.color_dark

        width: container.paintedWidth-60
        wrapMode: Text.Wrap
        
        anchors {
            top: parent.top
            left: parent.left
            leftMargin: 30
            rightMargin: 30
            topMargin: 30
            bottomMargin: 10
        }
    }

    Item {
        id: answerItem
        anchors {
            horizontalCenter: container.horizontalCenter
            bottom: container.bottom
            bottomMargin: 25
        }

        width: answerText.paintedWidth + buttonImage.paintedWidth+50
        height: 84
        
        Text {
            id: answerText
            text: "OK!"
            font.family: Constants.font_family
            font.pixelSize: Constants.fontsize_dialog
            color: Constants.color_uiaccent
            anchors {
                verticalCenter: answerItem.verticalCenter
                left: answerItem.left
            }
        }

        Image {
            id: buttonImage
            source: "qrc:///images/icon_next_black.png"

            anchors {
                verticalCenter: answerItem.verticalCenter
                left: answerText.right
                leftMargin: 30
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: container.hide()
        onPressed: buttonImage.source="qrc:///images/icon_next_pressed.png"
        onReleased: buttonImage.source="qrc:///images/icon_next_black.png"
    }
}
