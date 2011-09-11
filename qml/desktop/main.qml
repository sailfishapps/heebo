import QtQuick 1.0

import "../js/jewels.js" as Jewels

MainPage {
    id: mainPage
    width: Jewels.block_width*Jewels.board_width
    height: Jewels.block_height*Jewels.board_height+toolbar_height
}
