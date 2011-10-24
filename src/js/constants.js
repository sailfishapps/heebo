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

//-----------------------------------------------------------------------------
// About
//-----------------------------------------------------------------------------

var heebo_version = "0.1.1";
var heebo_description =
    "Simple and addictive \"match 3\" game with quirky characters.";
var heebo_copyright
    = "Copyright 2011 &copy; Mats Sjöberg, Niklas Gustafsson";

var code_license =
    "All the source code and game level maps for Heebo are licensed under GPLv3.<br/><br/>"+
    "This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.<br/><br/>"+
    "This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.<br/><br/>"+
    "You should have received a copy of the GNU General Public License along with this program.  If not, see <a href=\"http://www.gnu.org/licenses/\">http://www.gnu.org/licenses/</a>.";

var graphics_license = "All graphics in Heebo is licensed under Nääk doesn't know yet, jeebus.";

var heebo_credit_coding = "<i>Cöde</i><br\><b>Mats Sj&ouml;berg</b><br\>mats@sjoberg.fi<br/>sazius on identi.ca";


var heebo_credit_graphics = "<i>Gräphix</i><br\><b>Niklas Gustafsson</b><br\>nikui@nikui.net";

//-----------------------------------------------------------------------------
// Help
//-----------------------------------------------------------------------------

var heebo_help_1 = "<i>Try to get three or more blocks of the same colour in a line.</i> In order to do that you can switch two blocks by a flicking movement of the finger. The trouble is that you can only switch blocks when either one of them will line up with three or more in a line. Just try it, and you'll get the drift!";

var heebo_help_2 = "When you get three or more blocks of the same colour in a line they will explode and turn the floor under them into gold plates.  <i>To win the level you'll need to turn all floor plates into gold!</i>";

var heebo_help_3 = "New blocks will fall down from the first row, unless there are walls in the way.  Sometimes when there are walls in the way, you might have to stack up blocks to reach those highest floor tiles!";

var heebo_help_4 = "If you get more than three in a line, as a bonus more floor plates will be turned into gold.  For example if you get four in a line, one additional floor plate where a block of the same colour resides will be turned into gold.  For five in a line it's two additional blocks, and so on. <i>This is really handy when you've got that one last block to clear and you just can't reach it!</i>";

var heebo_help_5 = "Now go flip some blocks!!";

//-----------------------------------------------------------------------------

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

