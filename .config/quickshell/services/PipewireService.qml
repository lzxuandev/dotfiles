pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton
{
    id: root

    property var  sink:   Pipewire.defaultAudioSink
    property real volume: sink ? sink.audio.volume : 0
    property bool muted:  sink ? sink.audio.muted  : 0

    signal changed()

    PwObjectTracker
    {
        objects: [sink]
    }

    Connections
    {
        target: sink ? sink.audio : null

        function onVolumeChanged() {changed()}
        function onMutedChanged()  {changed()}
    }

    function getIcon()
    {
        if (muted) return "󰝟";

        if (volume <= 0.30) return "";
        if (volume <= 0.60) return "";
        if (volume <= 1.20) return "";
        return "⚠"
    }

    function getPercentage()
    {
        return Math.round(PipewireService.volume * 100) + "%"
    }
}
