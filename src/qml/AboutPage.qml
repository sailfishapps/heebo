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
        copyrightText.paintedHeight + gplText.paintedHeight + 30*8
        
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
            text: Constants.heebo_credit_coding

            anchors.top: versionText.bottom
            horizontalAlignment: Text.AlignHCenter
        }

        FullPageText {
            id: cred2Text
            text: Constants.heebo_credit_graphics

            anchors.top: cred1Text.bottom
            horizontalAlignment: Text.AlignHCenter
        }

        FullPageText {
            id: copyrightText
            text: Constants.heebo_copyright
            anchors.top: cred2Text.bottom
            anchors.topMargin: 50
        }

        FullPageText {
            id: gplText
            text: Constants.code_license+"<br/><br/>"+Constants.graphics_license
            style: "small"
            anchors.top: copyrightText.bottom
        }
    }
    ScrollBar {
        flickableItem: flickList
    }
}
