local mod = get_mod("Pause") -- luacheck: ignore get_mod

mod.SETTING_NAMES = {
	HOTKEY = "hotkey",
}

local mod_data = {
	name = "Pause",
	description = mod:localize("mod_description"),
}
mod_data.options = {
	widgets = {
		{
			setting_id      = mod.SETTING_NAMES.HOTKEY,
			type            = "keybind",
			default_value   = {},
			keybind_trigger = "pressed",
			keybind_type    = "function_call",
			function_name   = "do_pause"
		},
	}
}

return mod_data