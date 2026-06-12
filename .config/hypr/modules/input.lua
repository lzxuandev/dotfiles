---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
	    accel_profile = "flat",
        sensitivity = 0.3, -- -1.0 - 1.0, 0 means no modification.

        scroll_method = "on_button_down",
        scroll_button = 274,

        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.3,
            disable_while_typing = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
