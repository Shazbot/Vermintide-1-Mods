-- luacheck: globals get_mod

local mod = get_mod("CrosshairCustomization")

local COLOR_INDEX = {
	DEFAULT = 1,
	RED = 2,
	GREEN = 3,
	CUSTOM = 4
}

local ENLARGE = {
	OFF = 1,
	SLIGHTLY = 2,
	HEAVILY = 3
}

local SETTING_NAMES = {
	COLOR = "color",
	ENLARGE = "enlarge",
	HEADSHOT_MARKER = "headshot_marker",
	HEADSHOT_MARKER_COLOR = "headshot_marker_color",
	DOT = "dot",
	DOT_TOGGLE_HOTKEY = "dot_toggle_hotkey",
	NO_MELEE_DOT = "no_melee_dot",
	CUSTOM_RED = "custom_red",
	CUSTOM_GREEN = "custom_green",
	CUSTOM_BLUE = "custom_blue",
	HS_CUSTOM_RED = "hs_custom_red",
	HS_CUSTOM_GREEN = "hs_custom_green",
	HS_CUSTOM_BLUE = "hs_custom_blue",
}

local COLORS = {
	DEFAULT = {255, 255, 255, 255},
	RED = {255, 255, 0, 0},
	GREEN = {255, 0, 255, 0},
}
COLORS[COLOR_INDEX.DEFAULT] = COLORS.DEFAULT
COLORS[COLOR_INDEX.RED] = COLORS.RED
COLORS[COLOR_INDEX.GREEN] = COLORS.GREEN

local mod_data = {
	name = "Crosshair Tweaks",
	description = mod:localize("mod_description"),
	is_togglable = true,
	allow_rehooking = true,
}

mod_data.options = {
	widgets = {
		{
			setting_id    = SETTING_NAMES.COLOR,
			type          = "dropdown",
			default_value = COLOR_INDEX.DEFAULT,
			options = {
				{text = "default", value = COLOR_INDEX.DEFAULT},
				{text = "red",     value = COLOR_INDEX.RED},
				{text = "green",   value = COLOR_INDEX.GREEN},
				{text = "custom",  value = COLOR_INDEX.CUSTOM, show_widgets = {1, 2, 3}},
			},
			sub_widgets = {
				{
					setting_id    = SETTING_NAMES.CUSTOM_RED,
					type          = "numeric",
					title         = "red",
					tooltip       = "red_description",
					default_value = 255,
					range         = {0, 255},
				},
				{
					setting_id    = SETTING_NAMES.CUSTOM_GREEN,
					type          = "numeric",
					title         = "green",
					tooltip       = "green_description",
					default_value = 255,
					range         = {0, 255},
				},
				{
					setting_id    = SETTING_NAMES.CUSTOM_BLUE,
					type          = "numeric",
					title         = "blue",
					tooltip       = "blue_description",
					default_value = 255,
					range         = {0, 255},
				},
			},
		},
		{
			setting_id    = SETTING_NAMES.ENLARGE,
			type          = "dropdown",
			default_value = ENLARGE.OFF,
			options = {
				{text = "off",      value = ENLARGE.OFF},
				{text = "slightly", value = ENLARGE.SLIGHTLY},
				{text = "heavily",  value = ENLARGE.HEAVILY},
			},
		},
		{
			setting_id    = SETTING_NAMES.HEADSHOT_MARKER,
			type          = "checkbox",
			default_value = false,
			sub_widgets = {
				{
					setting_id    = SETTING_NAMES.HEADSHOT_MARKER_COLOR,
					type          = "dropdown",
					title         = "color",
					default_value = COLOR_INDEX.DEFAULT,
					options = {
						{text = "default", value = COLOR_INDEX.DEFAULT},
						{text = "red",     value = COLOR_INDEX.RED},
						{text = "green",   value = COLOR_INDEX.GREEN},
						{text = "custom",  value = COLOR_INDEX.CUSTOM, show_widgets = {1, 2, 3}},
					},
					sub_widgets = {
						{
							setting_id    = SETTING_NAMES.HS_CUSTOM_RED,
							type          = "numeric",
							title         = "red",
							tooltip       = "red_description",
							default_value = 255,
							range         = {0, 255},
						},
						{
							setting_id    = SETTING_NAMES.HS_CUSTOM_GREEN,
							type          = "numeric",
							title         = "green",
							tooltip       = "green_description",
							default_value = 255,
							range         = {0, 255},
						},
						{
							setting_id    = SETTING_NAMES.HS_CUSTOM_BLUE,
							type          = "numeric",
							title         = "blue",
							tooltip       = "blue_description",
							default_value = 255,
							range         = {0, 255},
						},
					},
				},
			},
		},
		{
			setting_id    = SETTING_NAMES.DOT,
			type          = "checkbox",
			default_value = false,
		},
		{
			setting_id      = SETTING_NAMES.DOT_TOGGLE_HOTKEY,
			type            = "keybind",
			default_value   = {},
			keybind_trigger = "pressed",
			keybind_type    = "function_call",
			function_name   = "dot_toggle"
		},
		{
			setting_id    = SETTING_NAMES.NO_MELEE_DOT,
			type          = "checkbox",
			default_value = false
		},
	}
}

return mod_data
