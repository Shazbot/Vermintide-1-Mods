-- luacheck: globals get_mod

local mod = get_mod("WeaponSwitching")

local mod_data = {
	name = "Weapon Switching Fix",
	description = mod:localize("mod_description"),
	is_togglable = true,
	allow_rehooking = true,
}

return mod_data
