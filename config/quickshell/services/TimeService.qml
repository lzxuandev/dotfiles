pragma Singleton

import QtQuick
import Quickshell

Singleton
{
    id: root

    SystemClock
    {
        id: clock
        precision: SystemClock.Seconds
    }

    function getTime()
    {
        return Qt.formatDateTime(clock.date, "ddd hh:mm AP")
    }
}
