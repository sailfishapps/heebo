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

import "qrc:///js/constants.js" as Constants

FullPage {
    id: mainPage
    Flickable {
        id: flickList
        anchors { top: parent.top; 
                  left: parent.left; right: parent.right }
        height: parent.height-99
        clip: true
        flickableDirection: Flickable.VerticalFlick
        contentWidth: parent.width
        contentHeight: logoImage.height + versionText.paintedHeight +
        cred1Text.paintedHeight + cred2Text.paintedHeight +
        gplText.paintedHeight + 30*6
        
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
            id: versionText
            text: "Version "+Constants.heebo_version
            style: "small"
            anchors.top: logoImage.bottom
            horizontalAlignment: Text.AlignHCenter
        }


        FullPageText {
            id: cred1Text
            text: "<i>Häxxoring</i><br\><b>Mats Sj&ouml;berg</b><br\>"+
            "mats@sjoberg.fi<br\>sazius@identi.ca"

            anchors.top: versionText.bottom
            horizontalAlignment: Text.AlignHCenter
        }

        FullPageText {
            id: cred2Text
            text: "<i>Gräffix</i><br\><b>Niklas Gustafsson</b><br\>nikui@nikui.net"

            anchors.top: cred1Text.bottom
            horizontalAlignment: Text.AlignHCenter
        }
        FullPageText {
            id: gplText
            text: Constants.heebo_copyright+"<br/><br/>"+Constants.GPL
            style: "small"

            anchors.top: cred2Text.bottom
        }
    }
    ScrollBar {
        flickableItem: flickList
    }
}
