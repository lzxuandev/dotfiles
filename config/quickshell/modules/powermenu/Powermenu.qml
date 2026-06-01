import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

ShellRoot
{
    PanelWindow
    {
        id: window

        property int currentIndex: 0

        anchors.top: true
        anchors.left: true
        anchors.right: true
        anchors.bottom: true

        visible: false
        color: "transparent"

        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.namespace: "quickshell-powermenu"
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

        exclusionMode: ExclusionMode.Ignore

        IpcHandler
        {
            target: "powermenu"
            function toggle() { window.visible = !window.visible;}
        }

        Rectangle
        {
            anchors.fill: parent
            color: "black"
            focus: window.visible

            Keys.onPressed: (event) =>
            {
                if (!window.visible) return

                if (event.key === Qt.Key_H)
                {
                    window.currentIndex = Math.max(0, window.currentIndex - 1)
                    event.accepted = true
                }
                else if (event.key === Qt.Key_L)
                {
                    window.currentIndex = Math.min(repeater.count - 1, window.currentIndex + 1)
                    event.accepted = true
                }
                else if (event.key === Qt.Key_Return)
                {
                    repeater.itemAt(window.currentIndex).trigger()
                    event.accepted = true
                }
                else if (event.key === Qt.Key_Escape)
                {
                    window.visible = false
                    event.accepted = true
                }
            }

            ColumnLayout
            {
                anchors.centerIn: parent
                spacing: 40

                ColumnLayout
                {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 10

                    Text
                    {
                        text: "󰐥";
                        font.pixelSize: 28;
                        color: "#555555";
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Text
                    {
                        text: "POWER MENU"
                        font { pixelSize: 12; weight: Font.Medium; letterSpacing: 4 }
                        color: "#888888"
                        Layout.alignment: Qt.AlignHCenter
                    }
                }

                Row
                {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 30

                    Repeater
                    {
                        id: repeater

                        model: [
                            { icon: "󰌾", label: "Lock",      col: "#f2e5bc", cmd: "quickshell -p " + Quickshell.env("HOME") + "/.config/quickshell/modules/lock/Lock.qml" },
                            { icon: "󰒲", label: "Suspend",   col: "#ebdbb2", cmd: "systemctl suspend" },
                            { icon: "󰋊", label: "Hibernate", col: "#fab387", cmd: "systemctl hibernate" },
                            { icon: "󰍃", label: "Logout",    col: "#efb8c8", cmd: "loginctl terminate-user $USER" },
                            { icon: "󰜉", label: "Reboot",    col: "#bdae93", cmd: "systemctl reboot" },
                            { icon: "󰐥", label: "Power Off", col: "#f2b8b5", cmd: "systemctl poweroff" }
                        ]

                        delegate: Item
                        {
                            width: 110; height: 150

                            property bool hovered: mouseArea.containsMouse
                            property bool selected: index === window.currentIndex

                            function trigger()
                            {
                                window.visible = false
                                proc.command = ["bash", "-c", modelData.cmd]
                                proc.running = true
                            }

                            ColumnLayout
                            {
                                anchors.fill: parent
                                spacing: 15

                                Rectangle
                                {
                                    Layout.alignment: Qt.AlignHCenter

                                    width: 80;
                                    height: 80;
                                    radius: 40
                                    scale: mouseArea.pressed ? 0.9 : ((hovered || selected) ? 1.1 : 1.0)
                                    color: (hovered || selected) ? Qt.rgba(1, 1, 1, 0.1) : "#222222"

                                    border.width: 2
                                    border.color: (hovered || selected) ? modelData.col : Qt.rgba(1, 1, 1, 0.1)

                                    Behavior on scale { NumberAnimation { duration: 150 } }

                                    Text
                                    {
                                        anchors.centerIn: parent
                                        text: modelData.icon
                                        font.pixelSize: 30
                                        color: modelData.col
                                    }
                                }

                                Text
                                {
                                    text: modelData.label.toUpperCase()
                                    font.pixelSize: 10;
                                    font.weight: Font.Bold;
                                    font.letterSpacing: 1.5;
                                    color: (hovered || selected) ? "white" : "#666666"
                                    Layout.alignment: Qt.AlignHCenter
                                }
                            }

                            MouseArea
                            {
                                id: mouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: trigger()
                            }
                        }
                    }
                }
            }

            Text
            {
                text: "ESC TO CANCEL"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 60
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 10
                font.letterSpacing: 2
                color: "#444444"
            }

            Process
            {
                id: proc
                command: []
                running: false
            }

        }

    }
}
