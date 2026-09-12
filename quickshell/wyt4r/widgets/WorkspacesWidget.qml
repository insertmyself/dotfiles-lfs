pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import "../components"

Item {
    id: workspacesWidget
    property real shadowSize
    property color barColor
    property var workspacesRef

    width: workspacesText.implicitWidth + 16 + shadowSize
    height: workspacesText.implicitHeight + 8 + shadowSize

    BarShadow {
        id: workspacesShadow
        shadowOffsetX: 4
        shadowOffsetY: 4
        barColor: workspacesWidget.barColor
        width: workspacesBg.width
        height: workspacesBg.height
    }

    Rectangle {
        id: workspacesBg
        width: parent.width - workspacesWidget.shadowSize
        height: parent.height - workspacesWidget.shadowSize
        color: workspacesWidget.barColor
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
                    model: workspacesWidget.workspacesRef.names
                    delegate: Rectangle {
                        id: model
                        required property int index
                        required property string modelData

                        width: 11
                        height: 11
                        color: index === workspacesWidget.workspacesRef.current ? "#ffffff" : "#000000"
                        border.color: "#000000"
                        border.width: index === workspacesWidget.workspacesRef.current ? 1 : 0

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: workspacesWidget.workspacesRef.switchTo(model.index)
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
