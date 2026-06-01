import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.services

Scope {
    id: root

    PanelWindow
    {
        id: musicPanel

        anchors.bottom: true
        margins.bottom: 40
        exclusiveZone:  0

        WlrLayershell.layer:         WlrLayer.Overlay
        WlrLayershell.namespace:     "quickshell-musicplayer"
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
        exclusionMode:               ExclusionMode.Ignore

        anchors.left:   true
        anchors.right:  true
        implicitHeight: window.height
        focusable:      true
        color:          "transparent"
        visible:        false

        IpcHandler {
            target: "musicplayer"
            function toggle() {
                    musicPanel.visible = !musicPanel.visible;
                    MusicService.refreshStatus();

            }
        }

        Timer
        {
            interval: 1000
            running: musicPanel.visible
            repeat: true
            onTriggered: MusicService.refreshStatus()
        }

        Rectangle
        {
            id: window
            anchors.centerIn: parent

            width:  450
            height: 250
            radius: 20
            color:  "#000000"
            focus:  true

            Keys.onPressed: (event) => {
                switch (event.key) {
                    case Qt.Key_Space:  MusicService.toggle();       event.accepted = true; break
                    case Qt.Key_H:
                    case Qt.Key_Left:   MusicService.prev();         event.accepted = true; break
                    case Qt.Key_L:
                    case Qt.Key_Right:  MusicService.next();         event.accepted = true; break
                    case Qt.Key_R:      MusicService.toggleRepeat(); event.accepted = true; break
                    case Qt.Key_Z:      MusicService.toggleRandom(); event.accepted = true; break
                    case Qt.Key_Escape: musicPanel.visible = false; event.accepted = true; break
                }
            }

            ColumnLayout
            {
                id: content
                anchors.fill:    parent
                anchors.margins: 28
                spacing:         10
                opacity:         1

                RowLayout
                {
                    Layout.fillWidth: true
                    spacing: 16

                    // 封面占位图 (可以用 Image 替换)
                    Rectangle
                    {
                        width:  48
                        height: 48
                        radius: 8
                        color:  "#333333" // 深灰色背景

                        Image {
                            id: coverImage
                            anchors.fill: parent
                            source: "file://" + MusicService.coverPath  // 添加 file:// 前缀
                            fillMode: Image.PreserveAspectCrop
                            visible: MusicService.coverPath !== "" && status === Image.Ready
                            asynchronous: true
                        }

                        // // 默认显示一个音乐图标 (Nerd Font)
                        // Text {
                        //     anchors.centerIn: parent
                        //     text: "󰎆"
                        //     color: "#888888"
                        //     font.pixelSize: 24
                        //     visible: true // 如果 Image 加载成功则设为 false
                        //     RotationAnimation on rotation {
                        //                 id: rotateAnim
                        //                 from: 0
                        //                 to: 360
                        //                 duration: 10000
                        //                 loops: Animation.Infinite
                        //                 running: MusicService.isPlaying && musicPanel.visible  //
                        //     }
                        // }
                    }

                    // 歌曲标题与艺术家
                    ColumnLayout
                    {
                        spacing: 2

                        Text
                        {
                            Layout.fillWidth: true
                            text: MusicService.songTitle || "Unknown Title"
                            color: "#FFFFFF"
                            font.pixelSize: 16
                            font.bold: true
                            elide: Text.ElideRight // 标题过长时显示省略号
                        }

                        Text
                        {
                            Layout.fillWidth: true
                            text: MusicService.songArtist || "Unknown Artist"
                            color: "#AAAAAA"
                            font.pixelSize: 13
                            elide: Text.ElideRight
                        }
                    }

                    // 弹簧，将内容推向左侧
                    Item { Layout.fillWidth: true }
                }

                Item
                {
                    Layout.fillWidth: true
                    height: 18

                    Rectangle
                    {
                        anchors.left: parent.left;
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        height: 4
                        radius: 4
                        color: "#888888"

                        Rectangle
                        {
                            width:  parent.width * MusicService.progressPercent
                            height: parent.height
                            radius: 3
                            color: "#ffffff"
                            Behavior on width { NumberAnimation { duration: 800; easing.type: Easing.OutCubic } }
                        }
                    }
                }

                RowLayout
                {
                    Layout.fillWidth: true
                    Layout.leftMargin: 10 // 在这里设置左边距

                    Rectangle
                    {
                        width:  10;
                        height: 10;
                        color: "transparent"

                        Text
                        {
                            anchors.centerIn: parent
                            text: MusicService.elapsed
                            font.pixelSize: 10
                            color: "#888888"
                        }
                    }

                    Item { Layout.fillWidth: true }

                    Rectangle
                    {
                        width:  10;
                        height: 10;
                        color: "transparent"

                        Text
                        {
                            anchors.centerIn: parent
                            text: MusicService.total
                            font.pixelSize: 10
                            color: "#888888"
                        }
                    }

                }

                RowLayout
                {
                    Layout.fillWidth: true

                    ControlButton { label: "󰑖"; size: 40; active: MusicService.repeatOn; onClicked: MusicService.toggleRepeat() }
                    Item          { Layout.fillWidth: true }
                    ControlButton { label: "󰒮"; size: 50; onClicked: MusicService.prev() }
                    Item          { width: 10 }

                    Rectangle
                    {
                        width: 58;
                        height: 58;
                        radius: 29;
                        color: "#ffffff"
                        Text { anchors.centerIn: parent; text: MusicService.isPlaying ? "⏸" : "󰐊"; color: "#000000"; font.pixelSize: 24}

                        TapHandler   { onTapped: MusicService.toggle() }
                        HoverHandler { id: playHov }

                        scale: playHov.hovered ? 1.08 : 1.0
                        Behavior on scale { NumberAnimation { duration: 120 } }
                    }

                    Item          { width: 10 }
                    ControlButton { label: "󰒭"; size: 50; onClicked: MusicService.next() }
                    Item          { Layout.fillWidth: true }
                    ControlButton { label: "󰒝"; size: 40; active: MusicService.randomOn; onClicked: MusicService.toggleRandom() }
                }
            }
        }
    }

    component ControlButton: Rectangle
    {
        id: btn

        property string label:  ""
        property int    size:   44
        property bool   active: false

        signal clicked()

        width:  size
        height: size
        radius: size / 2
        color:  active ? "#888888" : "transparent"

        Text
        {
            anchors.centerIn: parent
            text:  btn.label
            color: btn.active ? "#000000" : "#EEEEEE"
            font.pixelSize: btn.size * 0.42
        }

        HoverHandler { id: hvr }
        TapHandler   { onTapped: btn.clicked() }

        scale: hvr.hovered ? 1.12 : 1.0
        Behavior on scale { NumberAnimation { duration: 100 } }
        Behavior on color { ColorAnimation  { duration: 150 } }
    }
}
