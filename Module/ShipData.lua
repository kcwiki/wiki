local Equipment
local Formatting = require('Module:Formatting')
local Ship
local ShipClass = require('Module:ShipClass')

local BaseData = require("Module:BaseData")
local ShipData = BaseData{
	_constructor_module = "Module:Ship",
}

--Return the full name of the ship.
function ShipData:name(sep)
    sep = sep or " "
	local suffix = self:display_suffix()
	if suffix and suffix ~= "" then
		return self:base_name() .. sep .. suffix
	else
		return self:base_name()
	end
end

--Return the unique name of the ship.
--Differs from name() for some boss enemies that have a legacy role suffix,
--which isn't shown for unique_name().
function ShipData:unique_name(sep)
    sep = sep or " "
	local suffix = self:suffix()
	if suffix and suffix ~= "" then
		return self:base_name() .. sep .. self:suffix()
	else
		return self:base_name()
	end
end

--Return the name of the module containing this ship.
--Note: This is pretty iffy. Try not to use it, it's badly defined.
function ShipData:module_name()
	if self._module_name then
		return self._module_name
	end
	return self:base_name()
end

function ShipData:lua_name()
	local key = self._key
	if key and key ~= "" then
		return self:base_name() .. "/" .. key
	else
		return self:base_name()
	end
end

--The base name of the ship.
function ShipData:base_name()
	return self._name
end

--The suffix of the ship. Does not include legacy role suffixes.
function ShipData:suffix()
	return self._suffix
end

--The suffix of the ship. Includes legacy role suffixes.
function ShipData:display_suffix()
	if self._display_suffix ~= nil then
		return self._display_suffix
	end
	return self._suffix
end

--A group of values passable to Formatting:format_link() to create a wikitext link to this ship.
function ShipData:link()
	if self._page then
		return self._page, self:unique_name()
	elseif self._seasonal then
	    return self:base_link()
    elseif self._vita then
        return string.format('KanColle Kai:%s', self:base_link()), self:unique_name()
    else
		return self:unique_name()
	end
end

--A group of values passable to Formatting:format_link() to create a wikitext link to the base page of this ship.
--E.g. Shigure instead of Shigure Kai Ni.
function ShipData:base_link()
	if self._page then
		return self._page, self:name()
	else
		return self:base_name(), self:name()
	end
end

function ShipData:localized_name()
	return self._localized_name
end

function ShipData:nick()
	return self._nick
end

function ShipData:japanese_name()
	return self._japanese_name
end

function ShipData:japanese_nick()
	return self._japanese_nick
end

function ShipData:reading()
	return self._reading
end

function ShipData:reading_nick()
	return self._reading_nick
end

function ShipData:wikipedia()
	return self._wikipedia
end

function ShipData:id()
	return self._id
end

function ShipData:api_id()
	return self._api_id
end

function ShipData:true_id()
	return self._true_id
end

function ShipData:rarity()
	return self._rarity
end

function ShipData:back()
	return self._back or self:rarity()
end

function ShipData:overlay()
	return self._overlay
end

function ShipData:class()
	return self._class
end

function ShipData:class_number()
	return self._class_number
end

function ShipData:type()
	return self._type
end

function ShipData:is_installation()
	return self._installation
end

function ShipData:is_pillbox()
	return self._pillbox
end

function ShipData:simple_naming()
	return self._simple_naming
end

function ShipData:card(hd)
	if self._card ~= nil then
		return self._card
	elseif self._card_reference then
		Ship = Ship or require(self._constructor_module)
		return Ship:create_from_reference(self._card_reference, self):card(hd)
	end
	local api_id, simple_naming = self:api_id(), self:simple_naming()
	if not api_id and not self:type() then
	    return Formatting:ship_card(nil, self:unique_name(), nil, self._card_extension, true, hd)
	elseif api_id or simple_naming then
		return Formatting:ship_card(api_id, self:unique_name(), self:type(), self._card_extension, simple_naming, hd)
	end
end

function ShipData:card_damaged(hd)
	if self._card_damaged ~= nil then
		return self._card_damaged
	elseif self._card_damaged_reference then
		Ship = Ship or require(self._constructor_module)
		return Ship:create_from_reference(self._card_damaged_reference, self):card_damaged(hd)
	end
	local api_id, simple_naming = self:api_id(), self:simple_naming()
	if not api_id and not self:type() then
	    return Formatting:ship_card_damaged(nil, self:unique_name(), nil, self._card_damaged_extension, true, hd)
	elseif api_id or simple_naming then
		return Formatting:ship_card_damaged(api_id, self:unique_name(), self:type(), self._card_damaged_extension, simple_naming, hd)
	end
end

function ShipData:battle_card(hd)
	if self._battle_card ~= nil then
		return self._battle_card
	elseif self._battle_card_reference then
		Ship = Ship or require(self._constructor_module)
		return Ship:create_from_reference(self._battle_card_reference, self):battle_card(hd)
	end
	api_id = self:api_id()
	if api_id or hd then
		return Formatting:ship_battle_card(api_id, self:unique_name(), self:type(), self._battle_card_extension, false, hd)
	end
	return self._battle_card
end

function ShipData:battle_card_layers()
	return self._battle_card_layers
end

function ShipData:battle_card_damaged(hd)
	if self._battle_card_damaged ~= nil then
		return self._battle_card_damaged
	elseif self._battle_card_damaged_reference then
		Ship = Ship or require(self._constructor_module)
		return Ship:create_from_reference(self._battle_card_damaged_reference, self):battle_card_damaged(hd)
	end
	api_id = self:api_id()
	if api_id or hd then
	    if self._can_debuff and api_id > 1500 then
            return string.format("Enemy Banner %s Debuffed.png", self:unique_name():gsub("- Damaged", "Damaged"))
        end
		return Formatting:ship_battle_card_damaged(api_id, self:unique_name(), self:type(), self._battle_card_damaged_extension, false, hd)
	end
	return self._battle_card_damaged
end

function ShipData:cg(hd)
	if self._cg ~= nil then
		return self._cg
	elseif self._cg_reference then
		Ship = Ship or require(self._constructor_module)
		return Ship:create_from_reference(self._cg_reference, self):cg(hd)
	else
	    local api_id, simple_naming = self:api_id(), self:simple_naming()
	    if not api_id and not self:type() then
	        return Formatting:ship_cg(nil, self:unique_name(), nil, self._cg_extension, true, hd)
	    elseif api_id or simple_naming then
		    return Formatting:ship_cg(api_id, self:unique_name(), self:type(), self._cg_extension, simple_naming, hd)
	    end
    end
end

function ShipData:cg_damaged(hd)
	if self._cg_damaged ~= nil then
		return self._cg_damaged
	elseif self._cg_damaged_reference then
		Ship = Ship or require(self._constructor_module)
		return Ship:create_from_reference(self._cg_damaged_reference, self):cg_damaged(hd)
	else
	    local api_id, simple_naming = self:api_id(), self:simple_naming()
	    if not api_id and not self:type() then
	        return Formatting:ship_cg_damaged(nil, self:unique_name(), nil, self._cg_damaged_extension, true, hd)
	    elseif api_id or simple_naming then
	        if self._can_debuff and api_id > 1500 then
                return string.format("Enemy Full %s Debuffed.png", self:unique_name():gsub("- Damaged", "Damaged"))
	        end
		    return Formatting:ship_cg_damaged(api_id, self:unique_name(), self:type(), self._cg_damaged_extension, simple_naming, hd)
	    end
	end
end

function ShipData:accuracy()
	return self._accuracy
end

function ShipData:morale()
	return self._morale
end

function ShipData:level()
	return self._level
end

function ShipData:hp()
	return self._hp
end

function ShipData:hp_max()
	return self._hp_max
end

function ShipData:hp_mod()
    local hp = self:hp()
    local hp_max = self:hp_max()
    return hp and hp_max and math.min(2, hp_max - hp)
end

function ShipData:hp_mod_married()
    local hp = self:hp_married()
    local hp_max = self:hp_max()
    return hp and hp_max and math.min(2, hp_max - hp)
end

-- min(hp_max, hp + [4, 4, 4, 5, 6, 7, 7, 8, 8, 9][Math.floor(hp / 10)])
function ShipData:hp_married()
	local bonuses = {
		[0] = 4,
		[1] = 4,
		[2] = 4,
		[3] = 5,
		[4] = 6,
		[5] = 7,
		[6] = 7,
		[7] = 8,
		[8] = 8,
		[9] = 9,
	}
    local exceptions = {
		[131] = true, -- Yamato
		[143] = true, -- Musashi
		[163] = true, -- Maruyu
		-- [402] = true, -- Maruyu Kai (is +4, 7 -> 11)
		[171] = true, -- Bismarck
		[172] = true, -- Bismarck Kai
		[173] = true, -- Bismarck zwei
		[178] = true, -- Bismarck drei
		[275] = true, -- Nagato Kai
		[276] = true, -- Mutsu Kai
		[352] = true, -- Hayasui Kai
		[441] = true, -- Littorio
		[442] = true, -- Roma
		[446] = true, -- Italia
		[447] = true, -- Roma Kai
		[541] = true, -- Nagato Kai Ni
	}
	local hp = self:hp()
	local hp_max = self:hp_max()
	if not hp or not hp_max then
		return nil
	end
	-- not using exceptions should work as well
	if exceptions[self:api_id()] then
		return hp_max
	else
		local bonus = bonuses[math.floor(hp / 10)]
		if bonus then
			return math.min(hp_max, hp + bonus)
		else
			return nil
		end
	end
end

function ShipData:firepower()
	return self._firepower
end

function ShipData:firepower_max()
	return self._firepower_max
end

function ShipData:firepower_leveled()
	if self._firepower_leveled then
		return self._firepower_leveled
	end
	return self:firepower_max()
end

function ShipData:torpedo()
	return self._torpedo
end

function ShipData:torpedo_max()
	return self._torpedo_max
end

function ShipData:torpedo_leveled()
	if self._torpedo_leveled then
		return self._torpedo_leveled
	end
	return self:torpedo_max()
end

function ShipData:aa()
	return self._aa
end

function ShipData:aa_max()
	return self._aa_max
end

function ShipData:aa_leveled()
	if self._aa_leveled then
		return self._aa_leveled
	end
	return self:aa_max()
end

function ShipData:armor()
	return self._armor
end

function ShipData:armor_max()
	return self._armor_max
end

function ShipData:armor_leveled()
	if self._armor_leveled then
		return self._armor_leveled
	end
	return self:armor_max()
end

function ShipData:asw()
	return self._asw
end

function ShipData:asw_max()
	return self._asw_max
end

function ShipData:asw_leveled(level)
	if not level and self._level then
		level = self._level
	end
	if level then
		local asw = self:asw()
		if asw then
			return math.floor(((self:asw_max() or asw) - asw) * level / 99 + asw)
		end
	end
	return self:asw_max()
end

function ShipData:evasion()
	return self._evasion
end

function ShipData:evasion_max()
	return self._evasion_max
end

function ShipData:evasion_leveled(level)
	if not level and self._level then
		level = self._level
	end
	if level then
		local evasion = self:evasion()
		if evasion then
			return math.floor(((self:evasion_max() or evasion) - evasion) * level / 99 + evasion)
		end
	end
	return self:evasion_max()
end

function ShipData:los()
	return self._los
end

function ShipData:los_max()
	return self._los_max
end

function ShipData:los_leveled(level)
	if not level and self._level then
		level = self._level
	end
	if level then
		local los = self:los()
		if los then
			return math.floor(((self:los_max() or los) - los) * level / 99 + los)
		end
	end
	return self:los_max()
end

function ShipData:luck()
	return self._luck
end

function ShipData:luck_max()
	return self._luck_max
end

function ShipData:luck_leveled()
	if self._luck_leveled then
		return self._luck_leveled
	end
	return self:luck()
end

function ShipData:buildable()
	return self._buildable
end

function ShipData:buildable_lsc()
	return self._buildable_lsc
end

function ShipData:build_time()
	return self._build_time
end

function ShipData:remodel_from()
	return self._remodel_from
end

function ShipData:remodel_to()
	return self._remodel_to
end

function ShipData:remodel_level()
	return self._remodel_level
end

function ShipData:remodel_cost()
	return {
	    fuel = false,
	    ammo = self._remodel_ammo,
	    steel = self._remodel_steel,
	    bauxite = false,
	    devmat = self._remodel_development_material,
	    conmat = self._remodel_construction_material or false,
	    screw = false
    }
end

function ShipData:remodel_blueprint()
	return self._remodel_blueprint
end

function ShipData:remodel_catapult()
	return self._remodel_catapult
end

function ShipData:remodel_report()
	return self._remodel_report
end

function ShipData:remodel_gunmat()
	return self._remodel_gunmat
end

function ShipData:remodel_airmat()
	return self._remodel_airmat
end

function ShipData:remodel_armament()
	return self._remodel_armament
end

function ShipData:remodel_development_material()
	return self._remodel_development_material
end

function ShipData:remodel_construction_material()
	return self._remodel_construction_material
end

function ShipData:remodel_to_level()
	return self._remodel_to_level
end

function ShipData:remodel_to_cost()
	return {
	    fuel = false,
	    ammo = self._remodel_to_ammo,
	    steel = self._remodel_to_steel,
	    bauxite = false,
	    devmat = self._remodel_to_development_material,
	    conmat = self._remodel_to_construction_material or false,
	    screw = false
    }
end

function ShipData:remodel_to_blueprint()
	return self._remodel_to_blueprint
end

function ShipData:remodel_to_catapult()
	return self._remodel_to_catapult
end

function ShipData:remodel_to_report()
	return self._remodel_to_report
end

function ShipData:remodel_to_gunmat()
	return self._remodel_to_gunmat
end

function ShipData:remodel_to_airmat()
	return self._remodel_to_airmat
end

function ShipData:modernization()
	return {firepower = self._firepower_mod, torpedo = self._torpedo_mod, aa = self._aa_mod, armor = self._armor_mod, luck = self._luck_mod}
end

function ShipData:scrap()
	return {fuel = self._scrap_fuel, ammo = self._scrap_ammo, steel = self._scrap_steel, bauxite = self._scrap_baux, devmat = false, conmat = false, screw = false}
end

function ShipData:fuel()
	return self._fuel
end

function ShipData:ammo()
	return self._ammo
end

function ShipData:slot_space(slot)
	if self._equipment then
		local equipment_slot = self._equipment[slot]
		if equipment_slot then
			return equipment_slot.size, equipment_slot.estimation
		end
	end
	return nil
end

function ShipData:slot(slot)
	if self._equipment then
		local equipment_slot = self._equipment[slot]
		if equipment_slot then
			if type(equipment_slot.equipment) == "string" then
				self:_prepare_Equipment()
				equipment_slot.equipment = Equipment(equipment_slot.equipment, self._enemy)
			end
			return equipment_slot.equipment, equipment_slot.size, equipment_slot.estimation, equipment_slot.stars
		end
	end
	return nil
end

function ShipData:slots()
	return self._slots or self:slots_length()
end

function ShipData:slots_length()
	if self._equipment then
		return #self._equipment
	end
	return nil
end

function ShipData:total_space()
	if not self._equipment then
		return nil
	end
	local total_space = 0
	local size
	for _, v in ipairs(self._equipment) do
		size = v.size
		if size == nil then
			total_space = nil
			break
		elseif size == false then
		else
			total_space = total_space + size
		end
	end
	return total_space
end

function ShipData:speed()
	return self._speed
end

function ShipData:range()
	return self._range
end

function ShipData:equipment_armor()
    local armor = 0
    for i = 1, self:slots_length() or 0 do
        local equipment = self:slot(i)
        if equipment then
            armor = armor + (equipment:armor() or 0)
        end
    end
    return armor
end

function ShipData:air_power(count_recons)
    if self._air_power then
        return self._air_power
    end
    local air_power = 0
    local slots_length = self:slots_length()
    if not slots_length then
        air_power = self._as_rating
    end
    for i = 1, slots_length or 0 do
        local slot_equipment, slot_space = self:slot(i)
        if slot_equipment == nil or slot_space == nil then
            --we have missing information, fall back to hard-coded air power
            air_power = self._as_rating
            break
        elseif slot_equipment ~= false then
            --if there is an equipment
            local slot_equipment_type = slot_equipment:type()
            local slot_equipment_aa = slot_equipment:aa()
            if slot_equipment_aa and
               (slot_equipment_type == 6 or 
                slot_equipment_type == 7 or 
                slot_equipment_type == 8 or 
                slot_equipment_type == 11 or
                slot_equipment_type == 47 or
                count_recons and slot_equipment_type == 10) then
                air_power = air_power + 
                   math.floor(math.sqrt(slot_space) * slot_equipment_aa)
            elseif slot_equipment_aa == nil then
            --we have missing information, fall back to hard-coded air power
                air_power = self._as_rating
                break
            end
        end
    end
    return air_power
end

function ShipData:has_lbas_ha_bomber()
    for i = 1, self:slots_length() or 0 do
        local equipment = self:slot(i)
        if equipment and equipment:is_lbas_ha_bomber() then
            return true
        end
    end
    return false
end

function ShipData:air_power_estimation(count_recons)
    return self._air_power_estimation
end

function ShipData:gun_fit_properties(fit_group)
	if not self._gun_fit_properties then
		return nil
	else
		return self._gun_fit_properties[fit_group]
	end
end

function ShipData:night_bombing()
	return self._night_bombing
end

function ShipData:night_aviation_personnel()
	return self._night_aviation_personnel
end

function ShipData:opening_torpedo()
	return self._opening_torpedo
end

function ShipData:asw_attack()
	return self._asw_attack
end

function ShipData:seasonal()
	return self._seasonal
end

--The voice actor for this ship. A string, or nil if unknown.
--EXPERIMENTAL, DO NOT USE. Spec for this feature may rapidly change.
function ShipData:voice_actor()
	if self._voice_actor ~= nil then
		return self._voice_actor
	elseif self._voice_actor_reference or self:remodel_from() then
		Ship = Ship or require(self._constructor_module)
		return Ship:create_from_reference(self._voice_actor_reference or self:remodel_from(), self):voice_actor()
	end
    return self._voice_actor
end

--The artist for this ship. A string, or nil if unknown.
--EXPERIMENTAL, DO NOT USE. Spec for this feature may rapidly change.
function ShipData:artist()
	if self._artist ~= nil then
		return self._artist
	elseif self._artist_reference or self:remodel_from() then
		Ship = Ship or require(self._constructor_module)
		return Ship:create_from_reference(self._artist_reference or self:remodel_from(), self):artist()
	end
    return self._artist
end

--The availability for this ship.
--false = not available.
--nil = unknown.
--Otherwise a table with obtainment methods under numeric keys and optional detailed data under the obtainment method key.
--E.g. {"drop", "event_reward", "event_drop", 
--      drop = {{1/*world*/, 4/*map*/, "B"/*node*/, 3/*formation (optional)*/}, {3, 2, "A"}},
--      event_reward = {{2016/*year*/, 4/*1 = winter, 4 = spring, 7 = summer, 10 = fall*/, 5/*map*/}},
--      event_drop = {{2016, 4, 7, "N"}}}
--EXPERIMENTAL, DO NOT USE. Spec for this feature may rapidly change.
function ShipData:availability()
    if self:remodel_from() then
		Ship = Ship or require(self._constructor_module)
		return Ship:create_from_reference(self:remodel_from(), self):availability()
	else
	    return self._availability
	end
end

--The implementation date for this ship. A 3-tuple of year, month, day (JST) as a table, or nil if unknown.
--EXPERIMENTAL, DO NOT USE. Spec for this feature may rapidly change.
function ShipData:implementation_date()
	if self._implementation_date ~= nil then
		return self._implementation_date
	elseif self._implementation_date_reference or self:remodel_from() then
		Ship = Ship or require(self._constructor_module)
		return Ship:create_from_reference(self._implementation_date_reference or self:remodel_from(), self):implementation_date()
	end
    return self._implementation_date
end

function ShipData:_prepare_Equipment()
	if not Equipment then
		Equipment = require('Module:Equipment')
	end
end

function ShipData:create(ship)
	ship = ship or {}
	-- apparently wikia (mediawiki?) can have shared state between invokes
	if type(ship._class) == 'string' then
		ship._class = ShipClass(ship._class)
	end
	setmetatable(ship, ship)
	ship.__index = self
	ship.__call = self.__call
	return ship
end

return ShipData