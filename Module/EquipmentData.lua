local BaseData = require("Module:BaseData")
local Formatting = require('Module:Formatting')
local Equipment
local EquipmentFrom
local EquipmentCompatibility

local EquipmentData = BaseData({
	_strict_translation_class = "strict-translation",
	_common_translation_class = "common-translation",
	_mobile_hide_class = "hidden",
	_display_none_css = {display = "none"},
	_constructor_module = "Module:Equipment",
})

--Returns the name of the equipment as !!HTML!! with appropriate classes to show/hide strict/common translation variants.
--Use this for display purposes.
function EquipmentData:name()
	return self._name
end

--Returns the equipment's strict name translation as a string.
function EquipmentData:strict_name()
	return self._strict_name
end

--Returns the equipment's common name translation as a string.
function EquipmentData:common_name()
	return self._common_name or self:name()
end

--Returns the equipment's name used for assets.
--Use this for internal references.
function EquipmentData:asset_name()
	return self._asset_name or self:common_name()
end

--Returns a tuple for use in Formatting:format_link() to generate a link to this equipment's page.
function EquipmentData:link()
	if self._page then
		return self._page, self:name()
	elseif self._common_name then
	    return self:common_name(), self:name()
	end
	return self:name()
end

--Returns the equipment's id.
function EquipmentData:id()
	return self._id
end

EquipmentData.api_id = EquipmentData.id

--Returns the equipment's localized name, for when the equipment name is translated as romaji.
function EquipmentData:localized_name()
	return self._localized_name
end

--Returns the reading of the equipment's Japanese name.
function EquipmentData:reading()
	return self._reading
end

--Returns the equipment's name in the equipment list.
function EquipmentData:list_name()
	return self._list_name
end

--Returns the equipment's Japanese name in the equipment list.
function EquipmentData:list_japanese_name()
	return self._list_japanese_name
end

--Returns the equipment's localized name in the equipment list.
function EquipmentData:list_localized_name()
	return self._list_localized_name
end

--Returns the reading of the equipment's Japanese name in the equipment list.
function EquipmentData:list_reading()
	return self._list_reading
end

--Returns the equipment's name in the equipment comparison.
function EquipmentData:comparison_name()
	return self._comparison_name
end

--Returns the equipment's Japanese name in the equipment comparison.
function EquipmentData:comparison_japanese_name()
	return self._comparison_japanese_name
end

--Returns the equipment's localized name in the equipment comparison.
function EquipmentData:comparison_localized_name()
	return self._comparison_localized_name
end

--Returns the reading of the equipment's Japanese name in the equipment comparison.
function EquipmentData:comparison_reading()
	return self._comparison_reading
end

--Returns the equipment's name in battle.
function EquipmentData:battle_name()
	return self._battle_name
end

--Returns the equipment's Japanese name in battle.
function EquipmentData:battle_japanese_name()
	return self._battle_japanese_name
end

--Returns the equipment's localized name in battle.
function EquipmentData:battle_localized_name()
	return self._battle_localized_name
end

--Returns the reading of the equipment's Japanese name in battle.
function EquipmentData:battle_reading()
	return self._battle_reading
end

--Returns the equipment's name in the library.
function EquipmentData:library_name()
	return self._library_name
end

--Returns the equipment's Japanese name in the library.
function EquipmentData:library_japanese_name()
	return self._library_japanese_name
end

--Returns the equipment's localized name in the library.
function EquipmentData:library_localized_name()
	return self._library_localized_name
end

--Returns the reading of the equipment's Japanese name in the library.
function EquipmentData:library_reading()
	return self._library_reading
end

--Returns the equipment's name on it's card.
function EquipmentData:card_name()
	return self._card_name
end

--Returns the equipment's Japanese name on it's card.
function EquipmentData:card_japanese_name()
	return self._card_japanese_name
end

--Returns the equipment's localized name on it's card.
function EquipmentData:card_localized_name()
	return self._card_localized_name
end

--Returns the reading of the equipment's Japanese name on it's card.
function EquipmentData:card_reading()
	return self._card_reading
end

--Returns the equipment's Japanese name as a string.
function EquipmentData:japanese_name()
	return self._japanese_name
end

--Returns the equipment's type as an integer according to the KanColle API.
--You can use Formatting:format_equipment_type to convert this to the name of the type.
function EquipmentData:type()
	return self._type
end

function EquipmentData:types()
	return self._types
end

--The level of improvement of the equipment in Akashi's Improvement Arsenal (how many stars it has).
--This is not meant to be defined in equipment data modules.
--Instead, call Equipment("equipment name") to get an EquipmentData object.
--Then, call the equipment data object with _level = n to create an EquipmentData object with that level.
--Example: local equip = Equipment("12.7cm Twin Gun Mount")
--         local improved_equip = equip{_level = 10}
function EquipmentData:level()
    return self._level
end

--The rank of the equipment for aircraft proficiency.
--This should be treated similarly to EquipmentData:level() above.
function EquipmentData:rank()
    return self._rank
end

--The type name shown in the album/library as a string.
function EquipmentData:album_type()
	return self._album_type
end

--The rarity of the equipment as an integer according to the KanColle API.
function EquipmentData:rarity()
	return self._rarity
end

--The amount of stars on the rarity ribbon on the equipment's card as an integer. Defaults to EquipmentData:back().
function EquipmentData:stars()
	return self._stars or self:back()
end

--The rarity of the background of the equipment's card as an integer. Defaults to EquipmentData:rarity().
function EquipmentData:back()
	return self._back or self:rarity()
end

function EquipmentData:card(as_item)
    if self._item or as_item and self._item_id then
        return Formatting:item_card(self:asset_name())
    end
	if self._card then
		return self._card
	elseif self._card_reference then
		Equipment = Equipment or require(self._constructor_module)
		return Equipment(self._card_reference):card()
	end
	local api_id = self:api_id()
	if self._item then
	    return Formatting:equipment_card(false, self:asset_name())
	elseif api_id ~= nil then
		return Formatting:equipment_card(api_id, self:asset_name())
    end
end

function EquipmentData:fairy()
	if self._fairy then
		return self._fairy
	elseif self._fairy_reference then
		Equipment = Equipment or require(self._constructor_module)
		return Equipment(self._fairy_reference):fairy()
	end
	local api_id = self:api_id()
	if api_id then
		return Formatting:equipment_fairy(api_id, self:asset_name())
	end
	return self._fairy
end

function EquipmentData:cg()
	if self._cg then
		return self._cg
	elseif self._cg_reference then
		Equipment = Equipment or require(self._constructor_module)
		return Equipment(self._cg_reference):cg()
	end
	local api_id = self:api_id()
	if api_id then
    	if api_id > 500 then
    	    local equipment_type = self:type()
    	    if equipment_type < 6 
    	        or (equipment_type > 11 and equipment_type ~= 25 and equipment_type ~= 26 and equipment_type ~= 41
    	        and equipment_type ~= 45 and equipment_type ~= 47 and equipment_type ~= 48 and equipment_type ~= 94) then
    		    Equipment = Equipment or require(self._constructor_module)
    		    EquipmentFrom = EquipmentFrom or require("Module:Collection/EquipmentByApiId")
    		    return Equipment(EquipmentFrom[api_id - 500]):cg()
    		end
    	end
		return Formatting:equipment_cg(api_id, self:asset_name())
	end
	return self._cg
end

function EquipmentData:cg_fairy()
	if self._cg_fairy then
		return self._cg_fairy
	elseif self._cg_fairy_reference then
		Equipment = Equipment or require(self._constructor_module)
		return Equipment(self._cg_fairy_reference):cg_fairy()
	end
	local api_id = self:api_id()
	if api_id then
		return Formatting:equipment_full(api_id, self:asset_name())
	end
	return self._cg_fairy
end

--for enemy aircraft
function EquipmentData:cg_flying()
	return self._cg_flying
end

function EquipmentData:icon(as_item)
    if self._item or as_item and self._item_id then
        return Formatting:item_icon(self:asset_name())
    end
    if self._icon or self._icon == false then
        return self._icon
    else
        return Formatting:equipment_image('Icon', false, self:asset_name())
    end
end

function EquipmentData:firepower()
	return self._firepower
end

function EquipmentData:firepower_leveled(night_battle)
	if not self._level or self._level == 0 then
		return self._firepower
	end
	local night_battle_coeffs = { [1] = 1, [2] = 1, [3] = 1, [4] = 1, [19] = 1, [29] = 1, [36] = 1 }
	local day_battle_coeffs = { [1] = 1, [2] = 1, [3] = 1.5, [4] = 1, [14] = 0.75, [15] = 0.75, [19] = 1, [21] = 1, [29] = 1, [36] = 1 }
	local coeff = nil
	if night_battle then
		coeff = night_battle_coeffs[self._type]
	else
		coeff = day_battle_coeffs[self._type]
	end
	return coeff and (self._firepower or 0) + coeff * math.sqrt(self._level) or self._firepower
end

function EquipmentData:bombing()
	return self._bombing
end

function EquipmentData:torpedo()
	return self._torpedo
end

function EquipmentData:torpedo_leveled(night_battle)
	if not self._level or self._level == 0 then
		return self._torpedo
	end
	local night_battle_coeffs = { [5] = 1 }
	local day_battle_coeffs = { [5] = 1.2, [21] = 1.2 }
	local coeff = nil
	if night_battle then
		coeff = night_battle_coeffs[self._type]
	else
		coeff = day_battle_coeffs[self._type]
	end
	return coeff and (self._torpedo or 0) + coeff * math.sqrt(self._level) or self._torpedo
end

function EquipmentData:aa()
	return self._aa
end

function EquipmentData:armor()
	return self._armor
end

function EquipmentData:asw()
	return self._asw
end

function EquipmentData:asw_leveled()
	if not self._level or self._level == 0 then
		return self._asw
	end
	local coeffs = { [14] = 0.75, [15] = 0.75 }
	local coeff = coeffs[self._type]
	return coeff and (self._asw or 0) + coeff * math.sqrt(self._level) or self._asw
end

function EquipmentData:shelling_accuracy()
	return self._shelling_accuracy
end

function EquipmentData:torpedo_accuracy()
	return self._torpedo_accuracy
end

function EquipmentData:evasion()
	return self._evasion
end

function EquipmentData:los()
	return self._los
end

function EquipmentData:speed()
	return self._speed
end

function EquipmentData:luck()
	return self._luck
end

function EquipmentData:range()
	return self._range
end

function EquipmentData:combat_radius()
	return self._combat_radius or self._flight_range
end

function EquipmentData:deployment_cost()
	return {fuel = false, ammo = false, steel = false, bauxite = self._deployment_cost or self._flight_cost, devmat = false, conmat = false, screw = false}
end

EquipmentData.flight_range = EquipmentData.combat_radius
EquipmentData.flight_cost = EquipmentData.deployment_cost

function EquipmentData:is_lbas_plane()
	local eq_type = self:type()
	return eq_type == 6 -- Carrier-based Fighter Aircraft
		or eq_type == 7 -- Carrier-based Dive Bomber
		or eq_type == 8 -- Carrier-based Torpedo Bomber
		or eq_type == 9 -- Carrier-based Reconnaissance Aircraft
		or eq_type == 10 -- Reconnaissance Seaplane
		or eq_type == 11 -- Seaplane Bomber
		or eq_type == 41 -- Large Flying Boat
		or eq_type == 45 -- Seaplane Fighter
		or eq_type == 47 -- Land-based Attack Aircraft
		or eq_type == 48 -- Land-based Fighter
		or eq_type == 49 -- Land-based Reconnaissance Aircraft
		or eq_type == 56 -- Jet-powered Fighter Aircraft
		or eq_type == 57 -- Jet-powered Fighter-Bomber
		or eq_type == 58 -- Jet-powered Attack Aircraft
		or eq_type == 59 -- Jet-powered Recon Aircraft
		or eq_type == 94 -- Carrier-based Reconnaissance Aircraft (II)
end

function EquipmentData:is_lbas_ha_bomber()
    return self:id() >= 501 and self:type() == 7 and self:range() == 4
end

function EquipmentData:is_lbas_attack_aircraft()
    return self:type() == 47 or self:type() == 53
end

function EquipmentData:is_large_caliber_main_gun()
	local eq_type = self:type()
	return eq_type == 3 -- Large Caliber Main Gun
		or eq_type == 38 -- Large Caliber Main Gun (II)
end

function EquipmentData:is_aafd()
	return self:aa() and self:aa() >= 8
end

function EquipmentData:is_not_aafd()
	return not (self:is_aafd())
end

function EquipmentData:is_carrier_based_reconnaissance_aircraft()
	local eq_type = self:type()
	return eq_type == 9 -- Carrier-based Reconnaissance Aircraft
		or eq_type == 94 -- Carrier-based Reconnaissance Aircraft (II)
end

function EquipmentData:is_torpedo()
	local eq_type = self:type()
	return eq_type == 5 -- Torpedo
		or eq_type == 32 -- Submarine Torpedo
end

function EquipmentData:is_radar()
	local eq_type = self:type()
	return eq_type == 12 -- Small Radar
		or eq_type == 13 -- Large Radar
		or eq_type == 93 -- Large Radar (II)
end

function EquipmentData:is_sonar()
	local eq_type = self:type()
	return eq_type == 14 -- Sonar
		or eq_type == 40 -- Large Sonar
end

function EquipmentData:is_asw_aircraft()
	local eq_type = self:type()
	return eq_type == 25 -- Autogyro
		or eq_type == 26 -- Anti-submarine Patrol Aircraft
end

function EquipmentData:is_extra_armor()
	local eq_type = self:type()
	return eq_type == 16 -- Extra Armor
		or eq_type == 27 -- Extra Armor (Medium)
		or eq_type == 28 -- Extra Armor (Large)
end

function EquipmentData:scrap()
	return {fuel = self._scrap_fuel, ammo = self._scrap_ammo, steel = self._scrap_steel, bauxite = self._scrap_bauxite, devmat = false, conmat = false, screw = false}
end

function EquipmentData:info()
	  return self._info
end

function EquipmentData:wikipedia()
	  return self._wikipedia
end

function EquipmentData:buildable()
	  return self._buildable
end

function EquipmentData:improvable()
	  return self._improvements and true or false
end

function EquipmentData:improvement_products()
	if self._products_keys ~= nil then
		return self._products_keys
	end
	if self._improvements and self._improvements._products then
		self._products_keys = {}
		for key, _ in pairs(self._improvements._products) do
			if key ~= false then
				table.insert(self._products_keys, key)
			end
		end
		table.sort(self._products_keys)
		if self._improvements._products[false] then
			table.insert(self._products_keys, 1, false)
		end
		return self._products_keys
	else
		self._products_keys = false
	end
end

function EquipmentData:improvement_brackets(product)
	if self._improvements and self._improvements._products then
		if self._brackets == nil then
			self._brackets = {}
		end
		if not self._brackets[product] and self._improvements._products[product] then
			self._brackets[product] = {}
			for bracket, _ in pairs(self._improvements._products[product]) do
				if type(bracket) == "number" then
					table.insert(self._brackets[product], bracket)
				end
			end
			table.sort(self._brackets[product])
		end
		return self._brackets[product]
	end
end

function EquipmentData:improvement_product_initial_level(product)
	if self._improvements and self._improvements._products and self._improvements._products[product] then
		return self._improvements._products[product]._stars
	end
end

function EquipmentData:improvement_ships(product)
	if self._improvements and self._improvements._products then
		if self._ships_keys == nil then
			self._ships_keys = {}
		end
		if not self._ships_keys[product] and self._improvements._products[product] then
			self._ships_keys[product] = {}
			for ship, _ in pairs(self._improvements._products[product]._ships) do
				if type(ship) == "string" then
					table.insert(self._ships_keys[product], ship)
				end
			end
			table.sort(self._ships_keys[product])
			if self._improvements._products[product]._ships[true] then
				table.insert(self._ships_keys[product], 1, true)
			elseif self._improvements._products[product]._ships[false] then
				table.insert(self._ships_keys[product], 1, false)
			end
		end
		return self._ships_keys[product]
	end
end

function EquipmentData:improvement_resources(slider, product, stars)
	if self._improvements then
		if not stars then
			return {
				fuel = self._improvements._fuel,
				ammo = self._improvements._ammo,
				steel = self._improvements._steel,
				bauxite = self._improvements._bauxite,
				devmat = false,
				conmat = false,
				screw = false,
			}
		end
		if self._improvements._products and self._improvements._products[product] then
			local product_info = self._improvements._products[product]
			if product_info[stars] then
			    if slider then
				    return {
					    devmat = product_info[stars]._development_material_x,
					    screw = product_info[stars]._improvement_material_x,
					    equipment = product_info[stars]._equipment,
				    }
				else
				    return {
				    	devmat = product_info[stars]._development_material,
				    	screw = product_info[stars]._improvement_material,
				    	equipment = product_info[stars]._equipment,
				    }
				end
			end
		end
	end
end

function EquipmentData:improvement_availability(product, ship)
	if self._improvements and self._improvements._products and self._improvements._products[product] then
		return self._improvements._products[product]._ships[ship]
	end
end

function EquipmentData:improvement_from()
	return self._improvement_from
end

function EquipmentData:special()
	return self._special
end

function EquipmentData:gun_fit_group()
	return self._gun_fit_group
end

function EquipmentData:equippable(ship_type)
	self:_load_compatibility()
	local equipment_type = self:type()
	local name = self:name()
	if not ship_type then
		local result = {}
		for ship_type, compatibility_table in pairs(EquipmentCompatibility) do
			result[ship_type] = compatibility_table[name] or compatibility_table[equipment_type] or 0
		end
		return result
	else
		local compatibility_table = EquipmentCompatibility[ship_type]
		if compatibility_table then
			local compatibility = compatibility_table[name] or compatibility_table[equipment_type] or 0
			if type(compatibility) ~= "table" then
				return compatibility
			else
				return compatibility.value, compatibility.note
			end
		end
	end
end

function EquipmentData:_load_compatibility()
	if not EquipmentCompatibility then
		EquipmentCompatibility = mw.loadData('Module:EquipmentCompatibility')
	end
end

function EquipmentData:create(equip)
	equip = equip or {}
	setmetatable(equip, equip)
	equip.__index = self
	equip.__call = self.__call
	if equip._strict_name then
		equip._common_name = equip._name
		equip._name = tostring(mw.html.create('span'):addClass(self._mobile_hide_class):addClass(self._strict_translation_class):css(self._display_none_css):wikitext(equip._strict_name))
			 .. tostring(mw.html.create('span'):addClass(self._common_translation_class):wikitext(equip._common_name))
		if not equip._page then
			equip._page = equip._common_name
		end
	end
	if equip._localized_strict_name and equip._localized_name then
		equip._localized_common_name = equip._localized_name
		equip._localized_name = tostring(mw.html.create('span'):addClass(self._mobile_hide_class):addClass(self._strict_translation_class):css(self._display_none_css):wikitext(equip._localized_strict_name))
			 .. tostring(mw.html.create('span'):addClass(self._common_translation_class):wikitext(equip._localized_common_name))
	end
	if equip._list_strict_name and equip._list_name then
		equip._list_common_name = equip._list_name
		equip._list_name = tostring(mw.html.create('span'):addClass(self._mobile_hide_class):addClass(self._strict_translation_class):css(self._display_none_css):wikitext(equip._list_strict_name))
			 .. tostring(mw.html.create('span'):addClass(self._common_translation_class):wikitext(equip._list_common_name))
	end
	if equip._list_localized_strict_name and equip._list_localized_name then
		equip._list_localized_common_name = equip._list_localized_name
		equip._list_localized_name = tostring(mw.html.create('span'):addClass(self._mobile_hide_class):addClass(self._strict_translation_class):css(self._display_none_css):wikitext(equip._list_localized_strict_name))
			 .. tostring(mw.html.create('span'):addClass(self._common_translation_class):wikitext(equip._list_localized_common_name))
	end
	if equip._comparison_strict_name and equip._comparison_name then
		equip._comparison_common_name = equip._comparison_name
		equip._comparison_name = tostring(mw.html.create('span'):addClass(self._mobile_hide_class):addClass(self._strict_translation_class):css(self._display_none_css):wikitext(equip._comparison_strict_name))
			 .. tostring(mw.html.create('span'):addClass(self._common_translation_class):wikitext(equip._comparison_common_name))
	end
	if equip._comparison_localized_strict_name and equip._comparison_localized_name then
		equip._comparison_localized_common_name = equip._comparison_localized_name
		equip._comparison_localized_name = tostring(mw.html.create('span'):addClass(self._mobile_hide_class):addClass(self._strict_translation_class):css(self._display_none_css):wikitext(equip._comparison_localized_strict_name))
			 .. tostring(mw.html.create('span'):addClass(self._common_translation_class):wikitext(equip._comparison_localized_common_name))
	end
	if equip._library_strict_name and equip._library_name then
		equip._library_common_name = equip._library_name
		equip._library_name = tostring(mw.html.create('span'):addClass(self._mobile_hide_class):addClass(self._strict_translation_class):css(self._display_none_css):wikitext(equip._library_strict_name))
			 .. tostring(mw.html.create('span'):addClass(self._common_translation_class):wikitext(equip._library_common_name))
	end
	if equip._library_localized_strict_name and equip._library_localized_name then
		equip._library_localized_common_name = equip._library_localized_name
		equip._library_localized_name = tostring(mw.html.create('span'):addClass(self._mobile_hide_class):addClass(self._strict_translation_class):css(self._display_none_css):wikitext(equip._library_localized_strict_name))
			 .. tostring(mw.html.create('span'):addClass(self._common_translation_class):wikitext(equip._library_localized_common_name))
	end
	if equip._card_strict_name and equip._card_name then
		equip._card_common_name = equip._card_name
		equip._card_name = tostring(mw.html.create('span'):addClass(self._mobile_hide_class):addClass(self._strict_translation_class):css(self._display_none_css):wikitext(equip._card_strict_name))
			 .. tostring(mw.html.create('span'):addClass(self._common_translation_class):wikitext(equip._card_common_name))
	end
	if equip._card_localized_strict_name and equip._card_localized_name then
		equip._card_localized_common_name = equip._card_localized_name
		equip._card_localized_name = tostring(mw.html.create('span'):addClass(self._mobile_hide_class):addClass(self._strict_translation_class):css(self._display_none_css):wikitext(equip._card_localized_strict_name))
			 .. tostring(mw.html.create('span'):addClass(self._common_translation_class):wikitext(equip._card_localized_common_name))
	end
	return equip
end

EquipmentData.__call = EquipmentData.create

return EquipmentData