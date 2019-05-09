-- luacheck: globals get_mod

local mod = get_mod("PartyTrinkets")

local HOMOGENIZE_PARTY_TRINKET_ICONS = "homogenize_party_trinket_icons"

local mod_data = {
	name = "Important Trinkets Icons",
	description = mod:localize("mod_description"),
	is_togglable = true,
	allow_rehooking = true,
}

mod_data.options = {
	widgets = {
		{
			setting_id    = HOMOGENIZE_PARTY_TRINKET_ICONS,
			type          = "checkbox",
			default_value = true,
		}
	}
}

return mod_data
