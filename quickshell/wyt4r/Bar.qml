pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: bar
    required property var modelData
    property SystemClock clockRef
    property real volumeRef
    property real brightnessRef
    property var workspacesRef
    property var batteryRef
    property string networkRef

    function getBatteryIcon() {
        let battery = Math.round(bar.batteryRef.energy / bar.batteryRef.energyCapacity * 100);

        if (bar.batteryRef.isCharging) {
            return "󰂄";
        } else if (battery > 80) {
            return "󰁹";
        } else if (battery > 60) {
            return "󰂁";
        } else if (battery > 40) {
            return "󰁾";
        } else if (battery > 20) {
            return "󰁼";
        } else {
            return "󰂎";
        }
    }

    function getVolumeIcon() {
        let volume = Math.round(volumeRef * 100);

        if (volume > 80) {
            return "";
        } else if (volume > 40) {
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

    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        spacing: 10

        Text {
            text: "["
            color: "#000000"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 16
            font.weight: 900
        }

        Text {
            text: Qt.formatDateTime(bar.clockRef.date, "hh:mm | dd/\MM/yy")
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

    RowLayout {
        anchors.centerIn: parent
        spacing: 12

        Text {
            text: "["
            color: "#000000"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 16
            font.weight: 900
        }

        Row {
            spacing: 8

            Repeater {
                model: Workspaces.names
                delegate: Rectangle {
                    id: model
                    required property int index
                    required property string modelData

                    width: 12
                    height: 12
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

        Text {
            text: "]"
            color: "#000000"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 16
            font.weight: 900
        }
    }

    RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 10
        spacing: 12

        Text {
            text: "["
            color: "#000000"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 16
            font.weight: 900
        }

        Row {
            spacing: 10

            Text {
                text: bar.getBrightnessIcon()
                color: "#000000"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 15
                font.weight: 900
            }

            Text {
                text: bar.networkRef
                color: "#000000"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 15
                font.weight: 900
            }

            Text {
                text: Volume.muted ? "" : bar.getVolumeIcon()
                color: "#000000"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 15
                font.weight: 900

                HoverHandler {
                    id: volumeHoverHandler
                    cursorShape: Qt.PointingHandCursor
                }

                TapHandler {
                    id: volumeTapHandler
                    onTapped: {
                        Volume.muted = !Volume.muted;
                    }
                }
            }

            Text {
                text: bar.getBatteryIcon()
                color: "#000000"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 15
                font.weight: 900
            }
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
