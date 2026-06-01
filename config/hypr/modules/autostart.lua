-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("hypridle")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("fcitx5")
    hl.exec_cmd("mpd")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("systemctl --user start hyprpolkiagent")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
    hl.exec_cmd("hyprctl eval \"hl.device({ name = 'elan0672:00-04f3:3187-touchpad', enabled = false })\"")
end)
