-- **
-- Damage calculations are based on http://kancollecalc.web.fc2.com/damage_formula.html and WikiWiki combat page.
-- NB CI rate formula is from WikiWiki combat page (also, 検証、仮説スレ18).
-- Evasion rate formula: 検証、仮説スレ 10, 488.
-- Accuracy rate formula: 検証、仮説スレ17, 314, http://kancolle.wikia.com/wiki/Sandbox/Accuracy_Evasion_Tables
-- 

-- * TODO: Switch to Combat2.

local Combat = {}

Combat.modifier = {

	comined_firepower = {
		ctf_first = 0,
		ctf_second = 10,
		stf_first = 10,
		stf_second = -5,
	},

	comined_torpedo = -5,

	night_contact = 5,

	formation = {
		line_ahead = 1.0,
		double_line = 0.8,
		diamond = 0.7,
		echelon = 0.6,
		line_abreast = 0.6,
		combined = {
			line_ahead = 1.1,
			diamond = 0.7,
			double_line = 1.0,
			line_abreast = 0.8,
		},
	},

	engagement = {
		green_t = 1.2,
		parallel = 1.0,
		head_on = 0.8,
		red_t = 0.6,
	},

	health = {
		normal = 1.0,
		chuuha = 0.7,
		taiha = 0.4,
	},

	anti_ground = 2.5,
	wg_bonus = 75,

	cap = {
		day = 150,
		night = 300,
	},

	spotting = {
		cut_in = {
			main_main = 1.5,
			main_ap = 1.3,
			main_radar = 1.2,
			main_second = 1.1,
		},
		double = 1.2,
	},

	night_attack = {
		cut_in = {
			main = 2,
			main_misc = 1.75,
			torpedo = 1.5,
			mixed = 1.3,
		},
		double = 1.2,
		normal = 1,
	},

	critical = 1.5,

	ap = {
		main_ap = 1.08,
		main_ap_radar = 1.1,
		main_second_ap = 1.15,
		main_second_ap_radar = 1.15,
	},

}

function Combat.ammo_modifier(ammo_bars)
	return ammo_bars >= 5 and 1 or ammo_bars / 5
end

-- * Combat object with ship-independent values as fields.
--   Ship and enemy values are passed via arguments.

function Combat:new(is_night_battle)
	local stage = {
		combined_firepower = 0,
		combined_torpedo = 0,
		formation = self.modifier.formation.line_ahead,
		engagement = self.modifier.engagement.parallel,
		night_contact = 0,
		is_night_battle = is_night_battle,
		cap = is_night_battle and self.modifier.cap.night or self.modifier.cap.day,
		contact = 1, -- TODO
		expert = 1, -- TODO
	}
	setmetatable(stage, self)
	self.__index = self
	return stage
end

function Combat:damage_pre_cap(ship)
	return self.engagement * self.formation * ship.health * ship.anti_ground * ship.anti_sub * ship.night_attack * ship.attack_power
end

function Combat:damage_cap(attack_power)
	if attack_power > self.cap then
		attack_power = self.cap + math.sqrt(attack_power - self.cap)
	end
	return math.floor(attack_power)
end

function Combat:damage_post_cap(attack_power, ship, enemy_armor)
	attack_power = ship.spotting * self.contact * math.floor(self.expert * ship.critical * math.floor(ship.ap * attack_power))
	if enemy_armor then
		local min_armor = enemy_armor * 0.7
		local max_armor = enemy_armor * 0.7 + math.max(enemy_armor - 1, 0) * 0.6
		local min = math.floor((attack_power - max_armor) * ship.ammo_modifier)
		local max = math.floor((attack_power - min_armor) * ship.ammo_modifier)
		return { min, max }
	else
		return math.floor(attack_power * ship.ammo_modifier)
	end
end

function Combat:damage(ship, enemy_armor)
	return self:damage_post_cap(self:damage_cap(self:damage_pre_cap(ship)), ship, enemy_armor)
end

function Combat:shelling(ship)
	ship.attack_power = 5 + ship._firepower_max + ship.equipment_bonus.firepower + self.combined_firepower + ship.anti_ground_bonus
	return ship
end

function Combat:torpedo(ship)
	ship.attack_power = 5 + ship._torpedo_max + ship.equipment_bonus.torpedo + self.combined_torpedo
	return ship
end

function Combat:night_battle(ship)
	if ship.health == self.modifier.health.taiha then
		ship.attack_power = 0
	else
		ship.attack_power = self.night_contact + ship._firepower_max + ship._torpedo_max + ship.equipment_bonus.firepower + ship.equipment_bonus.torpedo
	end
	return ship
end

Combat.nb_cut_in_types = {
	torpedo = { k = 70, luck_cap = 60 },
	mixed = { k = 70, luck_cap = 70 },
	main = { k = 50, luck_cap = 55 },
}

function Combat.nb_cut_in_rate(ship, modifier)
	if ship._luck <= modifier.luck_cap then
		return math.floor(math.sqrt(modifier.k * ship._luck))
	else
		return math.floor(math.sqrt(modifier.k * modifier.luck_cap))
	end
end

function Combat.evasion_rate(ship, high_morale)
	local e = ship:evasion_leveled()
	if high_morale then
		return math.floor(100 * 2 * e / (2 * e + 40))
	else
		return math.floor(100 * e / (e + 40))
	end
end

function Combat.accuracy_rate(ship)
	return math.floor(100 * ((math.sqrt(ship._level) - 1) / 45 + ship._luck / 1000))
end

function Combat.air_power(ship)
	local slot1 = math.floor(25 + 10 * math.sqrt(ship._equipment[1].size))
	local slot2 = math.floor(25 + 10 * math.sqrt(ship._equipment[2].size))
	local slot3 = math.floor(25 + 10 * math.sqrt(ship._equipment[3].size))
	local slot4 = ship._equipment[4] and math.floor(25 + 10 * math.sqrt(ship._equipment[4].size)) or 0
	return {
		slot_all = slot1 + slot2 + slot3 + slot4,
		slot1 = slot1,
		slot2 = slot2,
		slot3 = slot3,
		slot4 = slot4,
	}
end

-- * Ship object with extra fields related to combat.

function Combat.ship(ship, equip, night_attack, spotting)

	local ship = {
		_firepower_max = ship._firepower_max or 0,
		_torpedo_max = ship._torpedo_max or 0,
		_luck = ship._luck or 0,
		equipment = equip or {},
		equipment_bonus = { firepower = 0, torpedo = 0 },
		health = ship.health or Combat.modifier.health.normal,
		anti_ground = ship.anti_ground and Combat.modifier.anti_ground or 1,
		anti_ground_bonus = ship.wg and Combat.modifier.wg_bonus or 0,
		anti_sub = ship.anti_sub or 1,
		night_attack = night_attack or 1,
		night_attack_x2 = night_attack == Combat.modifier.night_attack.cut_in.torpedo or
						  night_attack == Combat.modifier.night_attack.cut_in.mixed,
		spotting = spotting or 1,
		critical = ship.critical or 1,
		ap = ship.ap or 1,
		ammo_modifier = ship.ammo_modifier or 1,
	}

	for _, eq in pairs(ship.equipment) do
		if eq.firepower then
			ship.equipment_bonus.firepower = ship.equipment_bonus.firepower + eq.firepower + (eq.k and eq.rank and eq.k * math.sqrt(eq.rank) or 0)
		end
		if eq.torpedo then
			ship.equipment_bonus.torpedo = ship.equipment_bonus.torpedo + eq.torpedo + (eq.k and eq.rank and eq.k * math.sqrt(eq.rank) or 0)
		end
	end
	ship.equipment_bonus.firepower = math.floor(ship.equipment_bonus.firepower)
	ship.equipment_bonus.torpedo = math.floor(ship.equipment_bonus.torpedo)

	return ship

end

-- * Using Module:ShipCapabilities.

local BaseData = require("Module:BaseData")
local ShipCapabilities = require("Module:ShipCapabilities")

local Combat2 = BaseData{

	fleet = {
		single = {
			line_ahead   = { shelling = 1.0, salvo = 1.0, asw = 0.6, firepower = 0, torpedo = 0, },
			double_line  = { shelling = 0.8, salvo = 0.8, asw = 0.8, firepower = 0, torpedo = 0, },
			diamond      = { shelling = 0.7, salvo = 0.7, asw = 1.2, firepower = 0, torpedo = 0, },
			echelon      = { shelling = 0.6, salvo = 0.6, asw = 1.0, firepower = 0, torpedo = 0, },
			line_abreast = { shelling = 0.6, salvo = 0.6, asw = 1.3, firepower = 0, torpedo = 0, },
		},
		ctf_main = {
			line_abreast = { shelling = 0.8, salvo = nil, asw = 1.0, firepower = 0, torpedo = nil, },
			double_line  = { shelling = 1.0, salvo = nil, asw = 0.8, firepower = 0, torpedo = nil, },
			diamond      = { shelling = 0.7, salvo = nil, asw = 0.75, firepower = 0, torpedo = nil, },
			line_ahead   = { shelling = 1.1, salvo = nil, asw = 0.5, firepower = 0, torpedo = nil, },
		},
		ctf_escort = {
			line_abreast = { shelling = 0.8, salvo = 0.7, asw = 1.0, firepower = 10, torpedo = -5, },
			double_line  = { shelling = 1.0, salvo = 0.9, asw = 0.8, firepower = 10, torpedo = -5, },
			diamond      = { shelling = 0.7, salvo = 0.6, asw = 0.75, firepower = 10, torpedo = -5, },
			line_ahead   = { shelling = 1.1, salvo = 1.0, asw = 0.5, firepower = 10, torpedo = -5, },
		},
		stf_main = {
			line_abreast = { shelling = 0.8, salvo = nil, asw = 1.0, firepower = 10, torpedo = nil, },
			double_line  = { shelling = 1.0, salvo = nil, asw = 0.8, firepower = 10, torpedo = nil, },
			diamond      = { shelling = 0.7, salvo = nil, asw = 0.75, firepower = 10, torpedo = nil, },
			line_ahead   = { shelling = 1.1, salvo = nil, asw = 0.5, firepower = 10, torpedo = nil, },
		},
		stf_escort = {
			line_abreast = { shelling = 0.8, salvo = 0.7, asw = 1.0, firepower = -5, torpedo = -5, },
			double_line  = { shelling = 1.0, salvo = 0.9, asw = 0.8, firepower = -5, torpedo = -5, },
			diamond      = { shelling = 0.7, salvo = 0.6, asw = 0.75, firepower = -5, torpedo = -5, },
			line_ahead   = { shelling = 1.1, salvo = 1.0, asw = 0.5, firepower = -5, torpedo = -5, },
		},
	},

	engagement = {
		green_t = 1.2,
		parallel = 1.0,
		head_on = 0.8,
		red_t = 0.6,
	},

	health = {
		normal = 1.0,
		chuuha = 0.7,
		taiha = 0.4,
	},

	-- handled by ShipCapabilities
	--night_attack = {
	--	cut_in = {
	--		main = 2,
	--		main_misc = 1.75,
	--		torpedo = 1.5,
	--		mixed = 1.3,
	--	},
	--	double = 1.2,
	--	normal = 1,
	--},

	-- TODO: also use ShipCapabilities?
	spotting = {
		cut_in = {
			main_main = 1.5,
			main_ap = 1.3,
			main_radar = 1.2,
			main_second = 1.1,
		},
		double = 1.2,
	},

	ap = {
		main_ap = 1.08,
		main_ap_radar = 1.1,
		main_second_ap = 1.15,
		main_second_ap_radar = 1.15,
	},

	contact = {
		[0] = 1.12,
		[1] = 1.12,
		[2] = 1.17,
		[3] = 1.20,
	},

	cap = {
		day = 150,
		night = 300,
		asw = 100,
	},

	day_battle = 1,
	opening_torpedo = 2,
	closing_torpedo = 3,
	night_battle = 4,
	asw = 5,
	opening_airstrike = 6,
	day_battle = 7,

}

function Combat2:create(stage)
	local this = {}
	this.stage = stage or {
		fleet = Combat2.fleet.single.line_ahead,
		engagement = Combat2.engagement.parallel,
	}
	setmetatable(this, this)
	this.__index = self
	return this
end

function Combat2:_get_ammo_modifier(ammo_bars)
	return ammo_bars >= 5 and 1 or ammo_bars / 5
end

function Combat2:damage(type, ship, enemy, critical)

	ship = ShipCapabilities{ ship = ship }

	local vs_installation = enemy and enemy:is_installation()

	local fleet = self.stage.fleet
	local formation = fleet.shelling
	local engagement = self.stage.engagement

	local health = ship._health or Combat2.health.normal

	local cap = Combat2.cap.day
	local spotting = 1
	local ap = 1
	local contact = 1
	local expert = 1
	local attack_power = 0

	if type == Combat2.day_battle then
		spotting = ship._spotting or 1
		ap = ship._ap or 1
		expert = 1 + ((ship._expert_n or 0) + (ship._expert_first and 1 or 0)) / 10
		_, attack_power = ship:day_battle(vs_installation, fleet.firepower)
	elseif type == Combat2.closing_torpedo or type == Combat2.opening_torpedo then
		if not fleet.torpedo then
			return false
		end
		formation = fleet.salvo
		attack_power = Combat2.closing_torpedo and ship:closing_torpedo(fleet.torpedo) or Combat2.opening_torpedo and ship:opening_torpedo(fleet.torpedo)
	elseif type == Combat2.asw then
		formation = fleet.asw
		cap = Combat2.cap.asw
		attack_power = ship:asw_attack()
	elseif type == Combat2.night_battle then
		if health == Combat2.health.taiha then
			return false
		end
		formation = 1
		engagement = 1
		cap = Combat2.cap.night
		_, attack_power = ship:night_battle(vs_installation, self.stage.night_contact)
	elseif type == Combat2.opening_airstrike then
		expert = 1 + ((ship._expert_n or 0) + (ship._expert_first and 1 or 0)) / 10
		contact = self.stage.contact and Combat2.contact[self.stage.contact] or 1
		attack_power = ship:opening_airstrike()
	end

	if not attack_power then
		return false
	end

	attack_power = engagement * formation * health * attack_power

	if attack_power > cap then
		attack_power = cap + math.sqrt(attack_power - cap)
	end
	attack_power = math.floor(attack_power)

	expert = critical and expert or 1
	local critical = critical and 1.5 or 1

	attack_power = spotting * contact * math.floor(expert * critical * math.floor(ap * attack_power))

	local ammo_modifier = ship._ammo_bars and self:_get_ammo_modifier(ship._ammo_bars) or 1

	if enemy and enemy._armor then
		local armor = enemy._armor
		local min_armor = armor * 0.7
		local max_armor = armor * 0.7 + math.max(armor - 1, 0) * 0.6
		local min = math.floor((attack_power - max_armor) * ammo_modifier)
		local max = math.floor((attack_power - min_armor) * ammo_modifier)
		return { min = math.max(0, min), max = math.max(0, max) }
	else
		return math.floor(attack_power * ammo_modifier)
	end

end

Combat.Combat2 = Combat2

-- * Template interface.

local Formatting = require("Module:Formatting")
local Ship = require("Module:Ship")
local ShipCapabilities = require("Module:ShipCapabilities")
local Equipment = require("Module:Equipment")

local setups = {
	DD = {
		"10cm Twin High-angle Gun Mount + Anti-Aircraft Fire Director",
		"10cm Twin High-angle Gun Mount + Anti-Aircraft Fire Director",
	},
	DD_CI = {
		"61cm Quintuple (Oxygen) Torpedo Mount",
		"61cm Quintuple (Oxygen) Torpedo Mount",
		"61cm Quintuple (Oxygen) Torpedo Mount",
	},
}

function init_setup(ship, ci, improved)
	local setup = setups[Formatting:format_ship_code(ship._type) .. (ci and "_CI" or "")] or setups[ship._name .. (ci and "_CI" or "")] or {}
	ship._equipment = {}
	for i = 1, #setup do
		ship._equipment[i] = { equipment = Equipment(setup[i]){ _level = improved and 10 or 0 } }
	end
end

function nb(ship)
	init_setup(ship)
	return Combat2():damage(Combat2.night_battle, ship)
end

function nb_max(ship)
	init_setup(ship, false, true)
	return Combat2():damage(Combat2.night_battle, ship)
end

function nb_ci(ship)
	init_setup(ship, true)
	return Combat2():damage(Combat2.night_battle, ship)
end

function nb_ci_max(ship)
	init_setup(ship, true, true)
	return Combat2():damage(Combat2.night_battle, ship)
end

function format_nb_damage(damage)
	return damage >= Combat2.cap.night and string.format('<span style="color:green;">%s</span>', damage) or tostring(damage)
end

function format_nb_ci_boost(boost)
	if boost >= 90 then
		return string.format('<span style="color:green;">%s</span>', boost)
	elseif boost >= 70 then
		return string.format('<span style="color:yellow;">%s</span>', boost)
	elseif boost >= 50 then
		return string.format('<span style="color:orange;">%s</span>', boost)
	else
		return string.format('<span style="color:red;">%s</span>', boost)
	end
end

local nb_ci_types = {
	torpedo = { k = 70, luck_cap = 60 },
	mixed = { k = 70, luck_cap = 70 },
	main = { k = 50, luck_cap = 55 },
}

function nb_ci_rate(luck, modifier)
	if luck <= modifier.luck_cap then
		return math.floor(math.sqrt(modifier.k * luck))
	else
		return math.floor(math.sqrt(modifier.k * modifier.luck_cap))
	end
end

function format_luck(luck)
	local maruyu_sets = math.floor(60 - luck) / 8
	local hint = string.format("%s%% base rate, ", nb_ci_rate(luck, nb_ci_types.torpedo))
	hint = hint .. (
		(maruyu_sets < 0 or luck == 60) and "capped (luck >= 60)"
		or maruyu_sets == 0 and "few Maruyu to cap (60 luck)"
		or string.format("~%s Maruyu sets (5 Maruyu Kai each) to cap (60 luck)", maruyu_sets))
	if luck >= 60 then
		return Formatting:tooltip(luck, hint, nil, {color = "green"})
	elseif luck >= 50 then
		return Formatting:tooltip(luck, hint, nil, {color = "yellow"})
	elseif luck >= 40 then
		return Formatting:tooltip(luck, hint, nil, {color = "orange"})
	else
		return Formatting:tooltip(luck, hint, nil, {color = "red"})
	end
end

local functions = {
	_full_name = function(ship) return string.format("%s %s", ship._name, ship._suffix) end,
	_link = function(ship) return string.format("[[%s]]", ship._name) end,
	_nb = function(ship) return format_nb_damage(nb(ship)) end,
	_nb_max = function(ship) return format_nb_damage(nb_max(ship)) end,
	_nb_ci = function(ship) return format_nb_damage(nb_ci(ship)) end,
	_nb_ci_max = function(ship) return format_nb_damage(nb_ci_max(ship)) end,
	_nb_ci_boost = function(ship) return format_nb_ci_boost(nb_ci(ship) - nb(ship)) end,
	_nb_ci_boost_max = function(ship) return format_nb_ci_boost(nb_ci_max(ship) - nb_max(ship)) end,
	-- override Lua stat
	_luck = function(ship) return format_luck(ship._luck) end,
}

function format_value(v, ship)
	if string.sub(v, 1, 1) == "_" then
		local fn = functions[v]
		if fn then
			return fn(ship)
		else
			local lua_stat = ship[v]
			if lua_stat ~= nil then
				return tostring(lua_stat)
			else
				return "N/A"
			end
		end
	else
		return v
	end
end

function Combat.format_values(frame)

	local args = frame.args
	local ship_key = args[1]
	local ship = Ship(ship_key){ _level = 99 }

	if ship and ship._type then
		local args_length = #args
		if args_length > 2 then
			local result = "|-\n"
			for i = 2, args_length do
				result = result .. string.format("|%s\n", format_value(args[i], ship))
			end
			return result			
		elseif args_length == 2 then
			return format_value(args[2], ship)
		end
	end

	return "N/A"

end

return Combat