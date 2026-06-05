---------------------
---- KEYBINDINGS ----
---------------------

hl.bind("ALT + P", hl.dsp.exec_cmd("systemctl poweroff"), { locked = true, repeating = false })
hl.bind("ALT + R", hl.dsp.exec_cmd("systemctl reboot"), { locked = true, repeating = false })
hl.bind("ALT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

local mainMod = "SUPER"
local in_special = false

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("hyprctl reload && notify-send 'Hyprland' 'Config reloaded'"), { locked = true, repeating = false })
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("foot"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("pkill localsend || localsend"), { repeating = false })

hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -theme ~/.config/rofi/launchers/config.rasi"))
hl.bind(mainMod .. " + tab", hl.dsp.window.cycle_next(), { repeating = true })
hl.bind(mainMod .. " + Backslash", hl.dsp.window.swap({ next = "" }))
hl.bind(mainMod .. " + equal", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + minus", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("bash ~/.config/script/screen-partial.sh"), { locked = true, repeating = false })
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("bash ~/.config/script/screen-ocr.sh"), { locked = true, repeating = false })
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("bash ~/.config/script/screen-recorder.sh"), { locked = true, repeating = false })
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a -n -s 2"), { locked = true, repeating = false })
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + Down", hl.dsp.focus({ workspace = "up" }))
hl.bind(mainMod .. " + Up", hl.dsp.focus({ workspace = "down" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))

hl.bind(mainMod .. " + O", function()
    in_special = not in_special
    hl.dispatch(hl.dsp.exec_cmd("bash ~/.config/script/toggle-waybar.sh"))
    hl.dispatch(hl.dsp.workspace.toggle_special("scratchpad"))
end)

hl.bind(mainMod .. " + U", function()
    if in_special then return end
    hl.dispatch(hl.dsp.focus({ workspace = "-1" }))
end)

hl.bind(mainMod .. " + I", function()
    if in_special then return end
    hl.dispatch(hl.dsp.focus({ workspace = "e+1" }))
end)

hl.bind(mainMod .. " + M", function()
    if in_special then
        hl.dispatch(hl.dsp.window.move({ workspace = 1, follow = false }))
    else
        hl.dispatch(hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))
    end
end)

for i = 1, 5 do
    local key = i
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("bash ~/.config/script/toggle-volume.sh up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("bash ~/.config/script/toggle-volume.sh down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("bash ~/.config/script/toggle-volume.sh mute"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("bash ~/.config/script/toggle-volume.sh mic"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("bash ~/.config/script/toggle-brightness.sh up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("bash ~/.config/script/toggle-brightness.sh down"), { locked = true, repeating = true })
hl.bind("XF86TouchpadToggle", hl.dsp.exec_cmd("bash ~/.config/script/toggle-touchpad.sh"), { locked = true, repeating = false })
hl.bind("XF86WLAN", hl.dsp.exec_cmd("bash ~/.config/script/notify-airplane.sh"), { locked = true, repeating = false })
hl.bind("XF86TouchpadOn", hl.dsp.exec_cmd("mpc toggle"), {locked = true, repeating = false})
hl.bind("F23", hl.dsp.exec_cmd("mpc stop"), {locked = true, repeating = false})
hl.bind("XF86Favorites", hl.dsp.exec_cmd("mpc next"), {locked = true, repeating = false})

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("Print", hl.dsp.exec_cmd("bash ~/.config/script/screen-full.sh"), { locked = true, repeating = false })
hl.bind("ALT + Print", hl.dsp.exec_cmd("bash ~/.config/script/screen-partial.sh"), { locked = true, repeating = false })
hl.bind("CTRL + Print", hl.dsp.exec_cmd("bash ~/.config/script/screen-recorder.sh"), { locked = true, repeating = false })
