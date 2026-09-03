pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

PanelWindow {
    id: bar
    required property var modelData
    property SystemClock clockRef
    property real volumeRef
    property real brightnessRef
    property var workspacesRef

    function getVolumeIcon() {
        if (Math.round(volumeRef * 100) > 80) {
            return " ";
        } else if (Math.round(volumeRef * 100) > 40) {
            return "";
        } else {
            return "";
        }
    }

    function getBrightnessIcon() {
        if (brightnessRef > 80) {
            return "󰃠";
        } else if (brightnessRef > 60) {
            return "󰃟";
        } else if (brightnessRef > 40) {
            return "󰃞";
        } else if (brightnessRef > 20) {
            return "󰃜";
        } else {
            return "󰃚";
        }
    }

    screen: modelData
    anchors.bottom: true
    margins.bottom: 14
    implicitHeight: 32
    implicitWidth: 800
    color: "#ffffff"

    Row {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        spacing: 5

        Text {
            text: Qt.formatDateTime(bar.clockRef.date, "hh:mm")
            color: "#000000"
            font.pixelSize: 14
        }
    }

    Row {
        anchors.centerIn: parent
        spacing: 5

        Repeater {
            model: Workspaces.names
            delegate: Rectangle {
                id: model
                required property int index
                required property string modelData

                width: 15
                height: 15
                color: index === Workspaces.current ? "#ffffff" : "#000000"
                border.color: "#000000"
                border.width: index === Workspaces.current ? 1 : 0

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Workspaces.switchTo(model.index)
                }
            }
        }
    }

    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 10
        spacing: 5

        Text {
            text: bar.getBrightnessIcon()
            color: "#000000"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 18
            font.weight: 900
        }

        Text {
            text: Volume.muted ? "" : bar.getVolumeIcon()
            color: "#000000"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 16
            font.weight: 900
        }
    }
}
