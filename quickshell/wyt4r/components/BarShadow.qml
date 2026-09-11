import QtQuick

Rectangle {
    id: root
    property int shadowWidth
    property int shadowHeight
    property real shadowOffsetX
    property real shadowOffsetY
    property color barColor
    property color shadowColor: Qt.darker(barColor, 1.6)

    x: shadowOffsetX
    y: shadowOffsetY
    width: shadowWidth
    height: shadowHeight
    color: shadowColor

    Component.onCompleted: {
        console.log("barColor:", barColor);
        console.log("shadowColor:", shadowColor);
    }
}
