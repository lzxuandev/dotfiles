import QtQuick
import qs.services

Item
{
    id: clock

    Text
    {
        text:             TimeService.getTime()
        anchors.centerIn: parent

        font.family:      "JetBrainsMono Nerd Font"
        font.pixelSize:   13
        font.bold:        true
        color:            "#CCCCCC"
    }
}
