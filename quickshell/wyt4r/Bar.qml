pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

PanelWindow {
    id: bar
    required property var modelData
    property SystemClock clockRef
    property var volumeRef
    property var brightnessRef
    property var workspacesRef
    property var batteryRef
    property var cavaRef
    property var networkRef
    property real shadowSize: 6
    property color barColor: "#ffffff"

    aboveWindows: false
    screen: modelData
    anchors.bottom: true
    margins.bottom: 14
    implicitHeight: 32 + shadowSize
    implicitWidth: 1350 + shadowSize
    color: "transparent"

    SystemClock {
        id: clockSource
        precision: SystemClock.Minutes
    }

    ClockWidget {
        id: clockWidget
        barColor: bar.barColor
        shadowSize: bar.shadowSize
        clockRef: clockSource

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
    }

    WorkspacesWidget {
        id: workspacesWidget
        barColor: bar.barColor
        shadowSize: bar.shadowSize
        workspacesRef: Workspaces

        anchors.left: clockWidget.right
        anchors.verticalCenter: clockWidget.verticalCenter
        anchors.leftMargin: 6
    }

    CavaWidget {
        id: cavaWidget
        barColor: bar.barColor
        shadowSize: bar.shadowSize
        cavaRef: Cava

        anchors.right: systemWidget.left
        anchors.verticalCenter: workspacesWidget.verticalCenter
        anchors.rightMargin: 6
    }

    SystemWidget {
        id: systemWidget
        barColor: bar.barColor
        shadowSize: bar.shadowSize
        volumeRef: Volume
        batteryRef: Power
        brightnessRef: Brightness
        networkRef: Network

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 10
    }
}
