local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- appearance
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 20
config.font = wezterm.font("Iosevka Nerd Font Propo")
config.font_size = 14
config.scrollback_lines = 3000
config.use_fancy_tab_bar = false
config.tab_max_width = 32

-- dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}

-- behavior
config.window_close_confirmation = "AlwaysPrompt"
config.status_update_interval = 1000
config.window_decorations = "RESIZE"
config.hide_mouse_cursor_when_typing = true

-- maximize screen on start
local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local _, _, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

wezterm.on("update-status", function(window, pane)
	local stat = window:active_workspace()

	if window:active_key_table() then
		stat = window:active_key_table()
	end

	if window:leader_is_active() then
		stat = "LDR"
	end

	local basename = function(s)
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	local cwd = basename(pane:get_current_working_dir())
	local cmd = basename(pane:get_foreground_process_name())
	local time = wezterm.strftime("%H:%M")
	window:set_right_status(wezterm.format({
		{ Foreground = { Color = "F38BA8" } },
		{ Text = wezterm.nerdfonts.md_cog .. " " .. stat },
		"ResetAttributes",
		{ Text = " | " },
		{ Foreground = { Color = "74C7EC" } },
		{ Text = wezterm.nerdfonts.md_folder .. " " .. cwd },
		"ResetAttributes",
		{ Text = " | " },
		{ Foreground = { Color = "F9E2AF" } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
		{ Foreground = { Color = "A6E3A1" } },
		{ Text = wezterm.nerdfonts.md_clock .. " " .. time },
		"ResetAttributes",
	}))
end)

-- key bindings
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "T", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "t", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
	{ key = "w", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },
	{ key = "y", mods = "LEADER", action = act.ShowTabNavigator },
	{ key = "m", mods = "LEADER", action = act.TogglePaneZoomState },
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 2 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 2 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 2 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 2 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
	move_tab = {
		{ key = "h", action = act.MoveTabRelative(-1) },
		{ key = "j", action = act.MoveTabRelative(-1) },
		{ key = "k", action = act.MoveTabRelative(1) },
		{ key = "l", action = act.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

return config
