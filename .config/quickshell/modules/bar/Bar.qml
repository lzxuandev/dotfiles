import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.modules.bar.widgets

Scope
{
    IpcHandler
    {
        target: "bar"
        function toggle()
        {
            bar.visible = !bar.visible;
        }
    }

    PanelWindow
    {
        id: bar

        anchors.top:    true
        anchors.left:   true
        anchors.right:  true
        implicitHeight: 40
        color:          "black"

        RowLayout
        {
            id: left
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            spacing: 30

            ArchWidget {}
            WorkspaceWidget {}
        }

        RowLayout
        {
            id: center
            anchors.centerIn: parent
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20

            ClockWidget {}
        }

        RowLayout
        {
            id: right
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20

            NetworkWidget {}
            VolumeWidget {}
            BatteryWidget {}
        }
    }
}
