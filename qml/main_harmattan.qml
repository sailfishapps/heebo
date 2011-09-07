import QtQuick 1.0
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow
    initialPage: mainPage
    // showStatusBar: false
    color: "black"

    MainPage {
        id: mainPage
        orientationLock: PageOrientation.LockPortrait
    }
}
