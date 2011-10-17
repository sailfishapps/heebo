/*
  Copyright 2011 Mats Sjöberg
  
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

Rectangle {
    id: container

    property int mode: 0
    
    signal closed(int mode)
    
    function show(text) {
        dialogText.text = text;
        container.opacity = 1;
    }

    function hide() {
        container.opacity = 0;
        container.closed(mode);
    }

    width: dialogText.width + 20
    height: dialogText.height + okButton.height + 40

    border { color: "black"; width: 2 }
    radius: 2

    opacity: 0

    visible: opacity > 0

    Text {
        id: dialogText
        anchors {
            top: parent.top
            left: parent.left
            leftMargin: 10
            topMargin: 10
        }
        text: ""
        font.pixelSize: mainPage.font_size
    }

    JewelButton {
        id: okButton
        anchors {
            top: dialogText.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
        text: "OK"
        onClicked: container.hide()
    }
}
