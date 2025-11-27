local wezterm = require("wezterm")

local palette = {
    bg = "#0a1620",
    panel = "#0d1f2d",
    grid = "#133040",
    text = "#e4f1f9",
    muted = "#6c7b86",
    cyan = "#4ff3ff",
    teal = "#2eb5d8",
    amber = "#ffb25a",
    danger = "#f35e5e",
    violet = "#9ad1ff",
}

local expanse_hud = {
    foreground = palette.text,
    background = palette.bg,
    cursor_bg = palette.cyan,
    cursor_border = palette.cyan,
    cursor_fg = palette.bg,
    selection_bg = palette.grid,
    selection_fg = palette.text,
    scrollbar_thumb = palette.grid,
    split = palette.cyan,
    compose_cursor = palette.amber,
    ansi = {
        palette.bg,
        palette.danger,
        palette.teal,
        palette.amber,
        palette.cyan,
        palette.violet,
        palette.muted,
        palette.text,
    },
    brights = {
        palette.grid,
        "#ff7d7d",
        "#5ad6ed",
        "#ffd082",
        "#7af9ff",
        "#c4e0ff",
        "#9aacb8",
        "#ffffff",
    },
    tab_bar = {
        background = palette.panel,
        active_tab = {
            bg_color = palette.grid,
            fg_color = palette.text,
            intensity = "Bold",
        },
        inactive_tab = {
            bg_color = palette.panel,
            fg_color = palette.muted,
        },
        inactive_tab_hover = {
            bg_color = palette.grid,
            fg_color = palette.cyan,
            italic = true,
        },
        new_tab = {
            bg_color = palette.panel,
            fg_color = palette.muted,
        },
        new_tab_hover = {
            bg_color = palette.grid,
            fg_color = palette.cyan,
        },
    },
}

local preferred_fonts = {
    -- Plain families to avoid load errors when Nerd Fonts aren't installed.
    "Fira Code",
    "JetBrains Mono",
    "Hack",
    "IBM Plex Mono",
    "DejaVu Sans Mono",
    "Monaco",
}

local function file_exists(path)
    local f = io.open(path, "r")
    if f then
        f:close()
        return true
    end
    return false
end

local preferred_shells = {
    -- macOS Homebrew first, then common Linux paths, then POSIX fallbacks.
    "/opt/homebrew/bin/fish",
    "/usr/local/bin/fish",
    "/usr/bin/fish",
    "/bin/fish",
    "/bin/zsh",
    "/bin/bash",
}

local function resolve_default_shell()
    for _, path in ipairs(preferred_shells) do
        if file_exists(path) then
            return { path, "-l" }
        end
    end
    -- Let WezTerm fall back to $SHELL if none of the above exist.
    return nil
end

local function available_fonts(fonts)
    -- Filter using font discovery when available to avoid load warnings.
    if wezterm.gui and wezterm.gui.enumerate_fonts then
        local installed = {}
        for _, font in ipairs(wezterm.gui.enumerate_fonts()) do
            installed[font.family] = true
        end

        local filtered = {}
        for _, family in ipairs(fonts) do
            if installed[family] then
                table.insert(filtered, family)
            end
        end

        if #filtered > 0 then
            return filtered
        end
    end

    -- Fall back to the original list if enumeration isn't available.
    return fonts
end

return {
    default_prog = resolve_default_shell(),
    font = wezterm.font_with_fallback(available_fonts(preferred_fonts)),
    font_size = 11.0,
    window_background_opacity = 0.9,
    window_decorations = "RESIZE",
    color_schemes = {
        ["Expanse HUD"] = expanse_hud,
    },
    color_scheme = "Expanse HUD",
    launch_menu = {
        (function()
            local shell = resolve_default_shell()
            if not shell then
                return nil
            end

            -- Label shows the basename to keep the menu clean.
            local label = string.format("%s (login)", shell[1]:match("([^/]+)$"))

            return {
                label = label,
                args = shell,
            }
        end)(),
    },
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    keys = {
        -- Align split highlights with theme accent.
        { key = "\\", mods = "ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
        { key = "-", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    },
}
