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

import QtQuick 2.0

import "qrc:///js/constants.js" as Constants
import "qrc:///js/constants_platform.js" as ConstantsP

MainPage {
/* These are to test full screen pages on desktop which doesn't have
   Harmattan's pagestacks. */
/* AboutPage { */
/* HelpPage { */
    id: mainPage
    width: Constants.block_width*Constants.board_width
    height: Constants.block_height*Constants.board_height+ConstantsP.toolbar_height
}
