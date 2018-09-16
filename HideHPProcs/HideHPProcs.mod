return {
	run = function()
		fassert(rawget(_G, "new_mod"), "HideHPProcs must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("HideHPProcs", {
			mod_script       = "scripts/mods/HideHPProcs/HideHPProcs",
			mod_data         = "scripts/mods/HideHPProcs/HideHPProcs_data",
			mod_localization = "scripts/mods/HideHPProcs/HideHPProcs_localization"
		})
	end,
	packages = {
		"resource_packages/HideHPProcs/HideHPProcs"
	}
}
