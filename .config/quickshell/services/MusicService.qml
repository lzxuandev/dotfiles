pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string songTitle:      ""
    property string songArtist:     ""
    property bool   mpdOnline:      false
    property bool   isPlaying:      false
    property bool   playlistEmpty:  true
    property bool   repeatOn:       false
    property bool   randomOn:       false
    property string progress:       "0:00/0:00"
    property string elapsed:        "0:00"
    property string total:          "0:00"
    property real   progressPercent: 0.0
    property string coverPath:      "/home/lzx/Pictures/Song Album/default.jpg"

    readonly property string coverFolder: "/home/lzx/Pictures/Song Album/"

    Image {
        id: fileChecker
        visible: false
        property bool fileExists: false

        onStatusChanged: {
            if (status === Image.Ready) {
                fileExists = true
                // 文件存在，使用检测的路径
                if (source.toString() === "file:///" + candidatePath) {
                    root.coverPath = candidatePath
                }
            } else if (status === Image.Error) {
                fileExists = false
                // 文件不存在，使用默认
                if (source.toString() === "file:///" + candidatePath) {
                    root.coverPath = coverFolder + "default.jpg"
                }
            }
        }
    }

    property string candidatePath: ""

    function updateCoverPath() {
        if (!root.mpdOnline || root.playlistEmpty || root.songArtist === "") {
            root.coverPath = coverFolder + "default.jpg"
            return
        }

        candidatePath = coverFolder + root.songArtist + ".jpg"
        fileChecker.source = "file:///" + candidatePath
    }

    Process { id: cmdToggle;       command: ["mpc", "toggle"];                               onRunningChanged: if (!running) root.refreshStatus() }
    Process { id: cmdPrev;         command: ["mpc", "prev"];                                 onRunningChanged: if (!running) root.refreshStatus() }
    Process { id: cmdNext;         command: ["mpc", "next"];                                 onRunningChanged: if (!running) root.refreshStatus() }
    Process { id: cmdToggleRepeat; command: ["mpc", "repeat", root.repeatOn ? "off" : "on"]; onRunningChanged: if (!running) root.refreshStatus() }
    Process { id: cmdToggleRandom; command: ["mpc", "random", root.randomOn ? "off" : "on"]; onRunningChanged: if (!running) root.refreshStatus() }

    function toggle()       { if (cmdToggle.running)       return; cmdToggle.running        = true }
    function prev()         { if (cmdPrev.running)         return; cmdPrev.running          = true }
    function next()         { if (cmdNext.running)         return; cmdNext.running          = true }
    function toggleRepeat() { if (cmdToggleRepeat.running) return; cmdToggleRepeat.running  = true }
    function toggleRandom() { if (cmdToggleRandom.running) return; cmdToggleRandom.running  = true }

    Process {
        id: cmdStatus
        command: ["mpc", "status"]

        stdout: StdioCollector {
            onStreamFinished: {

                var lines = text.split("\n")

                // mpd status
                if (lines[0] === "" ) { root.mpdOnline = false; return }
                else { root.mpdOnline = true }

                // empty
                 if (lines[0].includes("volume:")) {
                    songTitle = "Empty";
                    songArtist = "";
                    coverPath = coverFolder + "default.jpg"
                    return;
                }

                // first line
                if (lines.length > 0 && lines[0].trim() !== "") {
                    var fullFilename = lines[0].trim()

                    var artistMatch = fullFilename.match(/^(.*?)\s*-\s*/)
                    if (artistMatch) {
                        root.songArtist = artistMatch[1]
                        var songMatch = fullFilename.match(/-\s*(.*?)\.mp3$/)
                        root.songTitle = songMatch ? songMatch[1] : fullFilename
                    } else {
                        root.songArtist = ""
                        root.songTitle = fullFilename.replace(/\.mp3$/, "")
                    }

                    root.playlistEmpty = false
                } else {
                    root.playlistEmpty = true
                    root.songTitle = ""
                    root.songArtist = ""
                }

                // second line
                if (lines.length > 1) {
                    root.isPlaying = lines[1].indexOf("[playing]") !== -1

                    var timeMatch = lines[1].match(/(\d+):(\d+)\/(\d+):(\d+)/)
                    if (timeMatch) {
                        root.elapsed   = timeMatch[1] + ":" + timeMatch[2].padStart(2, '0')
                        root.total     = timeMatch[3] + ":" + timeMatch[4].padStart(2, '0')
                        root.progress = elapsed + "/" + total

                        var elapsedSec       = parseInt(timeMatch[1]) * 60 + parseInt(timeMatch[2])
                        var totalSec         = parseInt(timeMatch[3]) * 60 + parseInt(timeMatch[4])
                        root.progressPercent = totalSec > 0 ? elapsedSec / totalSec : 0
                    }
                }

                // third line
                if (lines.length > 2) {
                    root.repeatOn = lines[2].indexOf("repeat: on") !== -1
                    root.randomOn = lines[2].indexOf("random: on") !== -1
                }

                updateCoverPath();
            }
        }
    }

    function refreshStatus() { if (!cmdStatus.running) cmdStatus.running = true}

    Component.onCompleted: refreshStatus()
}
