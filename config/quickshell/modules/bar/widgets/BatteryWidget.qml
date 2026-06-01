import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs.services

Item
{
    id: battery

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
            text: BatteryService.getIcon()
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 13
            font.bold: true
            color: "#CCCCCC"

        }

        Text
        {
            id: percentage
            text: BatteryService.getPercentage()
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 13
            font.bold: true
            color: "#CCCCCC"

            visible: (mouseArea.containsMouse || BatteryService.battery.state !== UPowerDevice.FullyCharged)
        }

    }

    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
    }
}
