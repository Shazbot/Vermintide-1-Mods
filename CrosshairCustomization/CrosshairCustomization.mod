return {
	run = function()
		fassert(rawget(_G, "new_mod"), "CrosshairCustomization must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("CrosshairCustomization", {
			mod_script       = "scripts/mods/CrosshairCustomization/CrosshairCustomization",
			mod_data         = "scripts/mods/CrosshairCustomization/CrosshairCustomization_data",
			mod_localization = "scripts/mods/CrosshairCustomization/CrosshairCustomization_localization"
		})
	end,
	packages = {
		"resource_packages/CrosshairCustomization/CrosshairCustomization"
	}
}
