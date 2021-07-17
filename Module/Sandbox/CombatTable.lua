
local format = require('Module:Core').format
local Formatting = require('Module:Formatting')
local StatIcons = require('Module:Data/Asset')
local Ship = require('Module:Ship')
local Combat = require('Module:Sandbox/Combat')

local setups = {
	DD = {
		spotting = 1,
		note = "normal attack",
		main = {
			{ firepower = 3 },
			{ firepower = 3 },
		},
		torpedo = {
			{ torpedo = 12 },
			{ torpedo = 12 },
			{ torpedo = 12 },
		},
	},
	CL = {
		spotting = Combat.modifier.spotting.double,
		note = "double attack",
		main = {
			{ firepower = 10 },
			{ firepower = 10 },
		},
		torpedo = {
			{ torpedo = 12 },
			{ torpedo = 12 },
			{ torpedo = 12 },
		},
	},
	CLT = {
		spotting = 1,
		note = "normal attack",
		main = {
			{ firepower = 10 },
			{ firepower = 10 },
			{ torpedo = 12 },
		},
		torpedo = {
			{ torpedo = 12 },
			{ torpedo = 12 },
			{ torpedo = 12 },
		},
	},
	CA = {
		spotting = Combat.modifier.spotting.double,
		note = "double attack",
		main = {
			{ firepower = 10 },
			{ firepower = 10 },
			{ firepower = 3 },
		},
		torpedo = {
			{ torpedo = 12 },
			{ torpedo = 12 },
			{ torpedo = 12 },
		},
	},
	Bismarck = {
		spotting = Combat.modifier.spotting.double * Combat.modifier.ap.main_ap,
		note = "double attack",
		nb_ci = Combat.modifier.night_attack.cut_in.torpedo,
		nb_ci_equip = "torpedo",
		main = {
			{ firepower = 17 },
			{ firepower = 17 },
			{ firepower = 9 },
		},
		torpedo = {
			{ firepower = 26 },
			{ firepower = 26 },
			{ torpedo = 15 },
			{ torpedo = 12 },
		},
	},
	FBB = {
		spotting = Combat.modifier.spotting.double * Combat.modifier.ap.main_ap,
		note = "double attack",
		main = {
			{ firepower = 17 },
			{ firepower = 17 },
			{ firepower = 9 },
		},
	},
	Yamato = {
		spotting = Combat.modifier.spotting.double * Combat.modifier.ap.main_ap,
		note = "double attack",
		main = {
			{ firepower = 30 },
			{ firepower = 30 },
			{ firepower = 9 },
		},
	},
	Italia = {
		spotting = Combat.modifier.spotting.double * Combat.modifier.ap.main_ap,
		note = "double attack",
		main = {
			{ firepower = 21 },
			{ firepower = 21 },
			{ firepower = 9 },
		},
	},
	Ise = {
		spotting = Combat.modifier.spotting.double * Combat.modifier.ap.main_ap,
		note = "double attack",
		main = {
			{ firepower = 20 },
			{ firepower = 20 },
			{ firepower = 9 },
		},
	},
}
setups.Musashi = setups.Yamato
setups.Nagato = setups.Yamato
setups.Mutsu = setups.Yamato
setups.Roma = setups.Italia
setups.Fusou = setups.Italia
setups.Yamashiro = setups.Italia
setups.Hyuuga = setups.Ise

local normalized_type_code = {
	DD = "DD",
	CL = "CL",
	CLT = "CLT",
	CA = "CA",
	CAV = "CA",
	FBB = "FBB",
	BB = "BB",
	BBV = "BB",
	CVL = "CV",
	CV = "CV",
	CVB = "CV",
}

local type_code_to_template = {
	DD = "main",
	CL = "main",
	CLT = "main",
	CA = "main",
	FBB = "main",
	BB = "main",
	CAV = "main",
	BBV = "main",
	CVL = "carrier",
	CV = "carrier",
	CVB = "carrier",
	-- SS = "submarine",
	-- SSV = "submarine",
	-- AV = "...",
	-- AO = "...",
}

function format_damage(ship_, damage_type_fn, night_attack, setup, equip_setup, spotting, hide_normal_damage)
    if not setup then return "" end
	local combat = Combat:new(night_attack)
	local normal_damage = combat:damage(damage_type_fn(combat, Combat.ship(ship_, {}, night_attack)))
	local normal_damage_string =
		normal_damage >= combat.cap
		and string.format('<span style="color:red;">%s</span>', normal_damage)
		or normal_damage
	local equip = setup[equip_setup]
	if not equip then return "" end
	setup.spotting = setup.spotting or 1
	local equip_damage_pre = combat:damage(damage_type_fn(combat, Combat.ship(ship_, equip, night_attack)))
	local equip_damage = combat:damage(damage_type_fn(combat, Combat.ship(ship_, equip, night_attack, spotting)))
	local equip_damage_string =
		equip_damage_pre >= combat.cap
		and string.format('<span style="color:red;">%s</span>', equip_damage)
		or equip_damage
	return
		night_attack
		and string.format("%s * 2", equip_damage_string)
		or hide_normal_damage
		and (spotting
		    and string.format("%s * 2", equip_damage_string)
		    or string.format("%s", equip_damage_string))
		or string.format("%s, %s", normal_damage_string, equip_damage_string)
end

local templates = {

	main = [[{| class="wikitable sortable typography-xl-optout" style="width:100%;"
! colspan="2" |
! colspan="4" |Day Battle
! colspan="5" |Night Battle
! colspan="3" |Defence
|-
!style="width:60px;"|Rank
!style="width:85px;"|Name
!${fp}
!${torp}
!<span title="Double attack damage (* 1.5 for critical hit)">DA</span>
!<span title="Torpedo salvo damage: without and with torpedo equipment (* 1.5 for critical hit)">Salvo</span>
!${fp_plus_torp}
!<span title="Maximal damage from double attack (* 1.5 for critical hit)">DA</span>
!<span title="Maximal damage from torpedo cut-in (* 1.5 for critical hit)">CI</span>
!${luck_minus_cap}
!<span title="Torpedo and mixed cut-in rate (only luck dependent part, no bonuses)">CI%</span>
!${hp}
!${armor}
!${evasion}
${rows}|}]],

	carrier = [[{| class="wikitable sortable typography-xl-optout" style="width:100%;"
! colspan="3" |
! colspan="5" |<span title="Air Power with maxed Reppuu">Air Power</span>
! colspan="2" |Offence
! colspan="3" |Defence
|-
!style="width:60px;"|Rank
!style="width:85px;"|Name
!${fp}
!Mule
!1st slot
!2nd
!3rd
!4th
!<span title="">Aerial Hit</span>
!<span title="">Shelling</span>
!${hp}
!${armor}
!${evasion}
${rows}|}]],

	main_row = [[|-
|${rank}
|${name}
|${fp}
|${torp}
|${db_attack}
|${db_torp}
|${fp_plus_torp}
|${nb_da}
|${nb_ci}
|${luck_minus_cap}
|${nb_ci_rate}
|${hp}
|${armor}
|${evasion_rate}
]],

	carrier_row = [[|-
|${rank}
|${name}
|${fp}
|${slot_all}
|${slot1}
|${slot2}
|${slot3}
|${slot4}
|${aerial}
|${shelling}
|${hp}
|${armor}
|${evasion_rate}
]],

}

local Table = {}

function Table.header(frame)
	local type_code_ = frame.args["type"]
	local type_code = normalized_type_code[type_code_]
	local template = templates[type_code_to_template[type_code_]]
	return format{
		template,
		rows = frame.args[1] or "",
		db_attack_note = setups[type_code] and setups[type_code].note or "",
		fp = Formatting:format_image{StatIcons.firepower, caption = Formatting:format_stat_name("firepower")},
		torp = Formatting:format_image{StatIcons.torpedo, caption = Formatting:format_stat_name("torpedo")},
		fp_plus_torp =
			Formatting:format_image{StatIcons.firepower, caption = Formatting:format_stat_name("firepower")}
			.. "+" ..
			Formatting:format_image{StatIcons.torpedo, caption = Formatting:format_stat_name("torpedo")},
		luck_minus_cap =
			'<span title="Luck cap">60</span>−' ..
			Formatting:format_image{StatIcons.luck, caption = Formatting:format_stat_name("luck")},
		hp = Formatting:format_image{StatIcons.hp, caption = Formatting:format_stat_name("HP")},
		armor = Formatting:format_image{StatIcons.armor, caption = Formatting:format_stat_name("Armor")},
		evasion = Formatting:format_image{StatIcons.evasion, caption = Formatting:format_stat_name("Evasion rate at lvl 80, with normal and high morale (only level dependent part)")},
	}
end

function Table.row(frame)

	local rank = frame.args[1]
	local ship_key = frame.args[2]
	local note = frame.args["note"]

	local name, suffix = Ship:process_ship_key(ship_key)
	local ship = Ship(ship_key){ _level = 80 }

	if rank and name and ship and ship._type then

		local type_code_ = Formatting:format_ship_code(ship._type)
		local type_code = normalized_type_code[type_code_]
		local template = templates[type_code_to_template[type_code_] .. "_row"]
		local luck_diff = 60 - ship._luck
		local setup = setups[name] or setups[type_code]

        if type_code == "CV" then
            local air_power = Combat.air_power(ship)
        	return format{
    			template,
    			rank = rank,
    			name = note and format{'[[${name}|<span title="${note}">${name}</span>]]<sup>?</sup>', name = name, note = note} or
    				   string.format("[[%s]]", name),
    			fp = ship._firepower_max,
    			torp = ship._torpedo_max or "",
    			hp = ship._hp,
    			armor = ship._armor_max,
    			evasion_rate = string.format("%s%%, %s%%", Combat.evasion_rate(ship), Combat.evasion_rate(ship, true)),
                slot_all = air_power.slot_all,
                slot1 = air_power.slot1,
                slot2 = air_power.slot2,
                slot3 = air_power.slot3,
                slot4 = air_power.slot4,
                aerial = "",
                shelling = "",
    		}
        else
    		return format{
    			template,
    			rank = rank,
    			name = note and format{'[[${name}|<span title="${note}">${name}</span>]]<sup>?</sup>', name = name, note = note} or
    				   string.format("[[%s]]", name),
    			fp = ship._firepower_max,
    			torp = ship._torpedo_max or "",
    			fp_plus_torp = ship._firepower_max + (ship._torpedo_max or 0),
    			db_attack = format_damage(ship, Combat.shelling, nil, setup, "main", setup and setup.spotting, true),
    			db_torp = format_damage(ship, Combat.torpedo, nil, setup, "torpedo"),
    			nb_da = format_damage(ship, Combat.night_battle, Combat.modifier.night_attack.double, setup, "main"),
    			nb_ci = format_damage(ship, Combat.night_battle, Combat.modifier.night_attack.cut_in.torpedo, setup, "torpedo"),
    			luck_minus_cap = luck_diff < 0 and "−" .. -luck_diff or luck_diff,
    			nb_ci_rate = Combat.nb_cut_in_rate(ship, Combat.nb_cut_in_types.torpedo) .. '%',
    			hp = ship._hp,
    			armor = ship._armor_max,
    			evasion_rate = string.format("%s%%, %s%%", Combat.evasion_rate(ship), Combat.evasion_rate(ship, true)),
    		}
        end
    
	else
		return ""
	end

end

return Table