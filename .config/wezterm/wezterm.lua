-- This table will hold the configuration.
local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.front_end = "OpenGL"
-- config.font = wezterm.font("Agave Nerd Font")

config.enable_kitty_graphics = true

config.window_background_opacity = 0.8
-- config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.enable_tab_bar = false
config.enable_wayland = true
config.enable_kitty_graphics = true

config.default_cursor_style = "SteadyBar"

return config
