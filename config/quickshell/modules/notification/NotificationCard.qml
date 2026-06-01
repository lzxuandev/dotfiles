import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services

Rectangle
{
    id: card

    property var notificationData

    Layout.fillWidth: true
    implicitHeight: cardContent.implicitHeight + 24

    color: "#1b1b1b"
    radius: 12
    clip: true

    Rectangle {
        width: 3
        height: parent.height - 20
        radius: 2
        anchors.left: parent.left
        anchors.leftMargin: 6
        anchors.verticalCenter: parent.verticalCenter
        color: "#AAAAAA"
    }

    ColumnLayout {
        id: cardContent
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 12
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        spacing: 6


        RowLayout
        {
            Layout.fillWidth: true
            spacing: 10

            ColumnLayout
            {
                Layout.fillWidth: true
                spacing: 2

                Text
                {
                    text: notificationData.summary
                    color: "#e6e1e5"
                    font.pointSize: 11
                    font.bold: true
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }
                Text
                {
                    text: notificationData.body
                    color: "#938f99"
                    font.pointSize: 10
                    wrapMode: Text.Wrap
                    maximumLineCount: 3
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }
            }

            Rectangle
            {
                visible: notificationData.image !== ""
                Layout.preferredWidth:  64
                Layout.preferredHeight: 36
                radius: 6
                clip: true

                Image
                {
                    id: cardImage
                    anchors.fill: parent
                    source: notificationData.image
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                    onStatusChanged: {
                        if (cardImage.status === Image.Error) {
                            cardImage.visible = false;
                            cardImage.parent.visible = false;
                        }
                    }
                }
            }
        }
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked: NotificationService.dismiss(notificationData.id);
    }
}
