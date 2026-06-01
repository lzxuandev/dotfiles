pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: service

    property string searchText: ""
    property int selectedIndex: 0

    property var launchCounts: ({})

    readonly property var filteredApps: {
        const all = [...DesktopEntries.applications.values];
        const q = searchText.trim().toLowerCase();

        const sortFunc = (a, b) => {
            const countA = launchCounts[a.id] || 0;
            const countB = launchCounts[b.id] || 0;

            if (q === "") {
                if (countB !== countA) return countB - countA;
                return (a.name || "").localeCompare(b.name || "");
            }

            const an = (a.name || "").toLowerCase();
            const bn = (b.name || "").toLowerCase();

            const aStarts = an.startsWith(q);
            const bStarts = bn.startsWith(q);
            if (aStarts && !bStarts) return -1;
            if (!aStarts && bStarts) return 1;

            if (countB !== countA) return countB - countA;
            return an.localeCompare(bn);
        };

        if (q === "") return all.sort(sortFunc);

        return all.filter(d =>
            (d.name && d.name.toLowerCase().includes(q)) ||
            (d.genericName && d.genericName.toLowerCase().includes(q)) ||
            (d.keywords && d.keywords.some(k => k.toLowerCase().includes(q)))
        ).sort(sortFunc);
    }

    function launchAtIndex(index) {
        const entry = filteredApps[index];
        if (entry && typeof entry.execute === "function") {
            let newCounts = launchCounts;
            newCounts[entry.id] = (newCounts[entry.id] || 0) + 1;
            launchCounts = newCounts;

            entry.execute();
            return true;
        }
        return false;
    }

    function reset() { searchText = ""; selectedIndex = 0; }
}
