pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton
{
    id: root

    property string state: ""
    property string type:  ""
    property string name:  ""

    Process
    {
        id: nmProcess
        command: ["nmcli", "-t", "-f", "GENERAL.TYPE,GENERAL.STATE,GENERAL.CONNECTION",  "dev", "show", "wlp0s20f3"]

        stdout: StdioCollector
        {
            onStreamFinished: {
                var rawData = text.trim();
                var lines   = rawData.split("\n");

                if (lines.length >= 3)
                {
                    root.type  = lines[0].split(":")[1];
                    root.state = (lines[1].split(":")[1] === "100 (connected)") ? "connected":"disconnected";
                    root.name  = lines[2].split(":")[1];
                }
            }
        }
    }

    Process
    {
        id: nmMonitor
        command: ["nmcli", "monitor"]
        running: true

        stdout: SplitParser
        {
            onRead: { Qt.callLater(() => { nmProcess.running = true; });}
        }
    }

    function getIcon()
    {
        if (state !== "connected") return "󰤭";
        if (type  === "wifi")      return "󰤨";
        if (type  === "ethernet")  return "󰈀";

        return "⚠";
    }

    function getName()
    {
        return (state === "connected") ? name : "Disconnected"
    }
}
