import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.services

Scope
{
    id: root

    IpcHandler
    {
        target: "clipboard"
        function toggle() { clipboardPanel.visible = !clipboardPanel.visible }
    }

    PanelWindow
    {
        id: clipboardPanel

        anchors.left:  true;
        anchors.right: true
        anchors.bottom: true;
        implicitHeight: window.height

        exclusiveZone: 0
        visible: false
        color: "transparent"
        focusable: true

        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

        exclusionMode: ExclusionMode.Ignore

        Rectangle
        {
            id: window
            anchors.centerIn: parent

            width: 450;
            height: 500;
            radius: 20
            color: "black"

            Canvas {
                id: leftBottomEar
                anchors.right: window.left
                anchors.bottom: window.bottom
                width: 80
                height: 80
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    ctx.fillStyle = "black";
                    ctx.beginPath();
                    ctx.moveTo(width, height);
                    ctx.lineTo(0, height);
                    ctx.arc(0, 0, width, Math.PI / 2, 0, true);
                    ctx.closePath();
                    ctx.fill();
                }
            }

            Canvas {
                id: rightBottomEar
                anchors.left: window.right
                anchors.bottom: window.bottom
                width: 80
                height: 80
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    ctx.fillStyle = "black";
                    ctx.beginPath();
                    ctx.moveTo(0, height);
                    ctx.lineTo(width, height);
                    ctx.arc(width, 0, width, Math.PI / 2, Math.PI, false);
                    ctx.closePath();
                    ctx.fill();
                }
            }

            Rectangle { width: 200; height: 200; color: "black"; anchors.bottom: parent.bottom; anchors.left: parent.left   }
            Rectangle { width: 200; height: 200; color: "black"; anchors.bottom: parent.bottom; anchors.right: parent.right }

            ColumnLayout
            {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 30

                Text
                {
                    text: "CLIPBOARD"
                    color: "#CCCCCC"
                    font { pixelSize: 16; bold: true; family: "JetBrainsMono Nerd Font" }
                    Layout.alignment: Qt.AlignHCenter
                }

                ListView
                {
                    id: listView
                    Layout.fillWidth: true
                    Layout.fillHeight: true;
                    model: ClipboardService.entries
                    focus: true;
                    clip: true;
                    spacing: 15

                    highlightMoveDuration: 0
                    highlightResizeDuration: 0
                    highlight: Rectangle
                    {
                        color: "#ffffff";
                        opacity: 0.05;
                        radius: 12
                    }

                    delegate: Item
                    {
                        width: ListView.view.width;
                        height: 50

                        RowLayout
                        {
                            anchors { fill: parent; leftMargin: 15; rightMargin: 15 }
                            spacing: 20

                            Text
                            {
                                text: "󰅍"
                                font { family: "JetBrainsMono Nerd Font"; pixelSize: 18 }
                                color: listView.currentIndex === index ? "#f2e5bc" : "#f2e5bc"
                            }

                            Text
                            {
                                text: modelData.preview
                                Layout.fillWidth: true
                                color: listView.currentIndex === index ? "#EEEEEE" : "#88EEEEEE"
                                font { family: "JetBrainsMono Nerd Font"; pixelSize: 14; bold: listView.currentIndex === index }
                                elide: Text.ElideRight
                            }
                        }

                        MouseArea
                        {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: listView.currentIndex = index
                            onClicked:
                            {
                                ClipboardService.copy(modelData.rawLine)
                                clipboardPanel.visible = false
                            }
                        }
                    }
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_J) {
                            incrementCurrentIndex();
                        } else if (event.key === Qt.Key_K) {
                            decrementCurrentIndex();
                        } else if (event.key === Qt.Key_Escape) {
                            clipboardPanel.visible = false;
                        } else if (event.key === Qt.Key_Return) {
                            ClipboardService.copy(model[currentIndex].rawLine);
                            clipboardPanel.visible = false;
                        }
                    }
                }
            }
        }
    }
}
