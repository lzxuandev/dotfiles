import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.services

Scope
{
    PanelWindow
    {
        id: bar

        anchors.bottom: true
        margins.bottom: 40
        exclusiveZone: 0

        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.namespace: "quickshell-osd"

        implicitWidth:  osd_bar.width
        implicitHeight: osd_bar.height
        color: "transparent"
        visible: false

        property string mode: "volume"

        Connections
        {
            target: PipewireService

            function onChanged()
            {
                bar.mode = "volume";
                bar.visible = true;
                barTimer.restart();
            }
        }

        Connections
        {
            target: BrightnessService

            function onChanged()
            {
                bar.mode = "brightness"
                bar.visible = true;
                barTimer.restart();
            }

        }

        Timer
        {
            id: barTimer
            interval: 2000
            running: false
            repeat:  false
            onTriggered: bar.visible = false
        }

        Rectangle
        {
            id: osd_bar
            width: 400
            height: 40
            radius: 20
            color: "#AA000000"

            RowLayout
            {
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                spacing: 12

                Item
                {
                    width: 24

                    Text
                    {
                        anchors.centerIn: parent
                        text: bar.mode === "volume" ? PipewireService.getIcon() : BrightnessService.getIcon()
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 14
                        font.bold: true
                        color: "#CCCCCC"
                    }
                }

                Rectangle
                {
                    id: progress_bar
                    Layout.fillWidth: true
                    height: 5
                    color: "#111111"
                    radius: 2

                    Rectangle
                    {
                        id: progress_fill
                        height: parent.height
                        radius: parent.radius
                        color: "#CCCCCC"

                        width:
                        {
                            if (bar.mode === "volume")     return parent.width * (Math.max(0, Math.min(1.2, PipewireService.volume)) / 1.2)
                            if (bar.mode === "brightness") return parent.width * (Math.max(0, Math.min(1.0, BrightnessService.brightness)))
                        }

                    }
                }

                Item
                {
                    width: 24
                }
            }
        }
    }
}
