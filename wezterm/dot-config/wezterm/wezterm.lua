local wezterm = require("wezterm")

-- Function to select color scheme based on system appearance
function scheme_for_appearance(appearance)
    if appearance:find("Dark") then
        return "Catppuccin Mocha" -- Color scheme for dark mode
    else
        return "Catppuccin Latte" -- Color scheme for light mode
    end
end

-- Initialize configuration
local config = wezterm.config_builder()

-- Set color scheme based on current system appearance
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- Disable the tab bar
config.enable_tab_bar = false

-- Set font and size
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 16.0

-- macOS-specific settings
config.macos_window_background_blur = 30 -- Background blur effect
config.native_macos_fullscreen_mode = true -- Use native macOS fullscreen

-- Window appearance settings
config.window_background_opacity = 1.0 -- Fully opaque background
config.window_decorations = "RESIZE" -- Only show resize decorations

-- Key bindings
config.keys = {
    {
        key = "f",
        mods = "CMD",
        action = wezterm.action.ToggleFullScreen, -- Toggle fullscreen with CMD+f
    },
    {
        key = "'",
        mods = "CMD",
        action = wezterm.action.ClearScrollback("ScrollbackAndViewport"), -- Clear scrollback with CMD+'
    },
}

-- Mouse bindings
config.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CMD",
        action = wezterm.action.OpenLinkAtMouseCursor, -- Open link with CMD+Left Click
    },
}

-- Return the configuration to WezTerm
return config
