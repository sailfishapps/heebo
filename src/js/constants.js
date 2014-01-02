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

//-----------------------------------------------------------------------------

.pragma library

Qt.include("qrc:///js/constants_platform.js")

//-----------------------------------------------------------------------------

// Number of different "jewel" types
var jewel_maxtype = 5;

// Board size
var board_width = 6;
var board_height = 9;

// Pixels to drag/swipe until it's interpreted as a movement
var move_limit = 5;

// Font settings
var font_family = "Arial";
var fontsize_dialog = 22;
var fontsize_main = 36;

var color_uiaccent = "#D800D8";
var color_dark = "#333333";
var color_main = "#F2F2F2";

//-----------------------------------------------------------------------------
// Dialog messages
//-----------------------------------------------------------------------------

var level_text_num = 7;
var level_text = [];
var level_answer = [];

level_text[0]   = "ZÖMG! You just cleared that level! "+
                  "The next one won't be that easy!";
level_answer[0] = "Yeah, right!";

level_text[1]   = "OH NOES! That level was too eeeasy! "+
                  "Let’s crank it up a notch!";
level_answer[1] = "Next one, plz!";

level_text[2]   = "WHOOPS! That one almost cleared itself! "+
                  "Don’t worry, the next one won't be that easy!";
level_answer[2] = "Neeext!";

level_text[3]   = "That level was no match for your superior intellect! "+
                  "Next one will be more formidable!";
level_answer[3] = "BAZZINGA!";

level_text[4]   = "WHOA! You just PWNED that level! "+
                  "Don’t get cocky, 'cos the next one will fight back!";
level_answer[4] = "Let’s go get sum’!";

level_text[5]   = "LÖL! That level was no match for your powers! "+
                  "But the next one will make you WEEP!";
level_answer[5] = "Bring it on, baby!";

level_text[6]   = "NOM! That level was just for starters! "+
                  "The next one will be the real lunch!";
level_answer[6] = "I’m still hungry!";


var last_level_msg    = "That was the last level!\n"+
                        "You PWNED the game!\n"+
                        "CONGRATULASHUNS!!1";
var last_level_answer = "ZÖMG!!";

//-----------------------------------------------------------------------------
// About
//-----------------------------------------------------------------------------

var heebo_version = "1.2";
var heebo_description =
    "Simple and addictive Match 3 game with quirky characters.";
var heebo_copyright
    = "Copyright 2012 &copy; Mats Sjöberg, Niklas Gustafsson<br/><br/>"+
"All the source code and game level maps for Heebo are licensed under GPLv3. All graphics are licensed under CC-BY-SA.<br/><br/>The source code can be downloaded from <a style=\"color: "+color_uiaccent+"\" href=\"http://gitorious.org/heebo\">http://gitorious.org/heebo</a><br/><br/>";

var code_license =
    "This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.<br/><br/>"+
    "This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.<br/><br/>"+
    "You should have received a copy of the GNU General Public License along with this program.  If not, see <a style=\"color: "+color_uiaccent+"\" href=\"http://www.gnu.org/licenses/\">http://www.gnu.org/licenses/</a>.";

var graphics_license = "All graphics in Heebo are licensed under the <a style=\"color: "+color_uiaccent+"\" href=\"http://creativecommons.org/licenses/by-sa/3.0/\">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.";

var heebo_credit_coding = "<i>Cöde</i><br\><b>Mats Sj&ouml;berg</b><br\>mats@sjoberg.fi<br/><a style=\"color: "+color_uiaccent+"\" href=\"http://www.sjoberg.fi/mats/\">www.sjoberg.fi/mats</a>";


var heebo_credit_graphics = "<i>Gräphix</i><br\><b>Niklas Gustafsson</b><br\>nikui@nikui.net<br/><a style=\"color: "+color_uiaccent+"\" href=\"http://www.nikui.net/\">www.nikui.net</a>";

//-----------------------------------------------------------------------------
// Help
//-----------------------------------------------------------------------------

var heebo_help_topic_1 = "Match them blocks!";
var heebo_help_1 = "Get three or more blocks of the same colour in a line. Blocks can be swapped by flicking over them. You can only swap blocks when either one of them will line up with three or more in a line. You can also move a block into an empty tile.";

var heebo_help_topic_2 = "Turn all gold!";
var heebo_help_2 = "When three or more blocks of the same colour line up they will explode and turn the background into gold plates! To win a level you must turn all background tiles golden.";

var heebo_help_topic_3 = "Bonus sweetie";
var heebo_help_3 = "If you explode more than three blocks in a line, a bonus background tile with a same colour block on it will be turned into gold. This is handy to get to those last hard-to-reach tiles!";

var heebo_help_topic_4 = "Locked blocks";
var heebo_help_4 = "In the later levels some blocks are locked and can't be moved.  Free them by matching them up with two or more other blocks of the same colour! Some times there are two locks, then you need to match them up twice.";

var heebo_help_5 = "Now go flip some blocks!!";

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

