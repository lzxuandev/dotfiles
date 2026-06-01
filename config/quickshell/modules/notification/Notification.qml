import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.services

Scope {

    PanelWindow {
        id: panelWindow
        anchors.top: true
        anchors.left: true
        anchors.right: true
        margins.left: 200

        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.namespace: "quickshell-notification"

        visible: NotificationService.notifications.length > 0
        color: "transparent"
        exclusiveZone: 0

        implicitWidth: 430
        implicitHeight: window.implicitHeight

        Item {
            id: notificationUI
            anchors.fill: parent

            Canvas {
                id: leftEar
                anchors.right: window.left
                anchors.top: window.top
                width: 16
                height: 16
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    ctx.fillStyle = "black";
                    ctx.beginPath();
                    ctx.moveTo(0, 0);
                    ctx.lineTo(width, 0);
                    ctx.lineTo(width, height);
                    ctx.arc(0, height, width, 0, -Math.PI/2, true);
                    ctx.fill();
                }
            }

            Rectangle {
                id: window
                anchors.right: parent.right

                implicitWidth: 400
                implicitHeight: notificationColumn.implicitHeight + 20
                color: "black"
                radius: 16

                // 遮盖圆角矩形的特定角落以实现特定的 UI 设计
                Rectangle { width: 16; height: 16; color: "black"; anchors.top: parent.top; anchors.left: parent.left }
                Rectangle { width: 16; height: 16; color: "black"; anchors.top: parent.top; anchors.right: parent.right }
                Rectangle { width: 16; height: 16; color: "black"; anchors.bottom: parent.bottom; anchors.right: parent.right }

                ColumnLayout {
                    id: notificationColumn
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 12

                    Repeater {
                        model: NotificationService.notifications

                        // 使用拆分出的组件
                        delegate: NotificationCard {
                            notificationData: modelData
                        }
                    }
                }
            }
        }
    }
}
