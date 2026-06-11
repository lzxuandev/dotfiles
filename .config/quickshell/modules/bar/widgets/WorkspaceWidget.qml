import QtQuick
import Quickshell
import Quickshell.Hyprland

Item {
    id: workspace
    implicitWidth: layout.width
    implicitHeight: layout.height

    Row {
        id: layout
        spacing: 15

        Repeater {
            model: 5

            delegate: Item {
                property int  wsId: index + 1
                property var  ws: Hyprland.workspaces.values.find(w => w.id === wsId)
                property bool isActive: Hyprland.focusedWorkspace?.id === wsId

                width: dotText.width
                height: dotText.height

                Text
                {
                    id: dotText
                    text: "●"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 13
                    font.bold: true
                    color: isActive ? "#EEEEEE" : (ws ? "#888888" : "#333333")

                    scale: (mouseHandler.containsMouse) ? 2.0 : 1.0

                    Behavior on scale
                    {
                        NumberAnimation
                        {
                            duration: 200
                            easing.type: Easing.OutCubic
                        }
                    }
                }

                MouseArea
                {
                    id: mouseHandler
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onClicked: Hyprland.dispatch("workspace " + wsId)
                }
            }
        }
    }
}
