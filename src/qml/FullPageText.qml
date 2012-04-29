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

Text {
    property string style: "normal"
    
    font.pixelSize: style === "header" ? 48 :
                    style === "title"  ? 26 :
                    style === "small"  ? 18 :
                    style === "emphasis" ? 26 :
                    24
    font.bold: style === "title" || style === "header" || style == "emphasis"
    font.family: Constants.font_family
    color: Constants.color_info

    textFormat: Text.RichText
    wrapMode: Text.Wrap

    onLinkActivated: Qt.openUrlExternally(link)
    
    anchors {
        topMargin: 30
        left: parent.left
        leftMargin: 25
    }
    width: parent.width-50
}
