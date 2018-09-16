-- luacheck: globals get_mod

local mod = get_mod("UITimers")

-- setting names
local SETTING_TIMERS_POSITION = "timers_position"

-- timers
local TIMERS_POSITON_TOP = 1
local TIMERS_POSITON_BOTTOM = 2

local mod_data = {
	name = "Proc/Potion Timers",
	description = mod:localize("mod_description"),
	is_togglable = true,
	allow_rehooking = true,
}

mod_data.options_widgets = {
	{
		["setting_name"] = SETTING_TIMERS_POSITION,
		["widget_type"] = "dropdown",
		["text"] = mod:localize("timers_position_text"),
		["tooltip"] = mod:localize("timers_position_tooltip"),
		["options"] = {
			{text = mod:localize("timers_position_top"), value = TIMERS_POSITON_TOP},
			{text = mod:localize("timers_position_bottom"), value = TIMERS_POSITON_BOTTOM},
	    },
		["default_value"] = TIMERS_POSITON_TOP,
	},
}

return mod_data
