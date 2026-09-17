pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import "../components"

Item {
    id: musicWidget
    property real shadowSize
    property color barColor
    property var mprisRef

    width: musicContent.implicitWidth + 16 + shadowSize
    height: musicContent.implicitHeight + 8 + shadowSize

    BarShadow {
        id: musicShadow
        shadowOffsetX: musicMouseArea.pressed ? 2 : 4
        shadowOffsetY: musicMouseArea.pressed ? 2 : 4
        barColor: musicWidget.barColor
        width: musicBg.width
        height: musicBg.height

        Behavior on shadowOffsetX {
            NumberAnimation {
                duration: 80
                easing.type: Easing.OutQuad
            }
        }
        Behavior on shadowOffsetY {
            NumberAnimation {
                duration: 80
                easing.type: Easing.OutQuad
            }
        }
    }

    Rectangle {
        id: musicBg
        x: musicMouseArea.pressed ? 2 : 0
        y: musicMouseArea.pressed ? 2 : 0
        width: parent.width - musicWidget.shadowSize
        height: parent.height - musicWidget.shadowSize
        color: musicWidget.barColor

        Behavior on x {
            NumberAnimation {
                duration: 80
                easing.type: Easing.OutQuad
            }
        }
        Behavior on y {
            NumberAnimation {
                duration: 80
                easing.type: Easing.OutQuad
            }
        }
    }

    RowLayout {
        id: musicContent
        anchors.centerIn: musicBg
        spacing: 10

        Text {
            text: "["
            color: "#000000"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 16
            font.weight: 900
        }

        Text {
            text: {
                let player = musicWidget.mprisRef.player;

                if (!player) {
                    return "Not Playing";
                }

                if (player.trackTitle.length > 10 || player.trackArtist.length > 15) {
                    return musicWidget.mprisRef.isSpotify(player) ? player.trackTitle : "Not Playing";
                } else {
                    return musicWidget.mprisRef.isSpotify(player) ? player.trackTitle + " - " + player.trackArtist : "Not Playing";
                }
            }
            color: "#000000"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
            font.weight: 900
        }

        Text {
            text: "]"
            color: "#000000"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 16
            font.weight: 900
        }
    }

    MouseArea {
        id: musicMouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: musicPopup.open = !musicPopup.open
        onEntered: {
            musicShadow.barColor = Qt.darker(musicWidget.barColor, 1.2);
            musicBg.color = Qt.darker(musicWidget.barColor, 1.2);
        }
        onExited: {
            musicShadow.barColor = musicWidget.barColor;
            musicBg.color = musicWidget.barColor;
        }
    }

    PopupWindow {
        id: musicPopup
        property bool open: false

        anchor {
            item: musicWidget
            edges: Edges.Bottom
            gravity: Edges.Bottom
            margins.top: 42 + musicWidget.shadowSize
        }
        implicitWidth: popupLayout.implicitWidth + 32 + musicWidget.shadowSize
        implicitHeight: popupLayout.implicitHeight + 32 + musicWidget.shadowSize
        color: "transparent"

        onOpenChanged: {
            if (open) {
                visible = true;
                popupOpen.start();
            } else {
                popupClose.start();
            }
        }

        Item {
            id: popupContent
            anchors.fill: parent
            transformOrigin: Item.Top
            scale: 0.85
            y: -10

            BarShadow {
                id: popupShadow
                shadowOffsetX: 4
                shadowOffsetY: 4
                barColor: musicWidget.barColor
                width: popupBg.width
                height: popupBg.height
            }

            Rectangle {
                id: popupBg
                width: parent.width - musicWidget.shadowSize
                height: parent.height - musicWidget.shadowSize
                color: musicWidget.barColor
            }

            RowLayout {
                id: popupLayout
                anchors.left: popupBg.left
                anchors.top: popupBg.top
                anchors.topMargin: 16
                anchors.leftMargin: 16
                spacing: 15

                Image {
                    id: albumArt
                    Layout.preferredWidth: 128
                    Layout.preferredHeight: 128
                    Layout.alignment: Qt.AlignLeft
                    fillMode: Image.PreserveAspectFit
                    sourceSize.width: 128
                    sourceSize.height: 128
                    asynchronous: true
                    visible: source.toString() !== ""
                    source: {
                        let player = musicWidget.mprisRef.player;

                        if (!player || !musicWidget.mprisRef.isSpotify(player) || !player.trackArtUrl) {
                            return "../assets/default.png";
                        }

                        return player.trackArtUrl;
                    }
                }

                Column {
                    spacing: 18

                    Column {
                        Row {
                            spacing: 10

                            Text {
                                text: "["
                                color: "#000000"
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 16
                                font.weight: 900
                            }

                            Text {
                                text: {
                                    let player = musicWidget.mprisRef.player;

                                    if (!player) {
                                        return "Title: No Title";
                                    }

                                    return musicWidget.mprisRef.isSpotify(player) ? "Title: " + player.trackTitle : "Title: No Title";
                                }
                                color: "#000000"
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 14
                                font.weight: 900
                            }

                            Text {
                                text: "]"
                                color: "#000000"
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 16
                                font.weight: 900
                            }
                        }

                        Row {
                            spacing: 10

                            Text {
                                text: "["
                                color: "#000000"
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 16
                                font.weight: 900
                            }

                            Text {
                                text: {
                                    let player = musicWidget.mprisRef.player;

                                    if (!player) {
                                        return "Artist: No Artist";
                                    }

                                    return musicWidget.mprisRef.isSpotify(player) ? "Artist: " + player.trackArtist : "Artist: No Artist";
                                }
                                color: "#000000"
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 14
                                font.weight: 900
                            }

                            Text {
                                text: "]"
                                color: "#000000"
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 16
                                font.weight: 900
                            }
                        }

                        Row {
                            spacing: 10

                            Text {
                                text: "["
                                color: "#000000"
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 16
                                font.weight: 900
                            }

                            Text {
                                text: {
                                    let player = musicWidget.mprisRef.player;

                                    if (!player) {
                                        return "Player: No Player";
                                    }

                                    return musicWidget.mprisRef.isSpotify(player) ? "Player: " + player.identity : "Player: No Player";
                                }
                                color: "#000000"
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 14
                                font.weight: 900
                            }

                            Text {
                                text: "]"
                                color: "#000000"
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 16
                                font.weight: 900
                            }
                        }
                    }

                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 10

                        Item {
                            width: 32
                            height: 32

                            BarShadow {
                                shadowOffsetX: prevMouseArea.pressed ? 2 : 4
                                shadowOffsetY: prevMouseArea.pressed ? 2 : 4
                                barColor: "#000000"
                                width: prevBg.width
                                height: prevBg.height

                                Behavior on shadowOffsetX {
                                    NumberAnimation {
                                        duration: 80
                                        easing.type: Easing.OutQuad
                                    }
                                }
                                Behavior on shadowOffsetY {
                                    NumberAnimation {
                                        duration: 80
                                        easing.type: Easing.OutQuad
                                    }
                                }
                            }

                            Rectangle {
                                id: prevBg
                                color: "#000000"
                                width: 32
                                height: 32
                                x: prevMouseArea.pressed ? 2 : 0
                                y: prevMouseArea.pressed ? 2 : 0

                                Behavior on x {
                                    NumberAnimation {
                                        duration: 80
                                        easing.type: Easing.OutQuad
                                    }
                                }
                                Behavior on y {
                                    NumberAnimation {
                                        duration: 80
                                        easing.type: Easing.OutQuad
                                    }
                                }

                                Text {
                                    text: "󰒮"
                                    color: "#ffffff"
                                    font.family: "JetBrainsMono Nerd Font"
                                    font.pixelSize: 24
                                    font.weight: 900
                                    anchors.centerIn: parent
                                }
                            }

                            MouseArea {
                                id: prevMouseArea
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    let player = musicWidget.mprisRef.player;

                                    if (player && player.canGoPrevious) {
                                        player.previous();
                                        musicPopup.open = !musicPopup.open;
                                    }
                                }
                            }
                        }

                        Item {
                            width: 32
                            height: 32

                            BarShadow {
                                shadowOffsetX: playMouseArea.pressed ? 2 : 4
                                shadowOffsetY: playMouseArea.pressed ? 2 : 4
                                barColor: "#000000"
                                width: playBg.width
                                height: playBg.height

                                Behavior on shadowOffsetX {
                                    NumberAnimation {
                                        duration: 80
                                        easing.type: Easing.OutQuad
                                    }
                                }
                                Behavior on shadowOffsetY {
                                    NumberAnimation {
                                        duration: 80
                                        easing.type: Easing.OutQuad
                                    }
                                }
                            }

                            Rectangle {
                                id: playBg
                                color: "#000000"
                                width: 32
                                height: 32
                                x: playMouseArea.pressed ? 2 : 0
                                y: playMouseArea.pressed ? 2 : 0

                                Behavior on x {
                                    NumberAnimation {
                                        duration: 80
                                        easing.type: Easing.OutQuad
                                    }
                                }
                                Behavior on y {
                                    NumberAnimation {
                                        duration: 80
                                        easing.type: Easing.OutQuad
                                    }
                                }

                                Text {
                                    text: musicWidget.mprisRef.player && musicWidget.mprisRef.player.isPlaying ? "󰏤" : "󰐊"
                                    color: "#ffffff"
                                    font.family: "JetBrainsMono Nerd Font"
                                    font.pixelSize: 24
                                    font.weight: 900
                                    anchors.centerIn: parent
                                }
                            }

                            MouseArea {
                                id: playMouseArea
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    let player = musicWidget.mprisRef.player;

                                    if (player && player.canTogglePlaying) {
                                        player.togglePlaying();
                                    }
                                }
                            }
                        }

                        Item {
                            width: 32
                            height: 32

                            BarShadow {
                                shadowOffsetX: nextMouseArea.pressed ? 2 : 4
                                shadowOffsetY: nextMouseArea.pressed ? 2 : 4
                                barColor: "#000000"
                                width: nextBg.width
                                height: nextBg.height

                                Behavior on shadowOffsetX {
                                    NumberAnimation {
                                        duration: 80
                                        easing.type: Easing.OutQuad
                                    }
                                }
                                Behavior on shadowOffsetY {
                                    NumberAnimation {
                                        duration: 80
                                        easing.type: Easing.OutQuad
                                    }
                                }
                            }

                            Rectangle {
                                id: nextBg
                                color: "#000000"
                                width: 32
                                height: 32
                                x: nextMouseArea.pressed ? 2 : 0
                                y: nextMouseArea.pressed ? 2 : 0

                                Behavior on x {
                                    NumberAnimation {
                                        duration: 80
                                        easing.type: Easing.OutQuad
                                    }
                                }
                                Behavior on y {
                                    NumberAnimation {
                                        duration: 80
                                        easing.type: Easing.OutQuad
                                    }
                                }

                                Text {
                                    text: "󰒭"
                                    color: "#ffffff"
                                    font.family: "JetBrainsMono Nerd Font"
                                    font.pixelSize: 24
                                    font.weight: 900
                                    anchors.centerIn: parent
                                }
                            }

                            MouseArea {
                                id: nextMouseArea
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    let player = musicWidget.mprisRef.player;

                                    if (player && player.canGoNext) {
                                        player.next();
                                        musicPopup.open = !musicPopup.open;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        ParallelAnimation {
            id: popupOpen

            NumberAnimation {
                target: popupContent
                property: "scale"
                to: 1
                duration: 150
                easing.type: Easing.OutBack
            }

            NumberAnimation {
                target: popupContent
                property: "y"
                to: 0
                duration: 150
                easing.type: Easing.OutCubic
            }
        }

        ParallelAnimation {
            id: popupClose

            NumberAnimation {
                target: popupContent
                property: "scale"
                to: 0.85
                duration: 150
                easing.type: Easing.InCubic
            }

            NumberAnimation {
                target: popupContent
                property: "y"
                to: -10
                duration: 150
                easing.type: Easing.InCubic
            }

            onFinished: musicPopup.visible = false
        }
    }
}
