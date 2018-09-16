return {
	run = function()
		fassert(rawget(_G, "new_mod"), "InventoryFiltering must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("InventoryFiltering", {
			mod_script       = "scripts/mods/InventoryFiltering/InventoryFiltering",
			mod_data         = "scripts/mods/InventoryFiltering/InventoryFiltering_data",
			mod_localization = "scripts/mods/InventoryFiltering/InventoryFiltering_localization"
		})
	end,
	packages = {
		"resource_packages/InventoryFiltering/InventoryFiltering"
	}
}
