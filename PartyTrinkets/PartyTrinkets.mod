return {
	run = function()
		fassert(rawget(_G, "new_mod"), "PartyTrinkets must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("PartyTrinkets", {
			mod_script       = "scripts/mods/PartyTrinkets/PartyTrinkets",
			mod_data         = "scripts/mods/PartyTrinkets/PartyTrinkets_data",
			mod_localization = "scripts/mods/PartyTrinkets/PartyTrinkets_localization"
		})
	end,
	packages = {
		"resource_packages/PartyTrinkets/PartyTrinkets"
	}
}
