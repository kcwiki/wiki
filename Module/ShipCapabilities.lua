local format = require("Module:Core").format
local BaseData = require("Module:BaseData")
local Formatting = require("Module:Formatting")
 
local ShipCapabilities = BaseData{
	_attack_template = "${mode} (${attack_power})",
	_day_battle_modes = {
		[1] = "Shelling",
		[2] = "Bombing",
		[3] = "Bombing, displayed as Shelling",
	},
	_artillery_spotting_actions = {
		[1] = "Double Attack",
		[2] = "Cut-in: Secondary Gun",
		[3] = "Cut-in: Radar",
		[4] = "Cut-in: AP", --130%
		[5] = "Cut-in: AP", --150%
	},
	_artillery_spotting_attack_counts = {
		[1] = "x2",
	},
	_night_battle_modes = {
		[1] = "Single Attack",
		[2] = "Single Torpedo",
		[3] = "Double Attack",
		[4] = "Cut-in: Main Gun",
		[5] = "Cut-in: Secondary Gun",
		[6] = "Cut-in: Mixed",
		[7] = "Cut-in: Torpedo",
		[8] = "Bombing",
		[9] = "Cut-in: Carrier",
	},
	_night_battle_attack_counts = {
		[3] = "x2",
		[6] = "x2",
		[7] = "x2",
	},
	_asw_attack_modes = {
	    opening = "Opening",
		day = "Day",
		night = "Night",
	},
}
 
function ShipCapabilities:create(data)
	if data.ship then
		data._ship = data.ship
		data.ship = nil
	end
	setmetatable(data, data)
	data.__index = self
	return data
end
 
local Self = ShipCapabilities

function Self:_find_equipment(fn)
	for i = 1, self._ship:slots_length() or 0 do
		local equipment, size = self._ship:slot(i)
		if equipment and fn(equipment, size) then
            return equipment
		end
    end
    return false
end

function Self:_fold_equipment(result, fn)
	for i = 1, self._ship:slots_length() or 0 do
		local equipment, size = self._ship:slot(i)
		if equipment then
		    result = fn(equipment, result)
		end
    end
    return result
end
 
function ShipCapabilities:_is_asw_surface_ship(ship)
	if not ship then
		ship = self._ship
	end
	local ship_type = ship:type()
	local asw_leveled = ship:asw_leveled()
	return (asw_leveled == nil or asw_leveled > 0)
	    and not self:_is_carrier(ship)
		--[[
	    ship_type == 2
		or ship_type == 3
		or ship_type == 4
		or ship_type == 21
		--]]
end
 
function ShipCapabilities:_is_asw_aviation_ship(ship)
	if not ship then
		ship = self._ship
	end
	local ship_type = ship:type()
	return ship_type == 6
		or ship_type == 7
		or ship_type == 10
		or ship_type == 16
		or ship_type == 17
end
 
function ShipCapabilities:_is_aviation_ship(ship)
	if not ship then
		ship = self._ship
	end
	local ship_type = ship:type()
	return ship_type == 6
		or ship_type == 7
		or ship_type == 10
		or ship_type == 11
		or ship_type == 14
		or ship_type == 16
		or ship_type == 17
		or ship_type == 18
end
 
function ShipCapabilities:_is_light_carrier(ship)
	if not ship then
		ship = self._ship
	end
	return ship:type() == 7
end
 
function ShipCapabilities:_is_carrier(ship)
	if not ship then
		ship = self._ship
	end
	local ship_type = ship:type()
	return ship_type == 7
		or ship_type == 11
		or ship_type == 18
end
 
function ShipCapabilities:_is_submarine(ship)
	if not ship then
		ship = self._ship
	end
	local ship_type = ship:type()
	return ship_type == 13
		or ship_type == 14
end

-- Automatically make units with 0 speed installations
-- todo: the effect of type 3 shell
function ShipCapabilities:_is_installation(ship)
	if not ship then
		ship = self._ship
	end
	return ship:speed() == 0 and not ship:is_pillbox()
end

-- The logic is copied from Kan Colle Kai
-- Automatically make most of enemy carriers night bombing
-- _night_bombing is now used to disable night bombing caused by firepower and torpedo, and not related to night ASW
function ShipCapabilities:_is_night_bombing(ship)
	if not ship then
		ship = self._ship
	end
	return ship:night_bombing() ~= false
	and self:_is_carrier(ship)
	and (ship:firepower() or 0) + (ship:torpedo() or 0) > 0
end
 
function ShipCapabilities:_is_main_gun(equipment)
	local equipment_type = equipment:type()
	return equipment_type == 1
		or equipment_type == 2
		or equipment_type == 3
		or equipment_type == 38
end
 
function ShipCapabilities:_is_secondary_gun(equipment)
	return equipment:type() == 4
end
 
function ShipCapabilities:_is_torpedo(equipment)
	local equipment_type = equipment:type()
	return equipment_type == 5
		or equipment_type == 32
end
 
function ShipCapabilities:_is_bomber(equipment)
	local equipment_type = equipment:type()
	return equipment_type == 7
		or equipment_type == 8
		or equipment_type == 11
end
 
function ShipCapabilities:_is_air_power_plane(equipment)
	local equipment_type = equipment:type()
	return equipment_type == 6
		or equipment_type == 7
		or equipment_type == 8
		or equipment_type == 11
		or equipment_type == 47
end
 
function ShipCapabilities:_is_torpedo_bomber(equipment)
	return equipment:type() == 8
end
 
function ShipCapabilities:_is_reconnaissance_seaplane(equipment)
	return equipment:type() == 10
end
 
function ShipCapabilities:_is_seaplane(equipment)
	local equipment_type = equipment:type()
	return equipment_type == 10
		or equipment_type == 11
end
 
function ShipCapabilities:_is_radar(equipment)
	local equipment_type = equipment:type()
	return equipment_type == 12
		or equipment_type == 13
end
 
function ShipCapabilities:_is_sonar(equipment)
	local equipment_type = equipment:type()
	return equipment_type == 14
		or equipment_type == 40
end
 
function ShipCapabilities:_is_depth_charge(equipment)
	return equipment:type() == 15
end
 
-- only following equipments' asw value are counted for attack
function ShipCapabilities:_is_damaging_asw_equip(equipment)
	local equipment_type = equipment:type()
	return equipment_type == 7
	or equipment_type == 8
	or equipment_type == 11
	or equipment_type == 14
	or equipment_type == 15
	or equipment_type == 25
	or equipment_type == 26
	or equipment_type == 40
end
 
function ShipCapabilities:_is_type_3_shell(equipment)
	return equipment:type() == 18
end
 
function ShipCapabilities:_is_ap_shell(equipment)
	return equipment:type() == 19
end
 
function ShipCapabilities:_is_midget_submarine(equipment)
	return equipment:type() == 22
end
 
function ShipCapabilities:_is_wg(equipment)
	return equipment:type() == 37
end

--- Midget Submarines (type = 22) that trigger opening torpedo
function Self._is_active_midget_submarine(equipment)
	return equipment:id() == 41 or equipment:id() == 541
end

function ShipCapabilities:_is_night_aviation_personnel(equipment)
	return equipment:id() == 258
	or equipment:id() == 259
	or equipment:id() == 608
end
 
function ShipCapabilities:_anti_installation()
	local type_3_shells, wgs = 0, 0
	for i = 1, self._ship:slots_length() or 0 do
		local equipment, size = self._ship:slot(i)
		if equipment then
			if self:_is_type_3_shell(equipment) then
				type_3_shells = type_3_shells + 1
			elseif self:_is_wg(equipment) then
				wgs = wgs + 1
			end
		end
	end
	return { type_3_shell_equiped = type_3_shells > 0, wg_equiped = wgs > 0 }
end

-- Single Attack, Single Torpedo and Bombing are actually same
-- https://github.com/andanteyk/ElectronicObserver/blob/master/ElectronicObserver/Other/Information/kcmemo.md#%E5%A4%9C%E6%88%A6
function ShipCapabilities:_single_attack_style(ship)
    if not ship then
        ship = self._ship
    end
    local ship_type = ship:type()
    if ship_type == 13 or ship_type == 14 then
        return 2
    end
    if ship_type == 7 or ship_type == 11 or ship_type == 18 then
        -- currently hard coding, lack of Graf Zeppelin (Kai) and Saratoga
        -- a flag like _cv_night_shelling might be better?
        local ship_name = ship:name() or ""
        if ship_name:match("Lycoris Princess") or ship_name:match("Abyssal Jellyfish Princess") then
            return 1
        elseif ship:id() == 1964 then
            return 9
        else
            return 8
        end
    end
    for i = 1, ship:slots_length() or 0 do
        local equipment, size = ship:slot(i)
        if equipment then
            if self:_is_main_gun(equipment) or self:_is_secondary_gun(equipment) then
                return 1
            elseif self:_is_torpedo(equipment) then
                return 2
            end
        end
    end
    return 1
end
 
-- Basic attack power for shelling and carrier shelling, including anti-installation modifiers and fleet firepower.
function ShipCapabilities:day_battle(vs_installation, fleet_firepower)
	if not self:_is_submarine() then
		local firepower = self._ship:firepower_leveled()
		if not firepower then
			return nil
		end
		local is_installation_bbv = self._ship:speed() == 0 and self._ship:type() == 10
		if not self:_is_carrier() and not is_installation_bbv then
			if firepower > 0 then
				for i = 1, self._ship:slots_length() do
					local equipment, size = self._ship:slot(i)
					if equipment then
						local equipment_firepower = equipment:firepower_leveled()
						if equipment_firepower then
							firepower = firepower + equipment_firepower
						end
					end
				end
				local result = 5 + (fleet_firepower or 0) + firepower
				if vs_installation then
					local anti_installation = self:_anti_installation()
					result = result * (anti_installation.type_3_shell_equiped and 2.5 or 1) + (anti_installation.wg_equiped and 75 or 0)
				end
				return 1, result
			end
		else
			local total_space = self._ship:total_space()
			if total_space and total_space > 0 then
                -- [[Category:Todo]]:
                -- * for friendly carriers torpedo = 0
                -- * there are enemy carriers (carrier shelling capable ships, e.g., Supply Depot Princess)
                --   with torpedo > 0, in Vita torpedo doesn't count in the formula, a browser test is required
				local has_planes, torpedo, bombing = false, self._ship:torpedo_leveled() or 0, 0
				for i = 1, self._ship:slots_length() do
					local equipment, size = self._ship:slot(i)
					if equipment then
						local is_bomber, equipment_firepower, equipment_torpedo, equipment_bombing = self:_is_bomber(equipment), equipment:firepower(), equipment:torpedo(), equipment:bombing()
						if is_bomber then
							if size and size > 0 then
								has_planes = true
							else
								equipment_firepower = 0
								equipment_torpedo = 0
								equipment_bombing = 0
							end
						end
						if equipment_firepower then
							firepower = firepower + equipment_firepower
						end
						if equipment_torpedo then
							torpedo = torpedo + equipment_torpedo
						end
						if equipment_bombing then
							bombing = bombing + equipment_bombing
						end
					end
				end
				if has_planes then
					if vs_installation then
						if bombing > 0 then
							return false
						end
						torpedo = 0
					end
					return is_installation_bbv and 3 or 2, 55 + math.floor(1.5 * (firepower + torpedo + math.floor(1.3 * bombing)))
				end
			end
		end
	end
	return false
end
 
function ShipCapabilities:format_day_battle(mode, attack_power)
	if mode then
		return format{self._attack_template, mode = self._day_battle_modes[mode], attack_power = math.floor(attack_power)}
	elseif mode == false then
		return "No Action"
	end
	return "??"
end
 
-- Basic attack power for closing torpedo, including fleet torpedo.
function ShipCapabilities:closing_torpedo(fleet_torpedo)
	local torpedo = self._ship:torpedo_leveled()
	if torpedo and torpedo > 0 then
		for i = 1, self._ship:slots_length() do
			local equipment, size = self._ship:slot(i)
			if equipment then
				local equipment_torpedo = equipment:torpedo_leveled()
				if equipment_torpedo then
					torpedo = torpedo + equipment_torpedo
				end
			end
		end
		return 5 + (fleet_torpedo or 0) + torpedo
	end
	return false
end
 
function ShipCapabilities:format_torpedo(attack_power)
	if attack_power then
		return tostring(math.floor(attack_power))
	end
	return "No"
end
 
ShipCapabilities.format_closing_torpedo = ShipCapabilities.format_torpedo
 
-- Detect possible day time special attack modifiers.
function ShipCapabilities:artillery_spotting(post_cap_attack_power)
	local total_space = self._ship:total_space()
	if total_space ~= nil and total_space <= 0 then
		return false
	end
	local main_guns, secondary_guns, seaplanes, radars, ap_shells = 0, 0, 0, 0, 0
	for i = 1, self._ship:slots_length() or 0 do
		local equipment, size = self._ship:slot(i)
		if equipment then
			if self:_is_main_gun(equipment) then
				main_guns = main_guns + 1
			elseif self:_is_secondary_gun(equipment) then
				secondary_guns = secondary_guns + 1
			elseif self:_is_seaplane(equipment) and (size == nil or size > 0) then
				seaplanes = seaplanes + 1
			elseif self:_is_radar(equipment) then
				radars = radars + 1
			elseif self:_is_ap_shell(equipment) then
				ap_shells = ap_shells + 1
			end
		end
	end
	if seaplanes >= 1 then
		local attack_power
		if post_cap_attack_power then
			attack_power = post_cap_attack_power
			if attack_power == 0 then
				return false
			end
		else
			local attack_mode
			--assume no pre-cap modifiers
			attack_mode, attack_power = self:day_battle()
			if not attack_mode then
				return false
			end
			--attack_power = math.min(attack_power, 180)
			if attack_power > 180 then
			    attack_power = 180 + math.floor(math.sqrt(attack_power - 180))
			end
			--after cap
		end
		if main_guns >= 2 then
			if ap_shells >= 1 then
				return {{1, attack_power * 1.2}, {5, attack_power * 1.5}}
			elseif secondary_guns >= 1 then
				return {{1, attack_power * 1.2}, {2, attack_power * 1.1}}
			end
			return {{1, attack_power * 1.2}}
		elseif main_guns == 1 and secondary_guns >= 1 then
			if radars >= 1 then
				return {{2, attack_power * 1.1}, {3, attack_power * 1.2}}
			elseif ap_shells >= 1 then
				return {{2, attack_power * 1.1}, {4, attack_power * 1.3}}
			end
			return {{2, attack_power * 1.1}}
		end
	end
	return false
end
 
function ShipCapabilities:format_artillery_spotting(modes)
	if modes then
		local result = {}
		for _, mode in ipairs(modes) do
			local attack_power = tostring(math.floor(mode[2]))
			local attack_mode = mode[1]
			local attack_count = self._artillery_spotting_attack_counts[attack_mode]
			if attack_count then
				attack_power = attack_power .. " " .. attack_count
			end
			table.insert(result, format{self._attack_template, mode = self._artillery_spotting_actions[attack_mode], attack_power = attack_power})
		end
		return Formatting:tooltip(table.concat(result, " / "), "Assuming Parallel Engagement, Line Ahead, and no damage penalty.")
	end
	return "No"
end
 
-- Basic attack power for night battle carrier shelling.
-- Or basic attack power for night battle attack, including night special attack, anti-installation and contact modifiers.
function ShipCapabilities:night_battle(vs_installation, contact)
	local main_guns, secondary_guns, torpedoes, has_planes, has_night_aviation_personnel, firepower, torpedo = 0, 0, 0, false, self._ship:night_aviation_personnel(), self._ship:firepower_leveled(), self._ship:torpedo_leveled()
	if not firepower or not torpedo then
		return nil
	end
	if firepower + torpedo <= 0 then
	    return false
    end
	for i = 1, self._ship:slots_length() or 0 do
		local equipment, size = self._ship:slot(i)
		if equipment then
			local equipment_firepower, equipment_torpedo = equipment:firepower_leveled(true), equipment:torpedo_leveled(true)
			if self:_is_main_gun(equipment) then
				main_guns = main_guns + 1
			elseif self:_is_secondary_gun(equipment) then
				secondary_guns = secondary_guns + 1
			elseif self:_is_torpedo(equipment) then
				torpedoes = torpedoes + 1
			elseif self:_is_bomber(equipment) then
				if size and size > 0 then
					has_planes = true
				else
					equipment_firepower = 0
					equipment_torpedo = 0
				end
			elseif self:_is_night_aviation_personnel(equipment) then
				has_night_aviation_personnel = true
			end
			if equipment_firepower then
				firepower = firepower + equipment_firepower
			end
			if equipment_torpedo then
				torpedo = torpedo + equipment_torpedo
			end
		end
	end
	if contact then
		firepower = firepower + 5
	end
	if self._ship:night_bombing() == false then
	    -- if night bombing is forbidden
		return false
	else
		local anti_installation_modifier = 1
		local anti_installation_bonus = 0
		if vs_installation then
			torpedo = 0
			local anti_installation = self:_anti_installation()
			anti_installation_modifier = anti_installation.type_3_shell_equiped and 2.5 or 1
			anti_installation_bonus = anti_installation.wg_equiped and 75 or 0
		end
		if torpedoes >= 2 and torpedo > 0 then
			if vs_installation then
				return false
			else
				return 7, (firepower + torpedo) * 1.5
			end
		elseif main_guns >= 3 and firepower > 0 then
			return 4, ((firepower + torpedo) * anti_installation_modifier + anti_installation_bonus) * 2
		elseif main_guns >= 2 and secondary_guns >= 1 and firepower > 0 then
			return 5, ((firepower + torpedo) * anti_installation_modifier + anti_installation_bonus) * 1.75
		elseif main_guns >= 1 and torpedoes == 1 and firepower > 0 and torpedo > 0 then
			if vs_installation then
				return false
			else
				return 6, (firepower + torpedo) * 1.3
			end
		elseif main_guns + secondary_guns >= 2 and firepower > 0 then
			return 3, ((firepower + torpedo) * anti_installation_modifier + anti_installation_bonus) * 1.2
		-- WIP: just a hack for enemy CVs, no plane checked, only NF + NTB (120%) supported
		elseif self:_is_carrier(self._ship) and has_night_aviation_personnel then
		    return 9, ((firepower + torpedo) * anti_installation_modifier + anti_installation_bonus) * 1.2
		-- Single Attack, Single Torpedo and Bombing are actually same
		else
			return self:_single_attack_style(), (firepower + torpedo) * anti_installation_modifier + anti_installation_bonus
		end
	end
end
 
function ShipCapabilities:format_night_battle(mode, attack_power)
	if mode then
		attack_power = math.floor(attack_power)
		local multiplier = self._night_battle_attack_counts[mode]
		if multiplier then
			attack_power = tostring(attack_power) .. " " .. multiplier
		end
		return format{self._attack_template, mode = self._night_battle_modes[mode], attack_power = attack_power}
	elseif mode == false then
		return "No Action"
	end
	return "Unknown"
end
 
--- Basic attack power for opening torpedo, including fleet torpedo.
function ShipCapabilities:opening_torpedo(fleet_torpedo)
    fleet_torpedo = fleet_torpedo or 0
    local torpedo = self._ship:torpedo_leveled()
	if self._ship:opening_torpedo() == false or not torpedo or torpedo <= 0 then
		return false
	end
	local is_enemy = not self._ship._hp_max
	local is_enemy_submarine = is_enemy and self:_is_submarine()
	local is_player_submarine = not is_enemy and self:_is_submarine()
    if
        not is_enemy_submarine and self:_find_equipment(Self._is_active_midget_submarine) or
        is_player_submarine and self._ship:level() and self._ship:level() >= 10 or
        is_enemy_submarine and self._ship:suffix() and (self._ship:suffix():match("Elite") or self._ship:suffix():match("Flagship"))
    then
        torpedo = self:_fold_equipment(torpedo, function(equipment, torpedo)
            return torpedo + (equipment:torpedo_leveled() or 0)
        end)
        return 5 + fleet_torpedo + torpedo
    end
    return false
end
 
ShipCapabilities.format_opening_torpedo = ShipCapabilities.format_torpedo
 
-- Basic attack power for ASW attack * sonar w/ depth charge modifier (pre-cap).
function ShipCapabilities:asw_attack()
	local base_asw
	local asw_override, opening, day, night = self._ship:asw_attack(), false, true, true
	if asw_override == false then
		return false
	elseif self:_is_asw_surface_ship() then
		base_asw = 13
	elseif self:_is_asw_aviation_ship() then
		base_asw = 8
		if not self:_is_night_bombing() or self._ship:asw_leveled() == 0 then
			night = false
		end
	else
		return false
	end
	if self._ship._opening_asw then
	    opening = true
    end
	local asw_leveled = self._ship:asw_leveled()
	local ship_asw, equipment_asw, depth_charge, sonar, bomber = (asw_leveled or 0), 0, false, false, false
	for i = 1, self._ship:slots_length() or 0 do
		local equipment, size = self._ship:slot(i)
		if equipment then
			if not self:_is_reconnaissance_seaplane(equipment) then
				if self:_is_sonar(equipment) then
					sonar = true
				elseif self:_is_depth_charge(equipment) then
					depth_charge = true
				elseif self:_is_bomber(equipment) then
					bomber = true
				end
				-- some equipments' asw value is invalid
				if self:_is_damaging_asw_equip(equipment) then
				    equipment_asw = equipment_asw + (equipment:asw_leveled() or 0)
				end 
			end
		end
	end
	if self:_is_asw_aviation_ship() and not bomber then
		return false
	end
	local depth_charge_sonar_boost = 1
	if depth_charge and sonar then
		depth_charge_sonar_boost = 1.15
	end
	return depth_charge_sonar_boost * (base_asw + 1.5 * equipment_asw + 2 * math.sqrt(ship_asw)), opening, day, night, not asw_leveled
end
 
function ShipCapabilities:format_asw_attack(attack_power, opening, day, night, uncertain)
	if attack_power then
		attack_power = math.floor(attack_power)
		local phases = {}
		if opening then
		    table.insert(phases, self._asw_attack_modes.opening)
	    end
		if day then
			table.insert(phases, self._asw_attack_modes.day)
		end
		if night then
			table.insert(phases, self._asw_attack_modes.night)
		end
		if #phases == 1 then
			phases[1] = phases[1] .. " Only"
		end
		if uncertain then
			attack_power = attack_power .. "+"
		end
		return format{self._attack_template, mode = table.concat(phases, "/"), attack_power = attack_power}
	end
	return "No"
end
 
-- Basic attack power for opening airstrike (returns an array with attack values per each bomber).
function ShipCapabilities:opening_airstrike()
	local airstrikes = {}
	for i = 1, self._ship:slots_length() or 0 do
		local equipment, size = self._ship:slot(i)
		if size and size > 0 and equipment and self:_is_bomber(equipment) then
			local equipment_torpedo, equipment_bombing = equipment:torpedo() or 0, equipment:bombing() or 0
			if self:_is_torpedo_bomber(equipment) then
				table.insert(airstrikes, 1.5 * (25 + equipment_torpedo * math.sqrt(size))) -- 0.8 is also possible
			else
				table.insert(airstrikes, 25 + equipment_bombing * math.sqrt(size))
			end
		end
	end
	if #airstrikes > 0 then
		return airstrikes
	end
	return false
end
 
function ShipCapabilities:format_opening_airstrike(attacks)
	if attacks then
		local result = {}
		for _, attack in ipairs(attacks) do
			table.insert(result, tostring(math.floor(attack)))
		end
		return table.concat(result, ",")
	end
	return "No"
end
 
return ShipCapabilities