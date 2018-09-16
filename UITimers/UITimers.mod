return {
	run = function()
		fassert(rawget(_G, "new_mod"), "UITimers must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("UITimers", {
			mod_script       = "scripts/mods/UITimers/UITimers",
			mod_data         = "scripts/mods/UITimers/UITimers_data",
			mod_localization = "scripts/mods/UITimers/UITimers_localization"
		})
	end,
	packages = {
		"resource_packages/UITimers/UITimers"
	}
}
