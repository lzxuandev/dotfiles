pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property list<var> entries: []

    Component.onCompleted: load()

    // =========================
    // Public API
    // =========================
    function load() {
        loadProcess.running = true
    }

    function copy(rawLine) {
        copyProcess.command = ["bash", "-c", buildCopyCommand(rawLine)]
        copyProcess.running = true
    }

    // =========================
    // Internal Helpers
    // =========================
    function parseLine(rawLine) {
        const tabIndex = rawLine.indexOf("\t")

        if (tabIndex === -1) {
            return {
                rawLine: rawLine,
                preview: rawLine.trim()
            }
        }

        return {
            rawLine: rawLine,
            preview: rawLine.substring(tabIndex + 1).trim()
        }
    }

    function parseOutput(text) {
        if (!text || text.trim().length === 0)
            return []

        const lines = text.trim().split("\n")
        const result = []

        for (let i = 0; i < lines.length; i++) {
            result.push(parseLine(lines[i]))
        }

        return result
    }

    function buildCopyCommand(rawLine) {
        const safe = rawLine.replace(/'/g, "'\\''")
        return `echo '${safe}' | cliphist decode | wl-copy`
    }

    // =========================
    // Processes
    // =========================
    Process {
        id: loadProcess
        command: ["cliphist", "list"]

        stdout: StdioCollector {
            onStreamFinished: {
                root.entries = parseOutput(this.text)
            }
        }
    }

    Process {
        id: copyProcess
        running: false
    }
}
