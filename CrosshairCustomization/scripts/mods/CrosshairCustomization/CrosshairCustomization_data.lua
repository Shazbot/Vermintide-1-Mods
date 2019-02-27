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

mod_data.options_widgets = {
   {
		["setting_name"] = SETTING_NAMES.COLOR,
		["widget_type"] = "dropdown",
		["text"] = "Color",
		["tooltip"] = "Color",
			 "Changes the color of your crosshair.",
		["options"] = {
				{text = "Default", value = COLOR_INDEX.DEFAULT},
				{text = "Red", value = COLOR_INDEX.RED},
				{text = "Green", value = COLOR_INDEX.GREEN},
				{text = "Custom", value = COLOR_INDEX.CUSTOM},
		},
		["default_value"] = COLOR_INDEX.DEFAULT,
		["sub_widgets"] = {
			{
				["show_widget_condition"] = { COLOR_INDEX.CUSTOM },
				["setting_name"] = SETTING_NAMES.CUSTOM_RED,
				["widget_type"] = "numeric",
				["text"] = "Red",
				["tooltip"] = "Changes the red color value of your crosshair.",
				["range"] = {0, 255},
				["default_value"] = 255,
			},
			{
				["show_widget_condition"] = { COLOR_INDEX.CUSTOM },
				["setting_name"] = SETTING_NAMES.CUSTOM_GREEN,
				["widget_type"] = "numeric",
				["text"] = "Green",
				["tooltip"] = "Changes the green color value of your crosshair.",
				["range"] = {0, 255},
				["default_value"] = 255,
			},
			{
				["show_widget_condition"] = { COLOR_INDEX.CUSTOM },
				["setting_name"] = SETTING_NAMES.CUSTOM_BLUE,
				["widget_type"] = "numeric",
				["text"] = "Blue",
				["tooltip"] = "Changes the blue color value of your crosshair.",
				["range"] = {0, 255},
				["default_value"] = 255,
			},
		},
	},
	{
		["setting_name"] = SETTING_NAMES.ENLARGE,
		["widget_type"] = "dropdown",
		["text"] = "Enlarge",
		["tooltip"] = "Increases the size of your crosshair.",
		["options"] = {
				{text = "Off", value = ENLARGE.OFF},
				{text = "Slightly", value = ENLARGE.SLIGHTLY},
				{text = "Heavily", value = ENLARGE.HEAVILY},
		},
		["default_value"] = ENLARGE.OFF,
	},
	{
		["setting_name"] = SETTING_NAMES.HEADSHOT_MARKER,
		["widget_type"] = "checkbox",
		["text"] = "Headshot indicator",
		["tooltip"] = "Adds a marker to the crosshair on headshots.",
		["default_value"] = false,
		["sub_widgets"] = {
			{
				["setting_name"] = SETTING_NAMES.HEADSHOT_MARKER_COLOR,
				["widget_type"] = "dropdown",
				["text"] = "Color",
				["tooltip"] =  "Changes the color of the headshot markers.",
				["options"] = {
					{text = "Default", value = COLOR_INDEX.DEFAULT},
					{text = "Red", value = COLOR_INDEX.RED},
					{text = "Green", value = COLOR_INDEX.GREEN},
					{text = "Custom", value = COLOR_INDEX.CUSTOM},
				},
				["default"] = COLOR_INDEX.DEFAULT,
				["sub_widgets"] = {
					{
						["show_widget_condition"] = { COLOR_INDEX.CUSTOM },
						["setting_name"] = SETTING_NAMES.HS_CUSTOM_RED,
						["widget_type"] = "numeric",
						["text"] = "Red",
						["tooltip"] = "Changes the red color value of your crosshair.",
						["range"] = {0, 255},
						["default_value"] = 255,
					},
					{
						["show_widget_condition"] = { COLOR_INDEX.CUSTOM },
						["setting_name"] = SETTING_NAMES.HS_CUSTOM_GREEN,
						["widget_type"] = "numeric",
						["text"] = "Green",
						["tooltip"] = "Changes the green color value of your crosshair.",
						["range"] = {0, 255},
						["default_value"] = 255,
					},
					{
						["show_widget_condition"] = { COLOR_INDEX.CUSTOM },
						["setting_name"] = SETTING_NAMES.HS_CUSTOM_BLUE,
						["widget_type"] = "numeric",
						["text"] = "Blue",
						["tooltip"] = "Changes the blue color value of your crosshair.",
						["range"] = {0, 255},
						["default_value"] = 255,
					},
				},
			},
		},
	},
	{
		["setting_name"] = SETTING_NAMES.DOT,
		["widget_type"] = "checkbox",
		text = "Dot Only",
		tooltip = "Forces the crosshair to remain as only a dot, even with ranged weapons.",
		["default_value"] = false,
	},
	{
		["setting_name"] = SETTING_NAMES.DOT_TOGGLE_HOTKEY,
		["widget_type"] = "keybind",
		["text"] = "Dot Only Toggle Hotkey",
		["tooltip"] = "Use a hotkey to toggle dot only mode on/off.",
		["default_value"] = {},
		["action"] = "dot_toggle"
	},
	{
		["setting_name"] = SETTING_NAMES.NO_MELEE_DOT,
		["widget_type"] = "checkbox",
		["text"] = "No Melee Crosshair",
		["tooltip"] = "Disables the dot crosshair when you have your melee equipped.",
		["default_value"] = false
	},
}

return mod_data
