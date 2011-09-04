var board_width = 8;
var board_height = 8;
var board = null;

var block_width = 64;
var block_height = 64;
var selected = null;

function random(from, to) {
    return Math.floor(Math.random()*(to-from+1)+from);
}

function initBoard() {
    // Destroy old board if there is such
    if (board != null) {
        for (var i=0; i<board_width; i++) {
            for (var j=0; j<board_height; j++) {
                if (board[j][i] != null)
                    board[j][i].destroy();
            }
        }
        delete board;
    }
    
    board = new Array(board_height);
    for (var j=0; j<board_height; j++) 
        board[j] = new Array(board_width);
}

function startNewGame() {
    initBoard();
    for (var i=0; i<board_width; i++) {
        for (var j=0; j<board_height; j++) {
            var component = Qt.createComponent("Jewel.qml");
            
            // while (component.status != Component.Ready)
            // {}
            
            var obj = component.createObject(background);
            obj.x = i*block_width;
            obj.y = j*block_height;
            obj.type = random(1,3);
            obj.spawned = true;
            board[j][i] = obj;
        }
    }
    
    checkLoop();

    return true;
}

function checkLoop() {
    var changes = 1;
    while (changes) {
        changes = 0;
        changes += fallDown();
        changes += checkBoard();
    }
}

function checkBoardOneWay(jmax, imax, rows) {
    var changes = 0;

    // Check rows/columns for subsequent items
    for (var j=0; j<jmax; j++) {
        var last_b = 0;
        var count = 0;
        for (var i=0; i<imax; i++) {
            var obj = rows ? board[j][i] : board[i][j];
            if (!obj) {
                count = 0;
                last_b = 0;
                continue;
            }

            var b = obj.type;

            if (last_b == b)
                count++;

            if (last_b != b || i==imax-1) {
                if (count >= 2) {
                    var k_begin = i-count-1;
                    var k_end = i;
                    if (last_b == b) {
                        k_begin++;
                        k_end++;
                    }
                    
                    for (var k=k_begin; k<k_end; k++) {
                        if (rows) {
                            board[j][k].destroy();
                            board[j][k] = null;
                        } else {
                            board[k][j].destroy();
                            board[k][j] = null;
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

function fallDown() {
    var changes = 0;
    for (var i=0; i<board_width; i++) {
        var fallDist = 0;
        for (var j=board_height-1; j>=0; j--) {
            if (board[j][i] == null) {
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

function checkBoard() {
    var changes = 0;

    // Check rows for subsequent items
    changes += checkBoardOneWay(board_height, board_width, true);

    // Check columns for subsequent items
    changes += checkBoardOneWay(board_width, board_height, false);

    return changes;
}

function clicked(x, y) {
    var bx = Math.floor(x/block_width);
    var by = Math.floor(y/block_height);
    var obj = board[by][bx];
    if (obj == null)
        return;

    var posStr = "("+by+","+bx+")";

    // Click on same object again: unselect
    if (obj.selected) {
        obj.selected = false;
        selected = null;
        return;
    }

    // First object to be clicked
    if (!selected) {
        obj.selected = true;
        selected = obj;
        return;
    }

    // Second object to be clicked
    selected.selected = false;

    var sx = Math.floor(selected.x/block_width);
    var sy = Math.floor(selected.y/block_height);
    var dx = Math.abs(bx-sx);
    var dy = Math.abs(by-sy);

    if ((dx==1 && dy==0) || (dx==0 && dy == 1)) {
        var tx = obj.x;
        var ty = obj.y;
        obj.x = selected.x;
        obj.y = selected.y;
        selected.x = tx;
        selected.y = ty;
        board[sy][sx] = obj;
        board[by][bx] = selected;
    }
    selected = null;

    checkLoop();
}
