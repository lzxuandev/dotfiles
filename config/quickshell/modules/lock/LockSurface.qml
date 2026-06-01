import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell.Wayland

Rectangle
{
    id: root

    color: "black"

    required property LockContext context
    readonly property ColorGroup colors: Window.active ? palette.active : palette.inactive

    readonly property color surface0: "#141414"
    readonly property color surface2: "#2a2a2a"
    readonly property color fg:       "#F0F0F0"
    readonly property color dim:      "#606060"
    readonly property color gold:     "#C9A84C"
    readonly property color goldSoft: "#E8C97A"
    readonly property color red:      "#C0392B"

    property real globalOrbitAngle: 0
    property bool inputActive:      false
    property real introState:       0.0
    property bool isPlayingIntro:   true

    // 开场动画
    Item
    {
        id: introOverlay
        anchors.fill: parent;
        z: 999
        visible: root.isPlayingIntro || opacity > 0

        Rectangle { id: ring3; width: 360; height: 360; radius: 180; anchors.centerIn: parent; color: "transparent"; border.color: root.gold;    border.width: 1; scale: 0.5; opacity: 0.0 }
        Rectangle { id: ring2; width: 300; height: 300; radius: 150; anchors.centerIn: parent; color: "transparent"; border.color: root.fg;      border.width: 1; scale: 0.8; opacity: 0.0 }
        Rectangle { id: ring1; width: 240; height: 240; radius: 120; anchors.centerIn: parent; color: "transparent"; border.color: root.fg;      border.width: 2; scale: 0.8; opacity: 0.0 }

        Item
        {
            id: introLockOrb; width: 170; height: 170
            anchors.centerIn: parent; scale: 0.0; opacity: 0.0
            Rectangle
            {
                anchors.fill: parent; radius: 85
                color: Qt.rgba(root.surface0.r, root.surface0.g, root.surface0.b, 0.9)
                border.color: root.fg; border.width: 2
            }

            Text { id: introIconUnlocked; anchors.centerIn: parent; text: "󰌿"; font.family: "Iosevka Nerd Font"; font.pixelSize: 64; color: root.fg; opacity: 1.0; scale: 1.0 }
            Text { id: introIconLocked;   anchors.centerIn: parent; text: "󰌾"; font.family: "Iosevka Nerd Font"; font.pixelSize: 64; color: root.gold; opacity: 0.0; scale: 1.6 }
        }

        SequentialAnimation
        {
            id: introSequence

            ParallelAnimation
            {
                NumberAnimation { target: introLockOrb; property: "scale";   from: 0.0; to: 1.0; duration: 300; easing.type: Easing.OutCubic }
                NumberAnimation { target: introLockOrb; property: "opacity"; from: 0.0; to: 1.0; duration: 200; easing.type: Easing.OutCubic }
                NumberAnimation { target: ring1; property: "scale";   from: 0.8; to: 1.25; duration: 250; easing.type: Easing.OutCubic }
                NumberAnimation { target: ring1; property: "opacity"; from: 0.6; to: 0.0;  duration: 250 }
                NumberAnimation { target: ring2; property: "scale";   from: 0.8; to: 1.40; duration: 300; easing.type: Easing.OutCubic }
                NumberAnimation { target: ring2; property: "opacity"; from: 0.4; to: 0.0;  duration: 300 }
                NumberAnimation { target: ring3; property: "scale";   from: 0.5; to: 1.50; duration: 350; easing.type: Easing.OutCubic }
                NumberAnimation { target: ring3; property: "opacity"; from: 0.3; to: 0.0;  duration: 350 }
                SequentialAnimation
                {
                    PauseAnimation { duration: 500 }
                    ParallelAnimation {
                        NumberAnimation { target: introIconUnlocked; property: "scale";   from: 1.0; to: 0.5; duration: 100; easing.type: Easing.InCubic }
                        NumberAnimation { target: introIconUnlocked; property: "opacity"; from: 1.0; to: 0.0; duration: 50 }
                        NumberAnimation { target: introIconLocked;   property: "scale";   from: 1.6; to: 1.0; duration: 200; easing.type: Easing.OutBack }
                        NumberAnimation { target: introIconLocked;   property: "opacity"; from: 0.0; to: 1.0; duration: 100 }
                        SequentialAnimation {
                            NumberAnimation { target: introLockOrb; property: "anchors.verticalCenterOffset"; from: 0; to:  3; duration: 40 }
                            NumberAnimation { target: introLockOrb; property: "anchors.verticalCenterOffset"; from: 3; to:  0; duration: 120; easing.type: Easing.OutBack }
                        }
                    }
                }
            }

            PauseAnimation { duration: 500 }

            ParallelAnimation
            {
                NumberAnimation { target: introLockOrb; property: "scale";   to: 1.8; duration: 100; easing.type: Easing.InCubic }
                NumberAnimation { target: introOverlay; property: "opacity"; to: 0.0; duration: 100; easing.type: Easing.InCubic }
            }

            NumberAnimation { target: root; property: "introState"; from: 0.0; to: 1.0; duration: 100; easing.type: Easing.OutCubic }
            PropertyAction { target: root; property: "isPlayingIntro"; value: false }
            ScriptAction   { script: inputField.forceActiveFocus() }
        }

        Component.onCompleted: introSequence.start()
    }

    // ════════════════════════════════════════════════════════════════════
    // 背景光球
    // ════════════════════════════════════════════════════════════════════
    Rectangle
    {
        width: parent.width * 0.8; height: width; radius: width / 2
        x: (parent.width  / 2 - width  / 2) + Math.cos(root.globalOrbitAngle * 2) * 200
        y: (parent.height / 2 - height / 2) + Math.sin(root.globalOrbitAngle * 2) * 150
        opacity: root.inputActive ? 0.03 : 0.06
        color: "#CCCCCC"
        Behavior on opacity { NumberAnimation { duration: 800 } }
    }

    Rectangle
    {
        width: parent.width * 0.9; height: width; radius: width / 2
        x: (parent.width  / 2 - width  / 2) + Math.sin(root.globalOrbitAngle * 1.5) * -200
        y: (parent.height / 2 - height / 2) + Math.cos(root.globalOrbitAngle * 1.5) * -150
        opacity: root.inputActive ? 0.02 : 0.04
        color: "#EEEEEE"
        Behavior on opacity { NumberAnimation { duration: 800 } }
    }

    NumberAnimation on globalOrbitAngle
    {
        from: 0; to: Math.PI * 2
        duration: 90000; loops: Animation.Infinite; running: true
    }

    // ── 同心环 ───────────────────────────────────────────────────────────
    Item {
        anchors.fill: parent
        opacity: root.introState
        Repeater
        {
            model: 4
            Rectangle
            {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -40
                width: 400 + index * 220; height: width; radius: width / 2
                color: "transparent"
                border.color: root.context.showFailure ? root.red : root.gold
                border.width: 1
                opacity: root.context.showFailure ? (0.10 - index * 0.02) : (root.inputActive ? (0.015 - index * 0.003) : (0.04 - index * 0.008))
                Behavior on border.color { ColorAnimation { duration: 300 } }
                Behavior on opacity      { NumberAnimation { duration: 300 } }
            }
        }
    }

    // ── 全局点击（intro 结束后，点击进入认证） ────────────────────────────
    MouseArea
    {
        anchors.fill: parent
        enabled: !root.isPlayingIntro

        onClicked:
        {
            if (!root.inputActive) root.inputActive = true;
            inputField.forceActiveFocus();
        }
    }

    // ════════════════════════════════════════════════════════════════════
    // 主内容（随 introState 淡入）
    // ════════════════════════════════════════════════════════════════════
    Item
    {
        anchors.fill: parent
        opacity: root.introState

        Timer
        {
            interval: 1000; running: true; repeat: true; triggeredOnStart: true

            onTriggered:
            {
                const d = new Date()
                clockHours.text   = Qt.formatDateTime(d, "HH")
                clockMinutes.text = Qt.formatDateTime(d, "mm")
                dateText.text     = Qt.formatDateTime(d, "dddd, MMMM dd").toUpperCase()
                miniTimeText.text = Qt.formatDateTime(d, "HH:mm")
            }
        }

        // ── 大时钟（未激活时显示） ────────────────────────────────────
        ColumnLayout {
            id: clockModule
            anchors.centerIn: parent
            anchors.verticalCenterOffset: root.inputActive ? -120 : -40
            spacing: -10
            opacity: root.inputActive ? 0.0 : 1.0
            scale:   root.inputActive ? 0.9 : 1.0
            visible: opacity > 0.01
            Behavior on opacity                      { NumberAnimation { duration: 500; easing.type: Easing.OutCubic } }
            Behavior on scale                        { NumberAnimation { duration: 500; easing.type: Easing.OutCubic } }
            Behavior on anchors.verticalCenterOffset { NumberAnimation { duration: 500; easing.type: Easing.OutCubic } }

            RowLayout
            {
                Layout.alignment: Qt.AlignHCenter
                spacing: 0

                Text
                {
                    id: clockHours
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 140; font.weight: Font.Thin
                    color: root.fg
                }

                Text
                {
                    text: ":"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 140; font.weight: Font.Thin
                    color: root.gold; opacity: 0.7
                }
                Text
                {
                    id: clockMinutes
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 140; font.weight: Font.Thin
                    color: root.fg
                }
            }

            Text
            {
                id: dateText
                Layout.alignment: Qt.AlignHCenter
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 14; font.weight: Font.Light
                font.letterSpacing: 4
                color: root.dim
            }
        }

        // ── "点击解锁"提示（时钟界面底部） ──────────────────────────
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 56
            opacity: root.inputActive ? 0.0 : 0.6
            text: "CLICK TO UNLOCK"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 10; font.letterSpacing: 5
            color: root.gold
        }

        // ════════════════════════════════════════════════════════════════
        // 认证模块
        // ════════════════════════════════════════════════════════════════
        RowLayout
        {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: root.inputActive ? -40 : 40
            spacing: 32
            opacity: root.inputActive ? 1.0 : 0.0
            scale:   root.inputActive ? 1.0 : 0.9
            visible: opacity > 0.01
            Behavior on opacity                      { NumberAnimation { duration: 500; easing.type: Easing.OutCubic } }
            Behavior on scale                        { NumberAnimation { duration: 500; easing.type: Easing.OutCubic } }
            Behavior on anchors.verticalCenterOffset { NumberAnimation { duration: 500; easing.type: Easing.OutCubic } }

            // 头像占位圆
            Item
            {
                Layout.alignment: Qt.AlignVCenter
                width: 170; height: 170
                Rectangle {
                    anchors.fill: parent; radius: 85
                    color: Qt.rgba(root.surface0.r, root.surface0.g, root.surface0.b, 0.6)
                    Text {
                        anchors.centerIn: parent
                        text: "󰄽"
                        font.family: "Iosevka Nerd Font"; font.pixelSize: 64
                        color: root.dim
                    }
                }

                Rectangle
                {
                    anchors.fill: parent; radius: 85; color: "transparent"
                    border.width: 2
                    border.color: root.context.showFailure      ? root.red : root.context.unlockInProgress ? root.goldSoft : Qt.rgba(root.fg.r, root.fg.g, root.fg.b, 0.3)
                    Behavior on border.color { ColorAnimation { duration: 300 } }
                }
            }

            // 用户名 + 状态 + 输入框
            ColumnLayout
            {
                Layout.alignment: Qt.AlignVCenter
                spacing: 16

                Text
                {
                    text: "User"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 28; font.weight: Font.Light
                    font.letterSpacing: 2
                    color: root.fg
                }

                // 状态行
                RowLayout
                {
                    spacing: 12
                    Rectangle
                    {
                        width: 36;
                        height: 36;
                        radius: 18
                        color: root.context.showFailure ? Qt.rgba(root.red.r,      root.red.g,      root.red.b,      0.15) : Qt.rgba(root.gold.r,     root.gold.g,     root.gold.b,     0.10)
                        border.width: 1
                        border.color: root.context.showFailure      ? root.red : root.context.unlockInProgress ? root.goldSoft : root.gold

                        Behavior on border.color { ColorAnimation { duration: 300 } }
                        Text
                        {
                            anchors.centerIn: parent
                            text: root.context.unlockInProgress ? "󰌿" : "󰌾"
                            font.family: "Iosevka Nerd Font"; font.pixelSize: 18
                            color: root.context.showFailure ? root.red : root.context.unlockInProgress ? root.goldSoft : root.gold
                        }
                    }

                    Text
                    {
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 11; font.letterSpacing: 3
                        color: root.context.showFailure      ? root.red : root.context.unlockInProgress ? root.goldSoft : root.gold
                        text: root.context.showFailure       ? "INCORRECT" : root.context.unlockInProgress  ? "AUTHENTICATING" : root.context.currentText.length > 0 ? "ENTER PIN" : "LOCKED"
                        Behavior on color { ColorAnimation { duration: 300 } }
                    }
                }

                Rectangle
                {
                    id: pinPill
                    width: 320; height: 58
                    radius: 2
                    clip: true

                    color: root.context.showFailure ? Qt.rgba(root.red.r, root.red.g, root.red.b, 0.08): Qt.rgba(root.surface0.r, root.surface0.g, root.surface0.b, 0.8)

                    border.width: 1
                    border.color: root.context.showFailure ? root.red : root.context.unlockInProgress ? root.goldSoft : inputField.text.length > 0 ? Qt.rgba(root.fg.r, root.fg.g, root.fg.b, 0.4) : Qt.rgba(root.fg.r, root.fg.g, root.fg.b, 0.08)

                    TextInput
                    {
                        id: inputField
                        anchors.fill: parent; opacity: 0
                        echoMode: TextInput.Password
                        enabled: !root.context.unlockInProgress
                        inputMethodHints: Qt.ImhSensitiveData
                        Component.onCompleted: forceActiveFocus()
                        onActiveFocusChanged: if (!activeFocus && root.inputActive) forceActiveFocus()

                        onAccepted:
                        {
                            if (text.length > 0 && !root.context.unlockInProgress) root.context.tryUnlock()
                        }

                        Keys.onPressed: (event) =>
                        {
                            if (event.key === Qt.Key_Escape)
                            {
                                root.inputActive = false
                                text = ""; passModel.clear(); event.accepted = true
                            }
                        }

                        property string _old: ""

                        onTextChanged:
                        {
                            root.context.currentText = text
                            if (text.length > _old.length)
                                for (let i = _old.length; i < text.length; i++) passModel.append({ isDot: false })
                            else if (text.length < _old.length)
                                for (let i = 0; i < _old.length - text.length; i++) passModel.remove(passModel.count - 1)
                            _old = text
                        }
                    }

                    ListModel { id: passModel }

                    Row
                    {
                        anchors.fill: parent
                        anchors.left: parent
                        anchors.top: parent
                        anchors.right: parent
                        anchors.topMargin: 5
                        anchors.leftMargin: 40
                        anchors.rightMargin: 40
                        anchors.verticalCenter: parent.verticalCenter

                        spacing: 6

                        Repeater
                        {
                            model: inputField.text.length

                            delegate: Text
                            {
                                text: "•"
                                font.pixelSize: 32
                                color: root.dim
                            }
                        }
                    }
                }
            }
        }

        // bottom design for fade color
        Rectangle
        {
            anchors.bottom: parent.bottom
            anchors.left: parent.left; anchors.right: parent.right
            height: 180
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 1.0; color: Qt.rgba(root.bg.r, root.bg.g, root.bg.b, 0.6) }
            }
        }
    }

}
