-- This table will hold the configuration.
local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- change config now
-- config.default_domain = "WSL:Arch"
config.ssh_domains = {
  {
    -- This name identifies the domain
    name = 'wsl.server',
    -- The hostname or address to connect to. Will be used to match settings
    -- from your ssh config file
    remote_address = '172.28.228.168',
    -- The username to use on the remote host
    username = 'madara',
  },
}

config.front_end = "OpenGL"
config.font = wezterm.font("Agave Nerd Font")

config.enable_kitty_graphics = true

config.window_background_opacity = 0.8
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.enable_tab_bar = false
config.enable_wayland = true
-- config.enable_kitty_graphics = true

config.default_cursor_style = "SteadyBar"

return config
