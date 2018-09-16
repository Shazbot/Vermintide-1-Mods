-- luacheck: globals get_mod GenericStatusExtension

local mod = get_mod("HideHPProcs")

mod:hook(GenericStatusExtension, "healed", function (func, self, reason)
	if not mod:is_enabled() then
		return func(self, reason)
	end

	if reason == "proc" and self.player.local_player then return end

	func(self, reason)
end)

mod.on_disabled = function(is_first_call) -- luacheck: ignore is_first_call
	mod:disable_all_hooks()
end

mod.on_enabled = function(is_first_call) -- luacheck: ignore is_first_call
	mod:enable_all_hooks()
end
