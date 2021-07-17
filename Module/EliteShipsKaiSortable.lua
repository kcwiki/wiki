local EliteShipsKai = require('Module:EliteShipsKai')
local Formatting = require('Module:Formatting')

local split = require('Module:Core').split

local EliteShipsKaiSortable = EliteShipsKai{
	_table_start = [[{| class="wikitable sortable typography-xl-optout"]],
	_header_template = [[!No.
!Name
!Class
! style="white-space:nowrap;" | ${remodel}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: lightcoral;" | ${firepower}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: lightskyblue;" | ${torpedo}
${night_battle_header_cell}! style="width: 24px; text-align: center; vertical-align: middle; background-color: sandybrown;" | ${aa}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: #9C8FEE;" | ${asw}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: aquamarine;" | ${los}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: palegreen;" | ${luck}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: palegreen;" | ${luck}+
! style="width: 24px; text-align: center; vertical-align: middle; background-color: pink;" | ${hp}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: #F2E279;" | ${armor}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: violet;" | ${evasion}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: #72E6E6;" | ${speed}
${range_header_cell}! style="width: 24px; text-align: center; vertical-align: middle; background-color: silver;" data-sort-type="number" | ${aircraft}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: forestgreen;" | ${fuel}
! style="width: 24px; text-align: center; vertical-align: middle; background-color: darkgoldenrod;" | ${ammo}
! class="toggle-target-eliteshipskai-detail" style="text-align:left;" | Notes]],
	_column_cell_templates = {
		id = [[| colspan="${colspan}" rowspan="${rowspan}" style="text-align: ${text_align}; background-color: ${bg_color}; padding:3px;${extra_style}" |${values.value}]],
		notes = [[| class="${class}" colspan="${colspan}" rowspan="${rowspan}" style="text-align: ${text_align}; background-color: ${bg_color}; padding:3px;" |<small>${values.value}</small>]],
		["!"] = [[| class="${class}" colspan="${colspan}" rowspan="${rowspan}" style="text-align: ${text_align}; background-color: ${bg_color}; padding:3px;${extra_style}" |${values.value}]]
	},
	_base_columns = { --gets copied to self._columns in create_table_prep so we can mutate it. Don't mutate base_columns!
		"id",
		"name",
		"class",
		"remodel",
		"firepower",
		"torpedo", --night_battle is added after this depending on args in create_table_prep. If adding columns please preserve this behaviour.
		"aa",
		"asw",
		"los",
		"luck",
		"luck_max",
		"hp",
		"armor",
		"evasion",
		"speed",
		"aircraft",
		"fuel",
		"ammo",
		"notes",
	},
}
 
function EliteShipsKaiSortable:luck(ship)
	local luck = ship:luck()
	return {values = {value = Formatting:format_stat(luck)}, bg_color = self:get_bg_color(self._cell_color.luck, luck, self._args.luck_operator, self._args.luck_outstanding, self._args.luck_good, self._args.luck_bad), text_align = self._center_align}
end
 
function EliteShipsKaiSortable:luck_max(ship)
	local luck_max = ship:luck_max()
	return {values = {value = self:get_emphasis(luck_max, Formatting:format_stat(luck_max), self._args.luck_max_operator, self._args.luck_max_good)}, bg_color = self._transparent, text_align = self._center_align}
end

function EliteShipsKaiSortable:create_table_prep()
    self._columns = {}
    for _, column in ipairs(self._base_columns) do
        table.insert(self._columns, column)
    end
	if self._args.reference_type then
		self._reference_types = {}
		for _, reference_type in ipairs(split(self._args.reference_type, ',%s*')) do
			self._reference_types[tonumber(reference_type)] = true
		end
    end
    if self._args.night_battle then
        table.insert(self._columns, 7, "night_battle")
    end
    if self._args.range then
        table.insert(self._columns, self._args.night_battle and 17 or 16, "range")
    end
end

EliteShipsKaiSortable.create_data_rows = EliteShipsKaiSortable.create_data_rows_plain

return EliteShipsKaiSortable