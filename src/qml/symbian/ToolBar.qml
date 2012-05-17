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

Rectangle {
    id: toolBar
    z: 20
    width: parent.width; height: Constants.toolbar_height
    anchors.bottom: parent.bottom

    color: "#000000"

    Rectangle {
        width: parent.width
        height: 1
        anchors.top: parent.top
        anchors.topMargin: 1
        color: "#6B6B6B"
    }
    
    Rectangle {
        width: parent.width
        height: parent.height-2
        anchors.bottom: parent.bottom
        
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#242424" }
            GradientStop { position: 1.0; color: "#0C0C0C" }
        }
    }
}
