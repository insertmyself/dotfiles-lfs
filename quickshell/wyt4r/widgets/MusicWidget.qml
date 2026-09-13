pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import "../components"

Item {
    id: musicWidget
    property real shadowSize
    property color barColor
    property var mprisRef

    width: musicText.implicitWidth + 16 + shadowSize
    height: musicText.implicitHeight + 8 + shadowSize

    BarShadow {
        id: musicShadow
        shadowOffsetX: 4
        shadowOffsetY: 4
        barColor: musicWidget.barColor
        width: musicBg.width
        height: musicBg.height
    }

    Rectangle {
        id: musicBg
        width: parent.width - musicWidget.shadowSize
        height: parent.height - musicWidget.shadowSize
        color: musicWidget.barColor
    }

    RowLayout {
        id: musicText
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

                if (player.trackTitle.length > 10 || player.trackArtist.length > 10) {
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
}
