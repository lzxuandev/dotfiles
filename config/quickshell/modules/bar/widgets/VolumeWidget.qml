import QtQuick
import Quickshell
import Quickshell.Io
import qs.services

Item
{
    id: volume

    implicitWidth: layout.width
    implicitHeight: layout.height

    Process {
        id: wpctl
    }

    function runWpctl(args) {
        wpctl.command = ["wpctl", ...args];
        wpctl.running = true;
    }

    Row
    {
        id: layout
        anchors.centerIn: parent
        spacing: 10

        Text
        {
            id: icon
            text: PipewireService.getIcon()
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 13
            font.bold: true
            color: "#CCCCCC"
        }

        Text {
            id: percentage
            text: PipewireService.getPercentage()
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 13
            color: "#CCCCCC"
            visible: (mouseArea.containsMouse && ! PipewireService.muted)
        }

    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onWheel: (wheel) => {
            if (wheel.angleDelta.y > 0) {
                // 对应 wpctl set-volume -l 1.2 @DEFAULT_AUDIO_SINK@ 5%+
                runWpctl(["set-volume", "-l", "1.2", "@DEFAULT_AUDIO_SINK@", "5%+"]);
            } else {
                // 对应 wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
                runWpctl(["set-volume", "@DEFAULT_AUDIO_SINK@", "5%-"]);
            }
        }

        onClicked: {
            runWpctl(["set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]);
        }
    }
}
