local mod = get_mod("Pause") -- luacheck: ignore get_mod

-- luacheck: globals Managers

mod.do_pause = function()
	if not Managers.player.is_server then
		mod:echo_localized("not_server")
		return
	end

	if Managers.state.debug.time_paused then
		Managers.state.debug:set_time_scale(Managers.state.debug.time_scale_index)
		mod:echo_localized("game_unpaused")
	else
		Managers.state.debug:set_time_paused()
		mod:echo_localized("game_paused")
	end
end

mod:command("pause", mod:localize("pause_command_description"), mod.do_pause)