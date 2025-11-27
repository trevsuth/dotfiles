local wezterm = require("wezterm")

return {
    default_prog = { "/usr/bin/fish", "-l" },

    launch_menu = {
        {
            label = "fish (login)",
            args = { "/usr/bin/fish", "-l" },
        },
    },
}
