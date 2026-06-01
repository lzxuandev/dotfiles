import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects
import qs.services

Scope
{
    PanelWindow
    {
        id: wallpaperPanel
        visible: false

        anchors.left:   true
        anchors.right:  true
        anchors.bottom: true

        implicitHeight: window.height
        focusable:      true

        color:          "transparent"

        WlrLayershell.layer: WlrLayer.Top
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

        exclusionMode: ExclusionMode.Ignore

        IpcHandler
        {
            target: "wallpaper"

            function toggle(): void
            {
                wallpaperPanel.visible = !wallpaperPanel.visible;
            }
        }

        Rectangle
        {
            id: window

            anchors.centerIn: parent

            width: 1200
            height: 300
            radius: 40
            color: "black"

            Canvas {
                id: leftBottomEar
                anchors.right: window.left
                anchors.bottom: window.bottom
                width: 40
                height: 40
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
                width: 40
                height: 40
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
                spacing: 10

                PathView
                {
                    id: wheel
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    model: WallpaperService.filteredWallpapers
                    pathItemCount: 5
                    preferredHighlightBegin: 0.5
                    preferredHighlightEnd: 0.5
                    highlightRangeMode: PathView.StrictlyEnforceRange
                    snapMode: PathView.SnapToItem
                    focus: true
                    Keys.onLeftPressed: decrementCurrentIndex()
                    Keys.onRightPressed: incrementCurrentIndex()

                    Keys.onPressed: (event) =>
                    {
                        if (event.key === Qt.Key_H)
                        {
                            decrementCurrentIndex();
                            event.accepted = true;
                        }
                        else if (event.key === Qt.Key_L)
                        {
                            incrementCurrentIndex();
                            event.accepted = true;
                        }
                        else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                        {
                            WallpaperService.setWallpaper(WallpaperService.filteredWallpapers[currentIndex]);
                            wallpaperPanel.visible = false
                            event.accepted = true;
                        }
                        else if (event.key === Qt.Key_Escape) {
                            wallpaperPanel.visible = false
                            event.accepted = true;
                        }
                    }

                    path: Path
                    {
                        startX: 0
                        startY: wheel.height / 2
                        PathLine { x: wheel.width; y: wheel.height / 2 }
                    }

                    delegate: Item
                    {
                        width: 280; height: 200
                        z: PathView.isCurrentItem ? 10 : 1

                        readonly property bool isCurrent: PathView.isCurrentItem
                        readonly property string wallpaperPath: modelData

                        Column
                        {
                            anchors.centerIn: parent
                            spacing: 12
                            scale: isCurrent ? 1.2 : 0.75
                            opacity: isCurrent ? 1.0 : 0.6

                            Behavior on scale   { NumberAnimation { duration: 300; easing.type: Easing.OutBack } }

                            Rectangle
                            {
                                id: imgContainer
                                width: 240
                                height: 135
                                radius: 20
                                color: "#11111b"
                                clip: true

                                layer.enabled: true
                                layer.effect: OpacityMask {
                                    maskSource: Rectangle {
                                        width: imgContainer.width
                                        height: imgContainer.height
                                        radius: imgContainer.radius
                                    }
                                }

                                Image
                                {
                                    anchors.fill: parent
                                    source: "file://" + wallpaperPath
                                    fillMode: Image.PreserveAspectCrop
                                    asynchronous: true
                                    sourceSize.width: 480
                                    visible: status === Image.Ready
                                }
                            }

                            Text
                            {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: wallpaperPath.split('/').pop().split('.')[0]
                                color: isCurrent ? "#CCCCCC" : "#888888"
                                font.pixelSize: 11; font.bold: isCurrent
                                elide: Text.ElideRight; width: 200
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        TapHandler
                        {
                            onTapped:
                            {
                                wheel.currentIndex = index
                                if (isCurrent) WallpaperService.setWallpaper(wallpaperPath);
                                wallpaperPanel.visible = false
                            }
                        }

                    }
                }
            }

        }

    }

}
