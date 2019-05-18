-- luacheck: globals get_mod

local mod = get_mod("CustomHUD")

mod.OFF = 1
mod.GAMEPAD = 2
mod.CUSTOM = 3

local SETTING_NAMES = {
	CUSTOM_HUD = "custom_hud",
	COLORIZE_AMMO = "colorize_ammo",
	COLORIZE_SLOTS = "colorize_party_item_slots",
	GRAYSCALE = "grayscale_icons",
}

local mod_data = {
	name = "Custom HUD",
	description = mod:localize("mod_description"),
	is_togglable = false,
	allow_rehooking = true,
}

mod_data.options = {
	widgets = {
		{
			setting_id    = SETTING_NAMES.CUSTOM_HUD,
			type          = "dropdown",
			default_value = mod.CUSTOM,
			options = {
				{text = "default_hud_option", value = mod.OFF},
				{text = "console_hud_option", value = mod.GAMEPAD},
				{text = "custom_hud_option",  value = mod.CUSTOM, show_widgets = {1, 2, 3}},
			},
			sub_widgets = {
				{
					setting_id    = SETTING_NAMES.COLORIZE_AMMO,
					type          = "checkbox",
					default_value = false,
				},
				{
					setting_id    = SETTING_NAMES.COLORIZE_SLOTS,
					type          = "checkbox",
					default_value = false,
				},
				{
					setting_id    = SETTING_NAMES.GRAYSCALE,
					type          = "checkbox",
					default_value = false,
				},
			},
		},
	}
}


return mod_data
