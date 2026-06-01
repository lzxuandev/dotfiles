import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import qs.services

Scope
{
    id: root

    IpcHandler
    {
        target: "launcher"

        function toggle(): void
        {
            launcherPanel.visible = !launcherPanel.visible
            if (launcherPanel.visible) {
                searchInput.text = "";
                searchInput.forceActiveFocus();
                AppService.reset();
            }
        }
    }

    PanelWindow
    {
        id: launcherPanel

        anchors.left: true
        anchors.right: true
        anchors.bottom: true
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
                spacing: 30 //

                // Inputbar
                Rectangle
                {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45
                    color: "#101010"
                    radius: 10
                    border.width: 1
                    border.color: "#11ffffff"

                    Rectangle {
                        id: notch
                        width: 300 // 刘海的宽度
                        height: 10 // 刘海的高度
                        color: "black" // 这里可以使用你的 window 背景色，或者你想用的任意颜色
                        radius: 15 // 轻微圆角，与整体风格一致

                        // 定位：父容器顶部水平中心
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top

                        anchors.topMargin: -(height / 4)
                        z: 1 // 确保刘海盖在边框上面
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        spacing: 8

                        // Entry
                        TextInput {
                            id: searchInput
                            Layout.fillWidth: true
                            color: "#F8F4FF"
                            font.pixelSize: 14
                            focus: true
                            verticalAlignment: Text.AlignVCenter

                            onTextChanged: { AppService.searchText = text; AppService.selectedIndex = 0; }

                            Keys.onPressed: event =>
                            {
                                const count = resultsList.count;
                                if (event.key === Qt.Key_Down || event.key === Qt.Key_Tab)
                                {
                                    event.accepted = true;
                                    AppService.selectedIndex = (AppService.selectedIndex + 1) % count;
                                } else if (event.key === Qt.Key_Up) {
                                    event.accepted = true;
                                    AppService.selectedIndex = (AppService.selectedIndex - 1 + count) % count;
                                } else if (event.key === Qt.Key_Return) {
                                    event.accepted = true;
                                    if (AppService.launchAtIndex(AppService.selectedIndex)) launcherPanel.visible = false;
                                } else if (event.key === Qt.Key_Escape) {
                                    launcherPanel.visible = false;
                                }
                                resultsList.positionViewAtIndex(AppService.selectedIndex, ListView.Contain);
                            }
                        }
                    }
                }

                // Listview
                ListView {
                    id: resultsList
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: AppService.filteredApps
                    currentIndex: AppService.selectedIndex
                    clip: true
                    spacing: 15 // listview spacing

                    highlightMoveDuration: 0
                    highlightResizeDuration: 0
                    highlight: Rectangle {
                        color: "#ffffff"
                        opacity: 0.05 // selected.normal background: rgba(255,255,255,0.05)
                        radius: 12 // element border-radius
                    }

                    // Element
                    delegate: Item {
                        width: ListView.view.width
                        height: 50

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            spacing: 20

                            // Element Icon
                            IconImage
                            {
                                width: 28;
                                height: 28;
                                source: modelData.icon ? Quickshell.iconPath(modelData.icon, true) : ""

                            }

                            // Element Text
                            Text {
                                text: modelData.name
                                Layout.fillWidth: true
                                font.family: "JetbrainsMono Nerd Font"
                                font.bold: true
                                font.pixelSize: 14
                                color: AppService.selectedIndex === index ? "#EEEEEE" : "#CCCCCCCC"
                            }
                        }

                        // Mouse Interaction
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: AppService.selectedIndex = index
                            onClicked: if (AppService.launchAtIndex(index)) launcherPanel.visible = false;
                        }
                    }
                }
            }
        }
    }
}
