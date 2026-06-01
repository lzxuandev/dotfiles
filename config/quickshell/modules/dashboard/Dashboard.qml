import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import qs.services

Scope {
    PanelWindow {
        id: window

        IpcHandler {
            target: "dashboard"
            function toggle() {
                window.visible = !window.visible
            }
        }

        anchors {
            right: true
            left: true
            bottom: true
            top: true
        }

        color: "transparent"

        WlrLayershell.namespace: "shell:dashboard"
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
        exclusionMode: ExclusionMode.Normal
        focusable: true
        exclusiveZone: 0

        visible: false

        Rectangle {
            anchors.fill: parent
            color: "#0d0d0d"
            opacity: 0.97

            RowLayout {
                anchors.fill: parent
                anchors.margins: 30
                spacing: 20

                col {}
                colperf {}
                colhist {}
                colinfo {}
            }
        }
    }

    Item {
        id: col
        Layout.fillWidth: true

        ColumnLayout {
            spacing: 15

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 140
                color: "#1a1a1a"
                radius: 20

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 8

                    RowLayout {
                        spacing: 10

                        Rectangle {
                            width: 36
                            height: 36
                            radius: 18
                            color: "#2d2d2d"

                            Text {
                                anchors.centerIn: parent
                                text: "O"
                                color: "#cdd6f4"
                                font.pointSize: 14
                                font.bold: true
                            }
                        }

                        ColumnLayout {
                            spacing: 2

                            Text {
                                text: "Capture"
                                color: "#cdd6f4"
                                font.pointSize: 14
                                font.bold: true
                            }

                            Text {
                                text: "screenshot / record"
                                color: "#6c7086"
                                font.pointSize: 11
                            }
                        }
                    }

                    RowLayout {
                        spacing: 10
                        Layout.topMargin: 10

                        Rectangle {
                            width: 44
                            height: 44
                            radius: 22
                            color: "#2d2d2d"

                            Text {
                                anchors.centerIn: parent
                                text: "S"
                                color: "#a6adc8"
                                font.pointSize: 14
                            }
                        }

                        Rectangle {
                            width: 44
                            height: 44
                            radius: 22
                            color: "#2d2d2d"

                            Text {
                                anchors.centerIn: parent
                                text: "R"
                                color: "#a6adc8"
                                font.pointSize: 14
                            }
                        }

                        Rectangle {
                            width: 44
                            height: 44
                            radius: 22
                            color: "#2d2d2d"

                            Text {
                                anchors.centerIn: parent
                                text: "M"
                                color: "#a6adc8"
                                font.pointSize: 14
                            }
                        }
                    }

                    Item { Layout.fillHeight: true }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: window.visible = false
                }
            }
        }
    }

    Item {
        id: colperf
        Layout.fillWidth: true

        ColumnLayout {
            spacing: 15

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 140
                color: "#1a1a1a"
                radius: 20

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 8

                    RowLayout {
                        spacing: 10

                        Rectangle {
                            width: 36
                            height: 36
                            radius: 18
                            color: "#2d2d2d"

                            Text {
                                anchors.centerIn: parent
                                text: "P"
                                color: "#cdd6f4"
                                font.pointSize: 14
                                font.bold: true
                            }
                        }

                        ColumnLayout {
                            spacing: 2

                            Text {
                                text: "Performance"
                                color: "#cdd6f4"
                                font.pointSize: 14
                                font.bold: true
                            }

                            Text {
                                text: "system metrics"
                                color: "#6c7086"
                                font.pointSize: 11
                            }
                        }
                    }

                    RowLayout {
                        spacing: 15
                        Layout.topMargin: 10

                        Rectangle {
                            width: 60
                            height: 50
                            color: "#2d2d2d"
                            radius: 12

                            ColumnLayout {
                                anchors.fill: parent

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "CPU"
                                    color: "#89b4fa"
                                    font.pointSize: 10
                                }

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: SystemUsage.cpuPerc.toFixed(0) + "%"
                                    color: "#89b4fa"
                                    font.pointSize: 16
                                    font.bold: true
                                }
                            }
                        }

                        Rectangle {
                            width: 60
                            height: 50
                            color: "#2d2d2d"
                            radius: 12

                            ColumnLayout {
                                anchors.fill: parent

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "RAM"
                                    color: "#f9e2af"
                                    font.pointSize: 10
                                }

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: SystemUsage.memPercent.toFixed(0) + "%"
                                    color: "#f9e2af"
                                    font.pointSize: 16
                                    font.bold: true
                                }
                            }
                        }

                        Rectangle {
                            width: 60
                            height: 50
                            color: "#2d2d2d"
                            radius: 12

                            ColumnLayout {
                                anchors.fill: parent

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "VRAM"
                                    color: "#f38ba8"
                                    font.pointSize: 10
                                }

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: SystemUsage.vramUsed.toFixed(0)
                                    color: "#f38ba8"
                                    font.pointSize: 16
                                    font.bold: true
                                }
                            }
                        }
                    }

                    Item { Layout.fillHeight: true }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: window.visible = false
                }
            }
        }
    }

    Item {
        id: colhist
        Layout.fillWidth: true

        ColumnLayout {
            spacing: 15

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 140
                color: "#1a1a1a"
                radius: 20

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 8

                    RowLayout {
                        spacing: 10

                        Rectangle {
                            width: 36
                            height: 36
                            radius: 18
                            color: "#2d2d2d"

                            Text {
                                anchors.centerIn: parent
                                text: "H"
                                color: "#cdd6f4"
                                font.pointSize: 14
                                font.bold: true
                            }
                        }

                        ColumnLayout {
                            spacing: 2

                            Text {
                                text: "History"
                                color: "#cdd6f4"
                                font.pointSize: 14
                                font.bold: true
                            }

                            Text {
                                text: "recent captures"
                                color: "#6c7086"
                                font.pointSize: 11
                            }
                        }
                    }

                    Text {
                        Layout.topMargin: 20
                        text: "No captures yet"
                        color: "#45475a"
                        font.pointSize: 12
                    }

                    Item { Layout.fillHeight: true }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: window.visible = false
                }
            }
        }
    }

    Item {
        id: colinfo
        Layout.fillWidth: true

        ColumnLayout {
            spacing: 15

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 140
                color: "#1a1a1a"
                radius: 20

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 8

                    RowLayout {
                        spacing: 10

                        Rectangle {
                            width: 36
                            height: 36
                            radius: 18
                            color: "#2d2d2d"

                            Text {
                                anchors.centerIn: parent
                                text: "I"
                                color: "#cdd6f4"
                                font.pointSize: 14
                                font.bold: true
                            }
                        }

                        ColumnLayout {
                            spacing: 2

                            Text {
                                text: "Info"
                                color: "#cdd6f4"
                                font.pointSize: 14
                                font.bold: true
                            }

                            Text {
                                text: "system status"
                                color: "#6c7086"
                                font.pointSize: 11
                            }
                        }
                    }

                    Column {
                        spacing: 4
                        Layout.topMargin: 10

                        Text {
                            text: "Network: " + NetworkService.getName()
                            color: "#a6adc8"
                            font.pointSize: 11
                        }

                        Text {
                            text: "Battery: " + BatteryService.getPercentage()
                            color: "#a6adc8"
                            font.pointSize: 11
                        }

                        Text {
                            text: "Time: " + TimeService.getTime()
                            color: "#a6adc8"
                            font.pointSize: 11
                        }

                        Text {
                            text: "Music: " + (MusicService.currentFile || "None")
                            color: "#a6adc8"
                            font.pointSize: 11
                        }
                    }

                    Item { Layout.fillHeight: true }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: window.visible = false
                }
            }
        }
    }
}