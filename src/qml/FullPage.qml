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

JewelPage {
    id: mainPage
    
    property string mainFont: "Nokia Pure Text"
    property color darkColour:     "#333333"
    property color uiAccentColour: "#D900D9"

    anchors.fill: parent

    ToolBar {
        id: toolBar

        Image {
            id: backButton
            source: "qrc:///images/icon_next_black.png"
            /* width: 64; height: 64 */

            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: pageStack.pop();
                onPressed: backButton.source="qrc:///images/icon_next_pressed.png"
                onReleased: backButton.source="qrc:///images/icon_next_black.png"
            }

        }
    }
}
