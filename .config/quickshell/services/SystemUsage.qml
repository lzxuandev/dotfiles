pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property real cpuPerc: root.cpuValue
    readonly property real gpuUsage: 0
    readonly property real vramUsed: 0
    readonly property real memPercent: root.memValue

    property real cpuValue: 0
    property real memValue: 0

    Process {
        id: statusProcess

        command: ["sh", "-c", "top -bn1 | grep -E 'Cpu|Mem' | head -2"]

        stdout: StdioCollector {
            onStreamFinished: {
                if (text) {
                    var lines = text.trim().split("\n")
                    for (var i = 0; i < lines.length; i++) {
                        var line = lines[i]
                        if (line.includes("Cpu")) {
                            var match = line.match(/(\d+\.\d+)\s*id/)
                            if (match) {
                                cpuValue = 100 - parseFloat(match[1])
                            }
                        } else if (line.includes("Mem")) {
                            var match = line.match(/(\d+)\s*used/)
                            if (match) {
                                var used = parseInt(match[1])
                                var match2 = line.match(/(\d+)\s*total/)
                                if (match2) {
                                    memValue = (used / parseInt(match2[1])) * 100
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Timer {
        id: timer
        interval: 2000
        repeat: true
        running: true
        onTriggered: statusProcess.running = true
    }

    Component.onCompleted: statusProcess.running = true
}