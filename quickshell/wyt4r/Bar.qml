pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Mpris
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
    property MprisPlayer mprisRef
    property real shadowSize: 6
    property color barColor: "#ffffff"

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

    aboveWindows: false
    screen: modelData
    anchors.bottom: true
    margins.bottom: 14
    implicitHeight: 32 + shadowSize
    implicitWidth: 1200 + shadowSize
    color: "transparent"

    Item {
        id: clockWidget
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        width: clockText.implicitWidth + 16 + bar.shadowSize
        height: clockText.implicitHeight + 8 + bar.shadowSize

        BarShadow {
            id: clockShadow
            shadowOffsetX: 4
            shadowOffsetY: 4
            barColor: bar.barColor
            width: clockBg.width
            height: clockBg.height
        }

        Rectangle {
            id: clockBg
            width: parent.width - bar.shadowSize
            height: parent.height - bar.shadowSize
            color: bar.barColor
        }

        RowLayout {
            id: clockText
            anchors.centerIn: clockBg
            spacing: 10

            Text {
                text: "["
                color: "#000000"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 16
                font.weight: 900
            }

            Text {
                text: Qt.formatDateTime(bar.clockRef.date, "hh:mm | dd/MM/yy")
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

    Item {
        id: workspacesWidget
        anchors.left: clockWidget.right
        anchors.verticalCenter: clockWidget.verticalCenter
        anchors.leftMargin: 6
        width: workspacesText.implicitWidth + 16 + bar.shadowSize
        height: workspacesText.implicitHeight + 8 + bar.shadowSize

        BarShadow {
            id: workspacesShadow
            shadowOffsetX: 4
            shadowOffsetY: 4
            barColor: bar.barColor
            width: workspacesBg.width
            height: workspacesBg.height
        }

        Rectangle {
            id: workspacesBg
            width: parent.width - bar.shadowSize
            height: parent.height - bar.shadowSize
            color: bar.barColor
        }

        RowLayout {
            id: workspacesText
            anchors.centerIn: workspacesBg
            spacing: 6

            Row {
                spacing: 10

                Text {
                    text: "["
                    color: "#000000"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 16
                    font.weight: 900
                }

                Row {
                    spacing: 8
                    anchors.verticalCenter: parent.verticalCenter

                    Repeater {
                        model: Workspaces.names
                        delegate: Rectangle {
                            id: model
                            required property int index
                            required property string modelData

                            width: 11
                            height: 11
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
        }
    }

    Item {
        id: musicWidget
        anchors.right: systemWidget.left
        anchors.verticalCenter: workspacesWidget.verticalCenter
        anchors.rightMargin: 6
        width: musicText.implicitWidth + 16 + bar.shadowSize
        height: musicText.implicitHeight + 8 + bar.shadowSize
        visible: bar.mprisRef !== null && bar.mprisRef.trackTitle !== "Advertisement" && bar.mprisRef.trackTitle !== ""

        BarShadow {
            id: musicShadow
            shadowOffsetX: 4
            shadowOffsetY: 4
            barColor: bar.barColor
            width: musicBg.width
            height: musicBg.height
        }

        Rectangle {
            id: musicBg
            width: parent.width - bar.shadowSize
            height: parent.height - bar.shadowSize
            color: bar.barColor
        }

        RowLayout {
            id: musicText
            anchors.centerIn: musicBg
            spacing: 6

            Row {
                spacing: 8

                Text {
                    text: "["
                    color: "#000000"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 16
                    font.weight: 900
                }

                Text {
                    text: {
                        if (!bar.mprisRef) {
                            return "";
                        }

                        const title = bar.mprisRef.trackTitle;
                        const artist = bar.mprisRef.trackArtist;

                        return artist + " - " + title;
                    }
                    color: "#000000"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 14
                    font.weight: 900
                    anchors.verticalCenter: parent.verticalCenter
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
    }

    Item {
        id: systemWidget
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 10
        width: systemText.implicitWidth + 16 + bar.shadowSize
        height: systemText.implicitHeight + 8 + bar.shadowSize

        BarShadow {
            id: systemShadow
            shadowOffsetX: 4
            shadowOffsetY: 4
            barColor: bar.barColor
            width: systemBg.width
            height: systemBg.height
        }

        Rectangle {
            id: systemBg
            width: parent.width - bar.shadowSize
            height: parent.height - bar.shadowSize
            color: bar.barColor
        }

        RowLayout {
            id: systemText
            anchors.centerIn: systemBg
            spacing: 10

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

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Volume.toggleMute()
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
}
