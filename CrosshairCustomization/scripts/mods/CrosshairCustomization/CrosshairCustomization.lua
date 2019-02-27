-- luacheck: globals get_mod

local mod = get_mod("CrosshairCustomization")

-- need to store stuff that doesn't get wiped on mod reload
local persistent_data = mod:persistent_table("persistent_data")

local COLOR_INDEX = {
	DEFAULT = 1,
	RED = 2,
	GREEN = 3,
	CUSTOM = 4
}

local ENLARGE = {
	OFF = 1,
	SLIGHTLY = 2,
	HEAVILY = 3
}

local SETTING_NAMES = {
	COLOR = "color",
	ENLARGE = "enlarge",
	HEADSHOT_MARKER = "headshot_marker",
	HEADSHOT_MARKER_COLOR = "headshot_marker_color",
	DOT = "dot",
	DOT_TOGGLE_HOTKEY = "dot_toggle_hotkey",
	NO_MELEE_DOT = "no_melee_dot",
	CUSTOM_RED = "custom_red",
	CUSTOM_GREEN = "custom_green",
	CUSTOM_BLUE = "custom_blue",
	HS_CUSTOM_RED = "hs_custom_red",
	HS_CUSTOM_GREEN = "hs_custom_green",
	HS_CUSTOM_BLUE = "hs_custom_blue",
}

local COLORS = {
	DEFAULT = {255, 255, 255, 255},
	RED = {255, 255, 0, 0},
	GREEN = {255, 0, 255, 0},
}
COLORS[COLOR_INDEX.DEFAULT] = COLORS.DEFAULT
COLORS[COLOR_INDEX.RED] = COLORS.RED
COLORS[COLOR_INDEX.GREEN] = COLORS.GREEN

mod.headshot_animations = {}
mod.headshot_widgets = {}

local widget_definitions = {
	crosshair_hit_1 = {
		scenegraph_id = "crosshair_hit_2",
		element = UIElements.RotatedTexture,
		content = {
			texture_id = "crosshair_01_hit"
		},
		style = {
			rotating_texture = {
				angle = math.pi*2,
				pivot = {
					0,
					0
				},
				offset = {
					-8,
					1,
					0
				},
				color = {
					0,
					255,
					255,
					255
				}
			}
		}
	},
	crosshair_hit_2 = {
		scenegraph_id = "crosshair_hit_1",
		element = UIElements.RotatedTexture,
		content = {
			texture_id = "crosshair_01_hit"
		},
		style = {
			rotating_texture = {
				angle = math.pi*1.5,
				pivot = {
					0,
					0
				},
				offset = {
					8,
					1,
					0
				},
				color = {
					0,
					255,
					255,
					255
				}
			}
		}
	},
	crosshair_hit_3 = {
		scenegraph_id = "crosshair_hit_4",
		element = UIElements.RotatedTexture,
		content = {
			texture_id = "crosshair_01_hit"
		},
		style = {
			rotating_texture = {
				angle = math.pi*1,
				pivot = {
					0,
					0
				},
				offset = {
					8,
					-1,
					0
				},
				color = {
					0,
					255,
					255,
					255
				}
			}
		}
	},
	crosshair_hit_4 = {
		scenegraph_id = "crosshair_hit_3",
		element = UIElements.RotatedTexture,
		content = {
			texture_id = "crosshair_01_hit"
		},
		style = {
			rotating_texture = {
				angle = math.pi*0.5,
				pivot = {
					0,
					0
				},
				offset = {
					-8,
					-1,
					0
				},
				color = {
					0,
					255,
					255,
					255
				}
			}
		}
	},
}

local function populate_defaults(crosshair_ui)
	if not persistent_data.default_sizes then
		persistent_data.default_sizes = {
			crosshair_dot = table.clone(crosshair_ui.ui_scenegraph.crosshair_dot.size),
			crosshair_up = table.clone(crosshair_ui.ui_scenegraph.crosshair_up.size),
			crosshair_down = table.clone(crosshair_ui.ui_scenegraph.crosshair_down.size),
			crosshair_left = table.clone(crosshair_ui.ui_scenegraph.crosshair_left.size),
			crosshair_right = table.clone(crosshair_ui.ui_scenegraph.crosshair_right.size),
		}
	end
end

mod:hook_safe(CrosshairUI, "draw", function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("ingame_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)
	for i = 1, 4 do
		UIRenderer.draw_widget(ui_renderer, mod.headshot_widgets[i])
	end
	UIRenderer.end_pass(ui_renderer)
end)

mod:hook_safe(CrosshairUI, "update_hit_markers", function (self, dt)
	if not mod.headshot_widgets[1] then
		for i=1,4 do
			mod.headshot_widgets[i] = UIWidget.init(widget_definitions["crosshair_hit_"..i])
		end
	end

	local hud_extension = ScriptUnit.extension(self.local_player.player_unit, "hud_system")
	if hud_extension.headshot_hit_enemy then
		hud_extension.headshot_hit_enemy = nil

		for i = 1, 4 do
			local hit_marker = mod.headshot_widgets[i]
			mod.headshot_animations[i] = UIAnimation.init(UIAnimation.function_by_time, hit_marker.style.rotating_texture.color, 1, 255, 0, UISettings.crosshair.hit_marker_fade, math.easeInCubic)
		end
	end

	if mod.headshot_animations[1] then
		for i = 1, 4 do
			UIAnimation.update(mod.headshot_animations[i], dt)
		end

		if UIAnimation.completed(mod.headshot_animations[1]) then
			for i = 1, 4 do
				mod.headshot_animations[i] = nil
			end
		end
	end
end)

local function change_crosshair_color(crosshair_ui)
	local color_index = mod:is_enabled() and mod:get(SETTING_NAMES.COLOR) or COLOR_INDEX.DEFAULT
	local color = COLORS[color_index] or { 255, mod:get(SETTING_NAMES.CUSTOM_RED), mod:get(SETTING_NAMES.CUSTOM_GREEN), mod:get(SETTING_NAMES.CUSTOM_BLUE) }
	crosshair_ui.crosshair_dot.style.color = table.clone(color)
	crosshair_ui.crosshair_up.style.color = table.clone(color)
	crosshair_ui.crosshair_down.style.color = table.clone(color)
	crosshair_ui.crosshair_left.style.color = table.clone(color)
	crosshair_ui.crosshair_right.style.color = table.clone(color)

	if not crosshair_ui.hit_marker_animations[1] then
		for _,v in ipairs(crosshair_ui.hit_markers) do
		  v.style.rotating_texture.color = table.clone(color)
		  v.style.rotating_texture.color[1] = 0
		end
	end

	if mod.headshot_widgets[1] and not mod.headshot_animations[1] then
		for i = 1, 4 do
			local hs_color_index = mod:is_enabled() and mod:get(SETTING_NAMES.HEADSHOT_MARKER_COLOR) or COLOR_INDEX.DEFAULT
			local hs_color = COLORS[hs_color_index] or { 255, mod:get(SETTING_NAMES.HS_CUSTOM_RED), mod:get(SETTING_NAMES.HS_CUSTOM_GREEN), mod:get(SETTING_NAMES.HS_CUSTOM_BLUE) }
			mod.headshot_widgets[i].style.rotating_texture.color = table.clone(hs_color)
			mod.headshot_widgets[i].style.rotating_texture.color[1] = 0
		end
	end
end

local function change_crosshair_scale(crosshair_ui)
	local crosshair_dot_scale = 1
	local crosshair_lines_scale = 1

	local enlarge_value = mod:is_enabled() and mod:get(SETTING_NAMES.ENLARGE) or ENLARGE.OFF
	if enlarge_value == ENLARGE.SLIGHTLY then
		crosshair_dot_scale = 1.5
		crosshair_lines_scale = 1.2
	elseif enlarge_value == ENLARGE.HEAVILY then
		crosshair_dot_scale = 2
		crosshair_lines_scale = 1.5
	end

	for crosshair_part, crosshair_part_size_default in pairs(persistent_data.default_sizes) do
		for i, default_size in ipairs(crosshair_part_size_default) do
		  crosshair_ui.ui_scenegraph[crosshair_part].size[i] = default_size * crosshair_lines_scale
		end
	end

	for i, default_size in ipairs(persistent_data.default_sizes.crosshair_dot) do
		crosshair_ui.ui_scenegraph.crosshair_dot.size[i] = default_size * crosshair_dot_scale
	end
end

local function draw_crosshair_prehook(crosshairUI)
	populate_defaults(crosshairUI)
	change_crosshair_scale(crosshairUI)
	change_crosshair_color(crosshairUI)
end

mod:hook(CrosshairUI, "draw_dot_style_crosshair", function(func, self, ...)
	draw_crosshair_prehook(self)

	if mod:is_enabled() and mod:get(SETTING_NAMES.NO_MELEE_DOT) then
		self.crosshair_dot.style.color[1] = 0;
	end

	return func(self, ...)
end)

mod:hook(CrosshairUI, "draw_default_style_crosshair", function(func, self, ...)
	draw_crosshair_prehook(self)

	if mod:is_enabled() and mod:get(SETTING_NAMES.DOT) then
		self.crosshair_up.style.color[1] = 0
		self.crosshair_down.style.color[1] = 0
		self.crosshair_left.style.color[1] = 0
		self.crosshair_right.style.color[1] = 0
	end

	return func(self, ...)
end)

mod:hook_safe(DamageSystem, "rpc_add_damage", function (self, sender, victim_unit_go_id, attacker_unit_go_id, attacker_is_level_unit, damage_amount, hit_zone_id, damage_type_id, damage_direction, damage_source_id)
	if not mod:get(SETTING_NAMES.HEADSHOT_MARKER) then
		return
	end

	local victim_unit = self.unit_storage:unit(victim_unit_go_id)

	local attacker_unit
	if attacker_is_level_unit then
		attacker_unit = LevelHelper:unit_by_index(self.world, attacker_unit_go_id)
	else
		attacker_unit = self.unit_storage:unit(attacker_unit_go_id)
	end

	if not Unit.alive(victim_unit) then
		return
	end

	if Unit.alive(attacker_unit) then
		if ScriptUnit.has_extension(attacker_unit, "hud_system") then
			local health_extension = ScriptUnit.extension(victim_unit, "health_system")
			local damage_source = NetworkLookup.damage_sources[damage_source_id]
			local should_indicate_hit = health_extension:is_alive() and attacker_unit ~= victim_unit and damage_source ~= "wounded_degen"

			local hit_zone_name = NetworkLookup.hit_zones[hit_zone_id]

			if should_indicate_hit and (hit_zone_name == "head" or hit_zone_name == "neck") then
				local hud_extension = ScriptUnit.extension(attacker_unit, "hud_system")
				hud_extension.headshot_hit_enemy = true
			end
		end
	end
end)

mod:hook_safe(GenericUnitDamageExtension, "add_damage", function (self, attacker_unit, damage_amount, hit_zone_name, damage_type, damage_direction, damage_source_name)
	if not mod:get(SETTING_NAMES.HEADSHOT_MARKER) then
		return
	end

	local victim_unit = self.unit
	if ScriptUnit.has_extension(attacker_unit, "hud_system") then
		local health_extension = ScriptUnit.extension(victim_unit, "health_system")
		local should_indicate_hit = health_extension:is_alive() and attacker_unit ~= victim_unit and damage_source_name ~= "wounded_degen"

		if should_indicate_hit and (hit_zone_name == "head" or hit_zone_name == "neck") then
			local hud_extension = ScriptUnit.extension(attacker_unit, "hud_system")
			hud_extension.headshot_hit_enemy = true
		end
	end
end)

--- Events. ---
--- Mod suspend.
mod.on_disabled = function(initial_call) -- luacheck: ignore initial_call
	mod:hook_enable(CrosshairUI, "update_hit_markers")
	mod:hook_enable(CrosshairUI, "draw_dot_style_crosshair")
	mod:hook_enable(CrosshairUI, "draw_default_style_crosshair")
end

--- Actions. ---
--- Dot only on_toggle.
mod.dot_toggle = function()
	local current_dot_only = mod:get(SETTING_NAMES.DOT)
	mod:set(SETTING_NAMES.DOT, not current_dot_only)
end
