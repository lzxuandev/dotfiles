pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: service

    property string searchText: ""
    property int selectedIndex: 0

    // 存储启动次数，格式为 { "app_id": count }
    property var launchCounts: ({})

    readonly property var filteredApps: {
        const all = [...DesktopEntries.applications.values];
        const q = searchText.trim().toLowerCase();

        // 核心排序逻辑
        const sortFunc = (a, b) => {
            // 1. 获取启动次数 (如果是 undefined 则设为 0)
            const countA = launchCounts[a.id] || 0;
            const countB = launchCounts[b.id] || 0;

            // 2. 如果搜索词为空，按启动次数排序；次数相同则按名称字母排序
            if (q === "") {
                if (countB !== countA) return countB - countA;
                return (a.name || "").localeCompare(b.name || "");
            }

            // 3. 如果正在搜索：
            const an = (a.name || "").toLowerCase();
            const bn = (b.name || "").toLowerCase();

            // 优先匹配开头
            const aStarts = an.startsWith(q);
            const bStarts = bn.startsWith(q);
            if (aStarts && !bStarts) return -1;
            if (!aStarts && bStarts) return 1;

            // 如果匹配程度相同，则按启动频率降序
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
            // 更新计数逻辑
            let newCounts = launchCounts;
            newCounts[entry.id] = (newCounts[entry.id] || 0) + 1;
            launchCounts = newCounts; // 重新赋值以触发属性通知

            entry.execute();
            return true;
        }
        return false;
    }

    function reset() { searchText = ""; selectedIndex = 0; }
}
