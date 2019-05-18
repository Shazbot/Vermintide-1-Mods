-- luacheck: globals get_mod GenericStatusExtension

local mod = get_mod("HideHPProcs")

mod:hook(GenericStatusExtension, "healed", function (func, self, reason)
	if reason == "proc" and self.player.local_player then return end

	func(self, reason)
end)
