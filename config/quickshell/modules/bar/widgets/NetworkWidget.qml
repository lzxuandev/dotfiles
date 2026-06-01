import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services

Item {
    id: network

    implicitWidth: layout.width
    implicitHeight: layout.height

    Row
    {
        id: layout
        anchors.centerIn: parent
        spacing: 10

        Text
        {
            id: icon
            text: NetworkService.getIcon()
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 13
            color: "#CCCCCC"
        }

        Text
        {
            id: name
            text: NetworkService.getName()
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 13
            color: "#CCCCCC"
            visible : (mouseArea.containsMouse)
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            Quickshell.execDetached(["nmgui"])
        }
    }
}
