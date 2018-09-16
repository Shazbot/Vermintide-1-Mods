return {
	run = function()
		fassert(rawget(_G, "new_mod"), "WeaponSwitching must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("WeaponSwitching", {
			mod_script       = "scripts/mods/WeaponSwitching/WeaponSwitching",
			mod_data         = "scripts/mods/WeaponSwitching/WeaponSwitching_data",
			mod_localization = "scripts/mods/WeaponSwitching/WeaponSwitching_localization"
		})
	end,
	packages = {
		"resource_packages/WeaponSwitching/WeaponSwitching"
	}
}
