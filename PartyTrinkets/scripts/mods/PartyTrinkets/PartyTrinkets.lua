-- luacheck: globals get_mod

local mod = get_mod("PartyTrinkets")

local HOMOGENIZE_PARTY_TRINKET_ICONS = "homogenize_party_trinket_icons"

local trinkets_widget =
{
	scenegraph_id = "pivot",
	offset = { 55, -82, -2 },
	element = {
		passes = (function()
						local passes = {}
						for i=1,10 do
							table.insert(passes, {
									pass_type = "texture_uv",
									style_id = "trinket_"..i,
									content_id = "trinket_"..i,
									content_check_function = function(ui_content)
										return ui_content and ui_content.show or false
									end,
								})
						end
						for _,trinket_pos in ipairs({100,101}) do
							table.insert(passes, {
								pass_type = "texture_uv",
								style_id = "trinket_"..trinket_pos,
								content_id = "trinket_"..trinket_pos,
								content_check_function = function(ui_content)
									return ui_content and ui_content.show or false
								end,
							})
						end
						return passes
					end)()
	},
	content = (function()
					local content = {}
					local trinket_icons = {
						"icon_trophy_twig_of_loren_01_03",
						"icon_trophy_potion_rack_t3_01",
						"icon_trophy_valten_saga_01_03",
						"icon_trophy_luckstone_01_01",
						"icon_trophy_carrion_claw_01_01",
						"icon_trophy_fish_t3_01",
						"icon_trophy_wine_bottle_01_01",
						"icon_trophy_honing_kit_with_carroburg_seal_01_03",
						"icon_trophy_ornamented_scroll_case_01_03",
						"icon_trophy_solland_sigil_01_01",
					}
					for i, icon in ipairs(trinket_icons) do
						content["trinket_"..i] = {
							show = false,
							texture_id = icon,
							uvs = i < 6 and { { 0.17, 0.17 }, { 0.83, 0.83 } } or { { 0.17, 0.5 }, { 0.83, 0.83 } },
						}
					end
					-- dove special case, we show the trinket with 2 widgets, for each half
					content["trinket_"..100] = {
						show = false,
						texture_id = "icon_trophy_silver_dove_of_shallya_01_03",
						uvs = { { 0.17, 0.17 }, { 0.5, 0.83 } },
					}
					content["trinket_"..101] = {
						show = false,
						texture_id = "icon_trophy_silver_dove_of_shallya_01_03",
						uvs = { { 0.5, 0.17 }, { 0.83, 0.83 } },
					}
					return content
				end)(),
	style = (function()
					local style = {}
					local offset_x = 37
					for i, offset in ipairs({0, offset_x, offset_x*2, offset_x*3, offset_x*4}) do
						style["trinket_"..i] = {
							color = { 255, 255, 255, 255 },
							offset = { offset, 0, 1 },
							size = { 30, 30 },
						}
						style["trinket_"..(i+5)] = {
							color = { 255, 255, 255, 255 },
							offset = { offset, 0, 3 },
							size = { 30, 15 },
						}
					end
					-- dove special case, we show the trinket with 2 widgets, for each half, and each of those two with different z depth
					style["trinket_"..100] = {
						color = { 255, 255, 255, 255 },
						offset = { 0, 0, 2 },
						size = { 15, 30 },
					}
					style["trinket_"..101] = {
						color = { 255, 255, 255, 255 },
						offset = { 15, 0, 0 },
						size = { 15, 30 },
					}
					return style
				end)(),
}

local luck_position = 4
local dupe_position = luck_position + 5
local lichbone_position = 5
local sisterhood_position = lichbone_position + 5
local tracked_trinkets = {
	pot_share = { match = "potion_spread", position = 2 },
	pot_share_skulls = { match = "pot_share", position = 2 },
	dove = { match = "heal_self_on_heal_other", position = 100 },
	hp_share = { match = "medpack_spread", position = 1},
	grenade_radius = { match = "grenade_radius", position = 3 },
	luck = { match = "increase_luck", position = luck_position },
	grim = { match = "reduce_grimoire_penalty", position = lichbone_position },
	med_dupe = { match = "not_consume_medpack", position = 6 },
	pot_dupe = { match = "not_consume_potion", position = 7 },
	bomb_dupe = { match = "not_consume_grenade", position = 8 },
	dupe = { match = "not_consume_pickup", position = dupe_position },
	sisterhood = { match = "shared_damage", position = sisterhood_position },
}
local trinket_icon_replacements = {
	["icon_trophy_skull_encased_t3_03"] = "icon_trophy_potion_rack_t3_01",
	["icon_trophy_garlic_01"] = "icon_trophy_twig_of_loren_01_02",
	["icon_trophy_moot_charm_01_01"] = "icon_trophy_luckstone_01_01",
	["icon_trophy_flower_flask_01_01"] = "icon_trophy_carrion_claw_01_01",
}

local function get_active_trinket_slots(attachment_extn)
	local active_trinkets = {}
	for _, slot_name in ipairs({"slot_trinket_1", "slot_trinket_2", "slot_trinket_3"}) do
		local slot_data =  attachment_extn and attachment_extn._attachments.slots[slot_name]
		local item_key = slot_data and slot_data.item_data.key
		for _, trinket in pairs(tracked_trinkets) do
			if item_key and string.find(item_key, trinket.match) ~= nil then
				local pos = trinket.position
				active_trinkets[pos] = {info = trinket, icon = ItemMasterList[item_key].inventory_icon}
				if mod:get(HOMOGENIZE_PARTY_TRINKET_ICONS) then
					for icon_name, replacement_icon_name in pairs(trinket_icon_replacements) do
						if active_trinkets[pos].icon == icon_name then
							active_trinkets[pos].icon = replacement_icon_name
						end
					end
				end
			end
		end
	end
	return active_trinkets
end

mod:hook_safe(UnitFrameUI, "_create_ui_elements", function(self, frame_index)
	self._hudmod_is_own_player = not frame_index
end)

mod:hook_safe(UnitFrameUI, "draw", function(self, dt)
	local data = self.data
	if self._is_visible and data._hudmod_active_trinkets then
		local ui_renderer = self.ui_renderer
		local input_service = self.input_manager:get_service("ingame_menu")
		UIRenderer.begin_pass(ui_renderer, self.ui_scenegraph, input_service, dt, nil, self.render_settings)

		local widget = self._trinkets_widget
		if not widget or rawget(_G, "_customhud_defined") and CustomHUD.was_toggled then
			widget = UIWidget.init(trinkets_widget)
			self._trinkets_widget = widget

			if self._hudmod_is_own_player then
				widget.offset[2] = -85
				for _, trinket_style in pairs(widget.style) do
					trinket_style.offset[1] = trinket_style.offset[1] - (rawget(_G, "_customhud_defined") and CustomHUD.enabled and 291 or 295)
				end
			end
		end

		-- show/hide trinket widgets and assign trinket icons
		local important_trinkets = data._hudmod_active_trinkets or {}
		for i=1,10 do
			widget.content["trinket_"..i].show = false
			if important_trinkets[i] then
				if i < 6 or important_trinkets[i-5] then
					widget.content["trinket_"..i].show = true
					widget.content["trinket_"..i].texture_id = important_trinkets[i].icon
				elseif i == dupe_position then
					widget.content["trinket_"..luck_position].show = true
					widget.content["trinket_"..luck_position].texture_id = important_trinkets[i].icon
				elseif i == sisterhood_position then
					widget.content["trinket_"..lichbone_position].show = true
					widget.content["trinket_"..lichbone_position].texture_id = important_trinkets[i].icon
				end
			end
		end

		-- dove trinket related stuff
		widget.content["trinket_"..100].show = not not important_trinkets[100]
		widget.content["trinket_"..101].show = widget.content["trinket_"..100].show
		if widget.content["trinket_"..100].show then
			widget.content["trinket_"..100].texture_id = important_trinkets[100].icon
			widget.content["trinket_"..101].texture_id = important_trinkets[100].icon
			if important_trinkets[6] then
				widget.content["trinket_"..6].show = true
				widget.content["trinket_"..6].texture_id = important_trinkets[6].icon
			end
		end

		-- render trinkets widget if player not dead or respawned
		if not self._customhud_is_dead and not self._customhud_player_unit_missing and not self._customhud_has_respawned then
			UIRenderer.draw_widget(ui_renderer, widget)
		end

		UIRenderer.end_pass(ui_renderer)
	end
end)

mod:hook(UnitFramesHandler, "update", function(orig_func, self, dt, t, my_player)
	local player_unit = self.my_player.player_unit
	if player_unit then
		local unit_frame = self._unit_frames[self._current_frame_index]
		if unit_frame and unit_frame.sync then
			local extensions = unit_frame.player_data.extensions
			if extensions and not extensions.attachment and ScriptUnit.has_extension(unit_frame.player_data.player_unit, "attachment_system") then
				extensions.attachment = ScriptUnit.extension(unit_frame.player_data.player_unit, "attachment_system")
			end
			local attachment_extn = extensions and extensions.attachment
			local active_trinkets = {}
			if attachment_extn then
				active_trinkets = get_active_trinket_slots(attachment_extn)
			end
			if unit_frame.data._hudmod_active_trinkets ~= active_trinkets then
				unit_frame.data._hudmod_active_trinkets = active_trinkets
				self._dirty = true
			end
		end
	end

	return orig_func(self, dt, t, my_player)
end)
