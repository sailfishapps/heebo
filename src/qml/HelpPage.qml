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

import "../js/constants.js" as Constants

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
        contentHeight: /*logoImage.height + */titleText.paintedHeight +
                       help_text_1.paintedHeight + help_text_2.paintedHeight +
                       help_text_3.paintedHeight + help_text_4.paintedHeight +
                       help_text_5.paintedHeight + 30*8
        
        /* Image { */
        /*     id: logoImage */
        /*     source: "qrc:///images/heebo_logo.png"; */
        /*     anchors { */
        /*         top: parent.top */
        /*         topMargin: 30 */
        /*         horizontalCenter: parent.horizontalCenter */
        /*     } */
        /* } */

        FullPageText {
            id: titleText
            text: "HELP"
            style: "header"

            anchors.top: parent.top /* logoImage.bottom*/
        }

        FullPageText {
            id: help_text_1
            text: Constants.heebo_help_1
            anchors.top: titleText.bottom
        }

        FullPageText {
            id: help_text_2
            text: Constants.heebo_help_2
            anchors.top: help_text_1.bottom
        }

        FullPageText {
            id: help_text_3
            text: Constants.heebo_help_3
            anchors.top: help_text_2.bottom
        }

        FullPageText {
            id: help_text_4
            text: Constants.heebo_help_4
            anchors.top: help_text_3.bottom
        }

        FullPageText {
            id: help_text_5
            text: Constants.heebo_help_5
            style: "emphasis"
            anchors.top: help_text_4.bottom
        }
    }
    ScrollBar {
        flickableItem: flickList
    }

}
