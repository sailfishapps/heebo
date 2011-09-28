//-----------------------------------------------------------------------------

var jewel_maxtype = 5;

var board_width = 8;
var board_height = 12;

var board;
var bg_grid;

if (gameview.platform() === "harmattan") {
    var block_width = 60;
    var block_height = 60;
} else {
    var block_width = 48;
    var block_height = 48;
}

var randomList = new Array();

var selected;
var selected_x;
var selected_y;

var pressed_x = -1;
var pressed_y = -1;

//-----------------------------------------------------------------------------

// Constructor for Point objects
function Point(x, y) {
    this.x = x;
    this.y = y;
}

//-----------------------------------------------------------------------------

var gridObject = function(grid, x, y) {
    if (x < 0 || y < 0 || x >= board_width || y >= board_height)
        return undefined;
    console.log("got this far");
    return grid[y][x];
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
    if (arr !== undefined) {
        for (var i=0; i<board_width; i++) {
            for (var j=0; j<board_height; j++) {
                if (arr[j][i] !== undefined)
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
                && board[j-2][i].type === board[j-1][i].type)
                skip1 = board[j-1][i].type;

            var skip2 = 0;
            if (i > 1 && !bg_grid[j][i-2].blocking && !bg_grid[j][i-1].blocking
                && board[j][i-2].type === board[j][i-1].type)
                skip2 = board[j][i-1].type;

            var type = 0;
            do {
                type = randomBlockType();
            } while (type === skip1 || type === skip2);

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
            if (obj === undefined)
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
        if (bb !== undefined && bb.type === block_type) {
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

            if (b != 0 && last_b === b)
                count++;

            if (last_b !== b || i === imax-1) {
                if (count >= 2) {
                    if (mark) {
                        var k_begin = i-count-1;
                        var k_end = i;
                        if (last_b === b) {
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
            } else if (board[j][i] === undefined) {
                fallDist++;
            } else {
                if (fallDist > 0) {
                    var obj = board[j][i];
                    obj.y = (j+fallDist)*block_height;
                    board[j+fallDist][i] = obj;
                    board[j][i] = undefined;
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
            if (obj !== undefined && obj.to_remove) {
                board[j][i] = undefined;
                obj.dying = true;
                //console.log("Removed:"+(j+1)+","+(i+1));
            }
        }
    }

    return changes;
}

//-----------------------------------------------------------------------------

function pressed(x,y) {
    // console.log("pressed: "+x+","+y);
    pressed_x = x;
    pressed_y = y;
    selected = undefined;

    var sx = Math.floor(pressed_x/block_width);
    var sy = Math.floor(pressed_y/block_height);

    if (sx < 0 || sy < 0 || sx >= board_width || sy >= board_height)
        return;

    selected = board[sy][sx];
    selected_x = sx;
    selected_y = sy;
}

function sign(x) {
    return x > 0 ? 1 : x < 0 ? -1 : 0;
}

function moving(x,y) {
    console.log("moving: "+x+","+y);
    if (selected === undefined)
        return;

    var dx = x-pressed_x;
    var dy = y-pressed_y;

    if (Math.abs(dx) > Math.abs(dy)) {
        dy = 0;
        dx = Math.min(block_width,dx);
        dx = Math.max(-block_width,dx);
    } else {
        dx = 0;
        dy = Math.min(block_width,dy);
        dy = Math.max(-block_width,dy);
    }

    // selected.x = block_width*selected_x+dx;
    // selected.y = block_height*selected_y+dy;
    if (Math.abs(dx)+Math.abs(dy) > 2)
        released(x,y);
}

function reset_selected() {
    if (selected) {
        selected.x = block_width*selected_x;
        selected.y = block_height*selected_y;
    }
}

function released(x,y) {
    console.log("released: "+x+","+y);

    if (okDialog.visible || mainMenu.visible || isRunning()) {
        //reset_selected();
        return; 
    }
    
    var dx = x-pressed_x;
    var dy = y-pressed_y;

    if (Math.abs(dx) > Math.abs(dy)) {
        dx = sign(dx);
        dy = 0;
    } else {
        dx = 0;
        dy = sign(dy);
    }

    if (!selected)
        return;

    var sx = selected_x; //Math.floor(pressed_x/block_width);
    var sy = selected_y; //Math.floor(pressed_y/block_height);

    var bx = sx+dx;
    var by = sy+dy;

    // var obj = null;

    // if (bx >= 0 && by >= 0 && bx < board_width && by < board_height)
    //     obj = board[by][bx];

    var obj = gridObject(board, bx, by);

    console.log("gridObject -> "+obj);

    board[sy][sx] = obj;
    board[by][bx] = selected;

    var old_objx = -1;
    var old_objy = -1;

    var old_selx = selected_x*block_width;
    var old_sely = selected_y*block_height;

    if (obj !== undefined) {
        old_objx = obj.x;
        old_objy = obj.y;
        obj.x = old_selx;
        obj.y = old_sely;
    }
    selected.x = bx*block_width;
    selected.y = by*block_height;

    var changes = checkBoard(false);

    if (bg_grid[by][bx].blocking || (!changes && obj !== undefined)) {
        // console.log("go back");
        board[sy][sx] = selected;
        board[by][bx] = obj;

        selected.x = old_selx;
        selected.y = old_sely;

        if (obj !== undefined) {
            obj.x = old_objx;
            obj.y = old_objy;
        }
    }
}

//-----------------------------------------------------------------------------

function checkNew() {
    for (var i=0; i<board_width; i++) {
        var n=0;
        while (n<board_height && board[n][i] === undefined &&
               bg_grid[n][i].blocking === false)
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
        okDialog.show("Victory! ZÖMG!!");
    }
}
    
