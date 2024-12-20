local wezterm = require("wezterm")
local config = {}

config.window_close_confirmation = "NeverPrompt" -- not prompt when closing all tabs at once
config.window_decorations = "RESIZE" -- remove title bar and keep resizing capability
config.window_padding = {
  left = "2cell",
  right = "2cell",
  top = "3cell",
  bottom = "3cell",
}
config.font = wezterm.font_with_fallback({ "Iosevka Nerd Font", "JetBrainsMono NF", "MonoLisa" })
config.font_size = 14
config.window_background_opacity = 0.95

function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "ayu"
  else
    return "ayu_light"
  end
end

wezterm.on("window-config-reloaded", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  local scheme = scheme_for_appearance(appearance)
  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end)

-- Key bindings
local act = wezterm.action

config.keys = {
  { key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "q", mods = "ALT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
  { key = "LeftArrow", mods = "ALT", action = wezterm.action({ ActivateTabRelative = -1 }) },
  { key = "RightArrow", mods = "ALT", action = wezterm.action({ ActivateTabRelative = 1 }) },
  { key = "s", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "S", mods = "ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "x", mods = "ALT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
  { key = "LeftArrow", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Next") },
  { key = "RightArrow", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Prev") },
}

return config
