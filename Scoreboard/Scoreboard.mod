return {
	run = function()
		fassert(rawget(_G, "new_mod"), "Scoreboard must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("Scoreboard", {
			mod_script       = "scripts/mods/Scoreboard/Scoreboard",
			mod_data         = "scripts/mods/Scoreboard/Scoreboard_data",
			mod_localization = "scripts/mods/Scoreboard/Scoreboard_localization"
		})
	end,
	packages = {
		"resource_packages/Scoreboard/Scoreboard"
	}
}
