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

FullPage {
    id: mainPage
    
    Image {
        id: logoImage
        source: "qrc:///images/heebo_logo.png";
        anchors {
            top: parent.top
            topMargin: 30
            horizontalCenter: parent.horizontalCenter
        }
    }

    FullPageText {
        id: text1
        text: "HELP"

        anchors.top: logoImage.bottom
    }

    FullPageText {
        id: text2
        text: "FOOBAR"
        style: "title"

        anchors.top: text1.bottom
    }

    FullPageText {
        id: text3
        text: "Hello, world, again"

        anchors.top: text2.bottom
    }

    FullPageText {
        id: text4
        text: "Tiny text"
        style: "small"

        anchors.top: text3.bottom
    }

}
