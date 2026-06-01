// BrightnessService.qml
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property real brightness: 0

    signal changed()

    FileView
    {
        id: brightnessWatcher
        path: "/sys/class/backlight/intel_backlight/brightness"
        watchChanges: true
        onFileChanged: bsProcess.running = true
    }

    Process
    {
        id: bsProcess
        command: ["brightnessctl", "-m"]
        running: true

        stdout: StdioCollector
        {
            onStreamFinished:
            {
                brightness = parseFloat(text.split(",")[3]) / 100;
                changed();
            }
        }
    }

    function getIcon()
    {
        if (brightness < 0.20) return "󰃞";
        if (brightness < 0.50) return "󰃟";
        return "󰃠";
    }

    function getPercentage()
    {
        return Math.round(brightness * 100) + "%";
    }
}
