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

//-----------------------------------------------------------------------------

.pragma library

// Heebo version
var heebo_version = "0.1.0";
var heebo_description =
    "Simple and addictive \"match 3\" game with quirky characters.";
var heebo_copyright
    = "Copyright 2011 &copy; Mats Sjöberg, Niklas Gustafsson";

var GPL = "Heebo is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.<br/><br/>"+
  "Heebo is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.<br/><br/>"+
    "You should have received a copy of the GNU General Public License along with Heebo.  If not, see <a href=\"http://www.gnu.org/licenses/\">http://www.gnu.org/licenses/</a>.";

// Number of different "jewel" types
var jewel_maxtype = 5;

// Board size
var board_width = 6;
var board_height = 9;

// Block pixel size
var block_width = 80;
var block_height = 80;

// height of toolbar
var toolbar_height = 99;

// Pixels to drag/swipe until it's interpreted as a movement
var move_limit = 5;

// Font settings
var font_family = "Nokia Pure Text";
var fontsize_dialog = 22;
var fontsize_main = 36;

var color_uiaccent = "#D800D8";
var color_dark = "#333333";
var color_main = "#F2F2F2";


//-----------------------------------------------------------------------------
// Utility functions
//-----------------------------------------------------------------------------

Function.prototype.method = function (name, func) {
    this.prototype[name] = func;
    return this;
};

//-----------------------------------------------------------------------------

Number.method('sign', function () {
    return this > 0 ? 1 : this < 0 ? -1 : 0;
});

//-----------------------------------------------------------------------------

Number.method('abs', function () {
    return Math.abs(this);
});

//-----------------------------------------------------------------------------

var isNumber = function (obj) {
    return typeof obj === 'number';
}

