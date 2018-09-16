-- luacheck: globals get_mod

local mod = get_mod("InventoryFiltering")

local mod_data = {
	name = "Inventory Favorites And Filtering",
	description = mod:localize("mod_description"),
	is_togglable = false,
	allow_rehooking = true,
}

mod_data.options_widgets = {}

return mod_data
