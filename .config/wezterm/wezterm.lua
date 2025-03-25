local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Set the font
config.font_size = 16.5
config.line_height = 1.1
config.font = wezterm.font("Geist Mono", { weight = "Medium", stretch = "Normal" })

-- Set the colorscheme
config.colors = {
  background = "#070707",
  cursor_bg = "#f8f8f2",
  cursor_border = "#f8f8f2",
}

-- Appearance
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
-- config.window_background_image = os.getenv("HOME") .. "/.config/wezterm/assets/bg-blurred.jpg"
-- config.window_background_opacity = 1
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Recommended setting
config.max_fps = 120
config.prefer_egl = true
-- this will causes different ratio on font size on different monitor
-- config.dpi = 82

return config
