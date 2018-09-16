-- luacheck: globals get_mod

local mod = get_mod("HideHPProcs")

local mod_data = {
	name = "Hide Bloodlust/Regrowth Proc Effects",
	description = mod:localize("mod_description"),
	is_togglable = true,
	allow_rehooking = true,
}

mod_data.options_widgets = {}

return mod_data
