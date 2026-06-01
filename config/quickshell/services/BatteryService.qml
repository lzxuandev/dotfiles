pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower

Singleton
{
    id: root

    readonly property var  battery   : UPower.displayDevice
    readonly property real percentage: UPower.displayDevice.percentage

    function getPercentage()
    {
        return Math.round(percentage * 100) + "%"
    }

    function getIcon()
    {
        if (battery.state === UPowerDevice.Charging)     return "󱐋"
        if (battery.state === UPowerDevice.FullyCharged) return ""

        if (percentage <= 0.15) return ""
        if (percentage <= 0.30) return ""
        if (percentage <= 0.50) return ""
        if (percentage <= 0.95) return ""
        if (percentage <= 1.00) return ""
    }

}
