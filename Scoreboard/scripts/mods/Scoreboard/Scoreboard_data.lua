-- luacheck: globals get_mod

local mod = get_mod("Scoreboard")

local SCOREBOARD_FIXED_ORDER = "scoreboard_fixed_order"
local DAMAGE_TAKEN = "damage_taken"
local DAMAGE_FF = "scoreboard_ff"
local FF_SELF = "ff_self"
local PLAYER_PROCS = "player_procs"

local mod_data = {
	name = "Scoreboard Tweaks",
	description = mod:localize("mod_description"),
	is_togglable = true,
	allow_rehooking = true,
}

mod_data.options_widgets = {
	{
		["setting_name"] = SCOREBOARD_FIXED_ORDER,
		["widget_type"] = "checkbox",
		["text"] = "Consistent Topic Order",
		["tooltip"] = "Make scoreboard topics always be presented in the same order.",
		["default_value"] = true,
	},
	{
		["setting_name"] = DAMAGE_TAKEN,
		["widget_type"] = "checkbox",
		["text"] = "Damage Taken Scoreboard Fix",
		["tooltip"] = "Ignore damage taken while already downed for the purpose of the end match scoreboard.",
		["default_value"] = true,
	},
	{
		["setting_name"] = DAMAGE_FF,
		["widget_type"] = "checkbox",
		["text"] = "Friendly fire on scoreboard",
		["tooltip"] = "Display friendly fire tab on the scoreboard.",
		["default_value"] = true,
	},
	{
		["setting_name"] = FF_SELF,
		["widget_type"] = "checkbox",
		["text"] = "Self-inflicted friendly fire on scoreboard",
		["tooltip"] = "Display self-inficted friendly fire tab on the scoreboard.",
		["default_value"] = true,
	},
	{
		["setting_name"] = PLAYER_PROCS,
		["widget_type"] = "checkbox",
		["text"] = "Heal And Scavenger Procs On Scoreboard",
		["tooltip"] = "Displays the amount of health and ammo gained from procs.\n" ..
			"Columns: From Melee Slot, From Ranged Slot, Total Score.",
		["default_value"] = true,
	},
}

return mod_data
