pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property list<string> wallpapers: []
    property string currentWallpaper: ""
    property string searchQuery: ""
    readonly property var filteredWallpapers:
    {
        const q = searchQuery.toLowerCase();
        if (q === "") return wallpapers;
        return wallpapers.filter(p => { return p.split('/').pop().toLowerCase().includes(q);});
    }

    Process
    {
        id: scanner
        command: ["sh", "-c", "find ~/Pictures/Wallpaper -type f \\( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \\) 2>/dev/null | sort -u | head -200"]
        running: true
        stdout: SplitParser
        {
            onRead: data => { root.wallpapers = [...root.wallpapers, data.trim()]; }
        }
    }

    FileView
    {
        id: wallpaperFile
        path: Quickshell.env("HOME") + "/.cache/wallpaper.conf"
        onTextChanged: { root.currentWallpaper = wallpaperFile.text().trim(); }
    }

    function setWallpaper(path)
    {
        if (!path) return;
        currentWallpaper = path;

        setProcess.command = ["awww", "img", path, "--transition-type", "any", "--transition-duration", "3", "--transition-fps", "60", "--transition-bezier", ".43,1.19,1,.4"];
        setProcess.running = true;

        saveProcess.command = ["sh", "-c", 'printf "%s" "$1" > "$HOME/.cache/wallpaper.conf"', "sh", path];
        saveProcess.running = true;

        notifyProcess.command = ["notify-send", "壁纸已切换", path.split('/').pop(), "-i", path];
        notifyProcess.running = true;
    }

    Process { id: setProcess; command: []; running: false }
    Process { id: saveProcess; command: []; running: false }
    Process { id: notifyProcess; command: []; running: false }
}
