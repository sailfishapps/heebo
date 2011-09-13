//-----------------------------------------------------------------------------

var jewel_maxtype = 5;

var board_width = 8;
var board_height = 12;

var board = null;
var bg_grid = null;

if (gameview.platform() == "harmattan") {
    var block_width = 60;
    var block_height = 60;
} else {
    var block_width = 48;
    var block_height = 48;
}

var selected = null;

var showingDialog = false;

var randomList = new Array();

//-----------------------------------------------------------------------------

// Constructor for Point objects
function Point(x, y) {
    this.x = x;
    this.y = y;
}

//-----------------------------------------------------------------------------

function init() {
    startNewGame();
}

//-----------------------------------------------------------------------------

function random(from, to) {
    return Math.floor(Math.random()*(to-from+1)+from);
}

//-----------------------------------------------------------------------------

function randomPositions() {
    var arr = new Array();
    for (var j=0; j<board_height; j++) {
        for (var i=0; i<board_width; i++) {
            arr.push(new Point(i,j));
        }
    }

    var newArr = new Array();
    while (arr.length) {
        var r = random(0,arr.length-1);
        var e = arr.splice(r,1);
        newArr.push(e[0]);
    }
    return newArr;
}

//-----------------------------------------------------------------------------

function init2DArray(arr) {
    // Destroy old 2d array if there is such
    if (arr != null) {
        for (var i=0; i<board_width; i++) {
            for (var j=0; j<board_height; j++) {
                if (arr[j][i] != null)
                    arr[j][i].destroy();
            }
        }
        delete arr;
    }
    
    arr = new Array(board_height);
    for (var j=0; j<board_height; j++) 
        arr[j] = new Array(board_width);
    return arr;
}

//-----------------------------------------------------------------------------

function initBoard() {
    board = init2DArray(board);
    bg_grid = init2DArray(bg_grid);
}

//-----------------------------------------------------------------------------

function newBlock(j, i, type) {
    var component = Qt.createComponent("Jewel.qml");
    
    // while (component.status != Component.Ready)
    // {}
    
    var obj = component.createObject(background);
    obj.x = i*block_width;
    obj.y = j*block_height;

    obj.type = type;
    obj.spawned = true;
    board[j][i] = obj;
}

//-----------------------------------------------------------------------------

function newBackgroundBlock(j, i) {
    var component = Qt.createComponent("Block.qml");
    
    // while (component.status != Component.Ready)
    // {}
    
    var obj = component.createObject(background);
    obj.x = i*block_width;
    obj.y = j*block_height;

    bg_grid[j][i] = obj;
}

//-----------------------------------------------------------------------------

function randomBlockType() {
    return random(1,5);
}

//-----------------------------------------------------------------------------

function firstLevel() {
    mapset.level = 0;
    startNewGame();
}

//-----------------------------------------------------------------------------

function nextLevel() {
    mapset.level++;
    startNewGame();
}

//-----------------------------------------------------------------------------

function startNewGame() {
    showingDialog = false;
    initBoard();
    
    for (var i=0; i<jewel_maxtype; i++) {
        randomList[i] = randomPositions();
    }

    for (var j=0; j<board_height; j++)
        for (var i=0; i<board_width; i++)
            newBackgroundBlock(j, i);

    for (var j=0; j<board_height; j++) {
        for (var i=0; i<board_width; i++) {
            var b = mapset.at(j,i);
            if (b)
                bg_grid[j][i].blocking = true;
        }
    }

    for (var j=0; j<board_height; j++) {
        for (var i=0; i<board_width; i++) {
            if (bg_grid[j][i].blocking)
                continue;
            
            var skip1 = 0;
            if (j > 1 && !bg_grid[j-2][i].blocking && !bg_grid[j-1][i].blocking
                && board[j-2][i].type == board[j-1][i].type)
                skip1 = board[j-1][i].type;

            var skip2 = 0;
            if (i > 1 && !bg_grid[j][i-2].blocking && !bg_grid[j][i-1].blocking
                && board[j][i-2].type == board[j][i-1].type)
                skip2 = board[j][i-1].type;

            var type = 0;
            do {
                type = randomBlockType();
            } while (type == skip1 || type == skip2);

            newBlock(j, i, type);
        }
    }
    
    return true;
}

//-----------------------------------------------------------------------------

function isRunning() {
    var running = false;
    for (var j=0; j<board_height && !running; j++) {
        for (var i=0; i<board_width && !running; i++) {
            var obj = board[j][i];
            if (obj == null)
                continue;
            if (obj.xAnim.running || obj.yAnim.running)
                running = true;
        }
    }

    return running;
}

//-----------------------------------------------------------------------------

function clearRandomBlock(block_type) {
    var list = randomList[block_type-1];

    var done = false;
    while (list.length && !done) {
        var p = list.pop();
        var bg = bg_grid[p.y][p.x];

        if (bg.blocking || bg.cleared)
            continue;

        var bb = board[p.y][p.x];
        if (bb != null && bb.type == block_type) {
            bg.cleared = true;
            done = true;
        }        
    } 
}

//-----------------------------------------------------------------------------

function checkBoardOneWay(jmax, imax, rows, mark) {
    var changes = 0;

    // Check rows/columns for subsequent items
    for (var j=0; j<jmax; j++) {
        var last_b = 0;
        var count = 0;
        for (var i=0; i<imax; i++) {
            var obj = rows ? board[j][i] : board[i][j];
            var b = 0;

            if (obj)
                b = obj.type;

            if (b != 0 && last_b == b)
                count++;

            if (last_b != b || i==imax-1) {
                if (count >= 2) {
                    if (mark) {
                        var k_begin = i-count-1;
                        var k_end = i;
                        if (last_b == b) {
                            k_begin++;
                            k_end++;
                        }
                        
                        // console.log("Removing "+(rows?"row":"column")+" "+(j+1)+
                        //             " from "+(k_begin+1)+" to "+k_end);
                        
                        for (var k=k_begin; k<k_end; k++) {
                            if (rows) {
                                board[j][k].to_remove = true;
                                bg_grid[j][k].cleared = true;
                            } else {
                                board[k][j].to_remove = true;
                                bg_grid[k][j].cleared = true;
                            }
                        }

                        while (count >= 3) {
                            clearRandomBlock(last_b);
                            count--;
                        }
                    }
                    changes++;
                }
                count = 0;
            }
            last_b = b;
        }
    }

    return changes;
}

//-----------------------------------------------------------------------------

function fallDown() {
    var changes = 0;
    for (var i=0; i<board_width; i++) {
        var fallDist = 0;
        for (var j=board_height-1; j>=0; j--) {
            if (bg_grid[j][i].blocking) {
                fallDist = 0;
            } else if (board[j][i] == null) {
                fallDist++;
            } else {
                if (fallDist > 0) {
                    var obj = board[j][i];
                    obj.y = (j+fallDist)*block_height;
                    board[j+fallDist][i] = obj;
                    board[j][i] = null;
                    changes++;
                }
            }
        }
    }
    return changes;
}

//-----------------------------------------------------------------------------

function checkBoard(mark) {
    var changes = 0;

    // Check rows for subsequent items
    changes += checkBoardOneWay(board_height, board_width, true, mark);

    // Check columns for subsequent items
    changes += checkBoardOneWay(board_width, board_height, false, mark);

    // If we're just checking, now is a good time to return
    if (!mark)
        return changes;

    // Do actual removal
    for (var j=0; j<board_height; j++) {
        for (var i=0; i<board_width; i++) {
            var obj = board[j][i];
            if (obj != null && obj.to_remove) {
                board[j][i] = null;
                obj.dying = true;
                //console.log("Removed:"+(j+1)+","+(i+1));
            }
        }
    }

    return changes;
}

//-----------------------------------------------------------------------------

function clicked(x, y) {
    if (showingDialog)
        return; 

    var bx = Math.floor(x/block_width);
    var by = Math.floor(y/block_height);

    if (bx < 0 || by < 0 || bx >= block_width || by >= block_height)
        return;
    var obj = board[by][bx];

    var posStr = "("+by+","+bx+")";

    // Click on same object again: unselect
    if (obj != null && obj.selected) {
        obj.selected = false;
        selected = null;
        return;
    }

    // First object to be clicked
    if (!selected) {
        if (obj == null)
            return;
        obj.selected = true;
        selected = obj;
        return;
    }

    if (isRunning())
        return;

    // Second object to be clicked
    selected.selected = false;

    var sx = Math.floor(selected.x/block_width);
    var sy = Math.floor(selected.y/block_height);
    var dx = Math.abs(bx-sx);
    var dy = Math.abs(by-sy);

    if ((dx==1 && dy==0) || (dx==0 && dy == 1)) {
        board[sy][sx] = obj;
        board[by][bx] = selected;

        var changes = checkBoard(false);
        if (changes || obj==null) {
            if (obj != null) {
                obj.x = selected.x;
                obj.y = selected.y;
            }
            selected.x = bx*block_width;
            selected.y = by*block_height;

        } else {
            board[sy][sx] = selected;
            board[by][bx] = obj;
        }
    } else if (obj != null) {
        obj.selected = true;
        selected = obj;
        return;
    }
    selected = null;
}

//-----------------------------------------------------------------------------

function checkNew() {
    for (var i=0; i<board_width; i++) {
        var n=0;
        while (n<board_height && board[n][i] == null &&
               bg_grid[n][i].blocking == false)
            n++;

        for (var j=0; j<n; j++) {
            var component = Qt.createComponent("Jewel.qml");
    
            var obj = component.createObject(background);
            obj.x = i*block_width;
            obj.y = -block_height*(j+1);

            obj.type = randomBlockType();
            obj.spawned = true;
            board[n-j-1][i] = obj;
            obj.y = block_height*(n-j-1);
        }
    }
}

//-----------------------------------------------------------------------------

function onChanges() {
    //console.log("onChanges()");

    fallDown();

    if (!isRunning()) {
        checkNew();
        fallDown();
    }

    if (!isRunning()) 
        checkBoard(true);

    victoryCheck();
}

//-----------------------------------------------------------------------------

function victoryCheck() {
    var victory = true;
    for (var j=0; j<board_height && victory; j++) {
        for (var i=0; i<board_width && victory; i++) {
            victory =
                bg_grid[j][i].cleared || bg_grid[j][i].blocking;
        }
    }

    if (victory) {
        showingDialog = true;
        okDialog.show("Victory! ZÖMG!!");
    }
}
    
