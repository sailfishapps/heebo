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
    id: block

    property bool cleared: false;
    property bool blocking: false;
    property string wall_border: "0";

    width: Constants.block_width
    height: Constants.block_height
    
    z: blocking ? 1 : -1
    
    source: "qrc:///images/"+(blocking ? "block_wall_1" :
                              cleared ? "block_gold" :
                              "bg" )+".png"
    Image {
        anchors.fill: parent
        opacity: parent.wall_border !== ""
        source: "qrc:///images/"+
                (parent.wall_border==="0" || parent.wall_border==="lock" ?
                 "empty" : "wb_"+parent.wall_border)+".png"
        z: 1
    }
}
