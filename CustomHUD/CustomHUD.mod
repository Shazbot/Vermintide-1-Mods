return {
	run = function()
		fassert(rawget(_G, "new_mod"), "CustomHUD must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("CustomHUD", {
			mod_script       = "scripts/mods/CustomHUD/CustomHUD",
			mod_data         = "scripts/mods/CustomHUD/CustomHUD_data",
			mod_localization = "scripts/mods/CustomHUD/CustomHUD_localization"
		})
	end,
	packages = {
		"resource_packages/CustomHUD/CustomHUD"
	}
}
