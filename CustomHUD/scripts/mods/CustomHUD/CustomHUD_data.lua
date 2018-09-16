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

mod_data.options_widgets = {
    {
		["setting_name"] = SETTING_NAMES.CUSTOM_HUD,
		["widget_type"] = "dropdown",
		["text"] = "HUD Preset",
		["tooltip"] = "Choose between different HUDs:\n" ..
			"Default HUD:\n" ..
			"Vanilla game HUD.\n" ..
			"\n" ..
			"Console HUD:\n" ..
			"A different HUD is used when you play the game with a gamepad, one which has a larger health " ..
			"bar but is more compact overall. Enabling this option will cause the gamepad HUD to be used " ..
			"even when you are not using a gamepad.\n" ..
			"\n" ..
			"Custom HUD:\n" ..
			"Minimalistic, screen real estate saving HUD.",
		["options"] = {
			{text = "Default HUD", value = mod.OFF},
			{text = "Console HUD", value = mod.GAMEPAD},
			{text = "Custom HUD", value = mod.CUSTOM},
		},
		["default_value"] = mod.CUSTOM,
		["sub_widgets"] = {
			{
			    ["show_widget_condition"] = { mod.CUSTOM },
			    ["setting_name"] = SETTING_NAMES.COLORIZE_AMMO,
			    ["widget_type"] = "checkbox",
			    ["text"] = "Change Ammo Counter Color",
			    ["tooltip"] = "Changes text color of the ammo counter to red at 0 ammo.",
			    ["default_value"] = false,
			},
			{
			    ["show_widget_condition"] = { mod.CUSTOM },
			    ["setting_name"] = SETTING_NAMES.COLORIZE_SLOTS,
			    ["widget_type"] = "checkbox",
			    ["text"] = "Highlight Party Slots",
			    ["tooltip"] = "Highlight item slots of players with effect sharing trinkets when you have a shareable item.",
			    ["default_value"] = false,
			},
			{
			    ["show_widget_condition"] = { mod.CUSTOM },
			    ["setting_name"] = SETTING_NAMES.GRAYSCALE,
			    ["widget_type"] = "checkbox",
			    ["text"] = "Use Grayscale Icons",
			    ["tooltip"] = "Will use the grayscale version icons for consumables.",
			    ["default_value"] = false,
			},
		},
	},
}

return mod_data
