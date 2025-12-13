local wezterm = require 'wezterm'

return {
  -- font = wezterm.font("UDEV Gothic 35NFLG", {weight="Regular", stretch="Normal", style="Normal"}), -- /home/cddadr/.local/share/fonts/UDEVGothic35NFLG-Regular.ttf, FontConfig
  font = wezterm.font("IntoneMonoNerdFont", {weight="Regular", stretch="Normal", style="Normal"}),
  warn_about_missing_glyphs = false,
  -- color_scheme = 'Dracula',
  -- color_scheme = 'nordfox',
  -- color_scheme = 'node-light',
  -- color_scheme = 'Nord Light (Gogh)'
  -- color_scheme = 'Ocean (light) (terminal.sexy)',
  -- color_scheme = 'OceanicNext (base16)',
  -- color_scheme = 'OneHalfLight',
  -- color_scheme = 'One Light (Gogh)',
  -- color_scheme = 'Mariana',

  -- light, good mocha
  -- color_scheme = 'Mocha (light) (terminal.sexy)',
  
  -- dark, good monochrome
  color_scheme = 'Mono Theme (terminal.sexy)',

  -- light, good color
  -- color_scheme = 'Monokai (light) (terminal.sexy)',

  hide_tab_bar_if_only_one_tab = true, 
}

