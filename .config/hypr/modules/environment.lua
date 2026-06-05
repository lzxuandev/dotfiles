-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- XDG CONFIGURATION
hl.env("XDG_CONFIG_HOME", "/home/lzx/.config")
hl.env("XDG_CACHE_HOME", "/home/lzx/.cache")
hl.env("XDG_DATA_HOME", "/home/lzx/.local/share")
hl.env("XDG_DATA_DIRS", "/usr/share")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- CURSOR
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")

-- TOOLKIT BACKENDS
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;x11")
hl.env("SDL_VIDEODRIVER", "wayland,x11")
hl.env("CLUTTER_BACKEND", "wayland,x11")

-- ELECTRON
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-- QT SPECIFIC
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

-- INPUT METHOD (FCITX5)
hl.env("QT_IM_MODULE", "fcitx")
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "fcitx")

-- GRAPHICS
hl.env("AQ_DRM_DEVICES", "/dev/dri/card1")
hl.env("RENDER_DRM_DEVICES", "/dev/dri/renderD128")
