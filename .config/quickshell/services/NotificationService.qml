pragma Singleton

import QtQuick
import QtMultimedia
import Quickshell
import Quickshell.Services.Notifications

Singleton
{
    id: root

    property var notifications: []

    SoundEffect
    {
        id: notifySound
        source: "/home/lzx/.local/share/sounds/message.wav"
        volume: 0.3
    }

    NotificationServer
    {
        id: server
        actionsSupported:    true
        bodySupported:       true
        bodyMarkupSupported: true
        imageSupported:      true
        keepOnReload:        true

        onNotification: function(notification)
        {
            try {
                if (!notification.summary && !notification.body) return;

                notifySound.play();

                const id = Date.now() + Math.random();

                var validImage = notification.image && notification.image.startsWith("file://") ? notification.image : "";

                var data =
                {
                    "id": id,
                    "summary": notification.summary || "",
                    "body": notification.body || "",
                    "image": validImage,
                    "appName": notification.appName || "System",
                    "appIcon": notification.appIcon || "",
                    "urgency": notification.urgency || 0,
                    "actions": notification.actions || [],
                    "target": notification
                };

                notifications = [data, ...notifications];

                const timer = Qt.createQmlObject('import QtQuick; Timer { interval: 4000; onTriggered: destroy() }', root);
                timer.triggered.connect(() => {notifications = notifications.filter(item => item.id !== id)})
                timer.start();
            } catch (e) {
                console.error("Notification error:", e);
            }
        }
    }

    function dismiss(id)
    {
        notifications.find(n => n.id === id).target.tracked = false;
        notifications = notifications.filter(item => item.id !== id);
    }

    function invokeAction(id, identifier)
    {
        const item = notifications.find(n => n.id === id);
        if (!item || !item.target.actions || !item.target.actions.length) return;

        const action = item.target.actions.find(a => a.identifier === identifier);
        if (!action) return;

        action.invoke();

        if (!item.target.resident) item.target.tracked = false;
        notifications = notifications.filter(n => n.id !== id);
    }
}
