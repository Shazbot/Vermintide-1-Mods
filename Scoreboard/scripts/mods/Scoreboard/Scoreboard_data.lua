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

mod_data.options = {
	widgets = {
		{
			setting_id    = SCOREBOARD_FIXED_ORDER,
			type          = "checkbox",
			default_value = true,
		},
		{
			setting_id    = DAMAGE_TAKEN,
			type          = "checkbox",
			default_value = true,
		},
		{
			setting_id    = DAMAGE_FF,
			type          = "checkbox",
			default_value = true,
		},
		{
			setting_id    = FF_SELF,
			type          = "checkbox",
			default_value = true,
		},
		{
			setting_id    = PLAYER_PROCS,
			type          = "checkbox",
			default_value = true,
		},
	}
}

return mod_data
