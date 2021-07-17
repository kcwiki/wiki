local BaseData = require('Module:BaseData')
local Artist = require('Module:Artist')
local Ship = require('Module:Ship')
local VoiceActor = require('Module:VoiceActor')
local Formatting = require('Module:Formatting')

local U = require('Module:Core')
local format = U.format

local ShipMetaKai = BaseData{
	_template = [[{|class="${table_class}" 
|-
!class="infobox-kai-header-major" colspan=2|${name}<div style="float:right;margin-right:5px">${edit_link}</div>
|-
!Class
|${class}
|-
!${voice_actor_header}
|${voice_actor}
|-
!${artist_header}
|${artist}
|-
!Availability
|${availability}
|-
!Implementation
|${implementation_date}
|}]],
    _flat_template = [[{|class="${table_class}" 
|-
!class="infobox-kai-header-major" colspan=4|${name}<div style="float:right;margin-right:5px">${edit_link}</div>
|-
!${voice_actor_header}
|${voice_actor}
!Availability
|${availability}
|-
!${artist_header}
|${artist}
!Implementation
|${implementation_date}
|}]],
    _ship_data_documentation = "Template:ShipDataDocumentation/EditIntro",
    _edit_link_text = "Edit",
	_voice_actor_header = "[[Glossary#List of Vessels by Japanese Voice Actresses|Seiyuu]]",
	_artist_header = "[[Glossary#List of Vessels by Artist|Artist]]",
	_class_template = "[[:Category:${ship_class}|${ship_class}]]",
	_name_template = "${name} ${japanese_name}",
	_person_template = "${name} (${japanese_name})",
	_normal_construction_label = "[[Construction#Building_recipes|Normal]]",
	_large_ship_construction_label = "[[Construction#Large_Ship_Construction_Recipe|LSC]]",
	_buildable_label = "Construction",
	_drop_label = "Drop",
	_details_template = " (${details})",
	_event_reward_label = "[[Template:Event_Drop|Event Reward]]",
	_event_drop_label = "[[Template:Event_Drop|Event Drop]]",
	_node_name_template = "${world}-${map} ${node}",
	_node_formation_template = "-${formation}",
	_event_node_name_template = "${year} ${quarter} E-${map} ${node}",
	_event_map_name_template = "${year} ${quarter} E-${map}",
	_date_template = "${year}/${month:2}/${day:2}",
	_all_nodes_symbol = "*",
	_max_drops_before_collapsible = 6,
	_quarters = {
		[1] = "Winter",
		[4] = "Spring",
		[7] = "Summer",
		[10] = "Fall",
		[12] = "Christmas",
	},
	_difficulties = {
		[0] = "All",
		[1] = "Easy",
		[2] = "Medium",
		[3] = "Hard",
	},
	_fields = {
	    "edit_link",
		"name",
		"class",
		"voice_actor",
		"artist",
		"availability",
		"implementation_date",
	},
}

function ShipMetaKai:Infobox(args)
	return self{
		_args = args,
	}:create_infobox()
end

function ShipMetaKai:edit_link()
	self._vars.edit_link = Formatting:format_edit_link(self._ship_data_module, self._edit_link_text, self._ship_data_documentation)
end

function ShipMetaKai:name()
	self._vars.name = Formatting:format_stat(self._ship:name())
	local japanese_name = Formatting:format_stat(self._ship:japanese_name())
	if japanese_name ~= self._vars.name then
	    self._vars.name = format{self._name_template, name = self._vars.name, japanese_name = tostring(Formatting:japanese_text(japanese_name))}
	end
end

function ShipMetaKai:class()
	local ship_class = self._ship:class()
	if ship_class then
		self._vars.class = format{self._class_template, ship_class = ship_class:name()}
	end
end

function ShipMetaKai:voice_actor()
	self._vars.voice_actor = self:person(VoiceActor(self._ship:voice_actor()))
end

function ShipMetaKai:artist()
	self._vars.artist = self:person(Artist(self._ship:artist()))
end

function ShipMetaKai:person(person)
	local link, japanese_name, reading = Formatting:format_external_link(person:link()), person:japanese_name(), person:reading()
	if japanese_name == false then
		return link
	elseif reading == false then
	    japanese_name = tostring(Formatting:japanese_text(Formatting:format_stat(person:japanese_name())))
	else
	    japanese_name = tostring(Formatting:japanese_text(Formatting:format_stat(person:japanese_name()), Formatting:format_stat(person:reading())))
	end
	return format{self._person_template, name = Formatting:format_external_link(person:link()), japanese_name = japanese_name}
end

local custom_quest_links = {
    ["5A05"] = "Partials/Updates/2018_April_23rd#5A05"
}

function ShipMetaKai:availability()
	local availability = self._ship:availability()
	local result = {}
	local buildable = false
	if self._ship:buildable() then
		buildable = {self._normal_construction_label}
	end
	if self._ship:buildable_lsc() then
		buildable = buildable or {}
		table.insert(buildable, self._large_ship_construction_label)
	end
	if buildable then
		table.insert(result, self._buildable_label .. format{self._details_template, details = table.concat(buildable, ", ")})
	end
	if availability and availability.quest then
        table.insert(result, "Quest: " .. U.ijoin(U.imap(availability.quest, function(label)
            return string.format("[[%s|%s]]", custom_quest_links[label] or string.format("Quests#%s", label), label)
        end), ", "))
	end
	for _, method in ipairs(availability or {}) do
		if method == "drop" then
			local details = {}
			if availability.drop then
				for _, drop in ipairs(availability.drop) do
					local nodes, complex
					if type(drop[3]) == "table" then
						nodes = drop[3]
					elseif drop[3] == true then
						nodes = {self._all_nodes_symbol}
					else
						nodes = {drop[3]}
					end
					for _, node in ipairs(nodes) do
						local node_name = format{self._node_name_template, world = drop[1], map = drop[2], node = node}
						if #drop == 4 then
							node_name = node_name .. format{self._node_formation_template, formation = complex and drop[4][node] or drop[4]}
						end
						table.insert(details, node_name)
					end
				end
			end
		    local details_len = #details
			if details_len > 0 then
				details = format{self._details_template, details = table.concat(details, ", ")}
				if details_len > self._max_drops_before_collapsible then
					table.insert(result, tostring(mw.html.create("div"):addClass("mw-collapsible"):addClass("mw-collapsed"):wikitext(self._drop_label):tag("div"):addClass("mw-collapsible-content"):wikitext(details):allDone()))
				else
					table.insert(result, self._drop_label .. details)
				end
			else
				table.insert(result, self._drop_label)
			end
		elseif method == "event_reward" then
			local details, current_event_details = {}, {}
			if availability.event_reward then
				for _, map in ipairs(availability.event_reward) do
					local map_name = format{self._event_map_name_template, year = map[1], quarter = self._quarters[map[2]], map = map[3]}
					if #map == 4 then
						map_name = map_name .. format{self._details_template, details = self._difficulties[map[4]]}
					end
					table.insert(details, map_name)
					if map[1] == 2016 and map[2] == 7 then
					    table.insert(current_event_details, map_name)
					end
				end
			end
			if #details > 0 and self._detailed_availability then
				details = format{self._details_template, details = table.concat(details, ", ")}
			elseif #current_event_details > 0 then
				details = format{self._details_template, details = table.concat(current_event_details, ", ")}
			else
				details = ""
			end
			table.insert(result, self._event_reward_label .. details)
		elseif method == "event_drop" then
			local details, current_event_details = {}, {}
			if availability.event_drop then
				for _, drop in ipairs(availability.event_drop) do
					local nodes, complex
					if type(drop[4]) == "table" then
						nodes = drop[4]
					elseif drop[4] == true then
						nodes = {self._all_nodes_symbol}
					else
						nodes = {drop[4]}
					end
					for _, node in ipairs(nodes) do
						local node_name = format{self._event_node_name_template, year = drop[1], quarter = self._quarters[drop[2]], map = drop[3], node = node}
						if #drop == 5 then
							node_name = node_name .. format{self._node_formation_template, formation = complex and drop[5][node] or drop[5]}
						end
    					table.insert(details, node_name)
    					if drop[1] == 2016 and drop[2] == 7 then
    					    table.insert(current_event_details, map_name)
    					end
					end
				end
		    end
		    local details_len = #details
			if details_len > 0 and self._detailed_availability then
				details = format{self._details_template, details = table.concat(details, ", ")}
				if details_len > self._max_drops_before_collapsible then
					table.insert(result, tostring(mw.html.create("div"):addClass("mw-collapsible"):addClass("mw-collapsed"):wikitext(self._event_drop_label):tag("div"):addClass("mw-collapsible-content"):wikitext(details):allDone()))
				else
					table.insert(result, self._event_drop_label .. details)
				end
			elseif #current_event_details > 0 then
				current_event_details = format{self._details_template, details = table.concat(current_event_details, ", ")}
				table.insert(result, self._event_drop_label .. current_event_details)
			else
				table.insert(result, self._event_drop_label)
			end
		end
	end
	self._vars.availability = table.concat(result, "<br/>")
end

function ShipMetaKai:implementation_date()
	local form = self._ship
	local next_form = form._remodel_to
	local i = 1
	local data = {}
	local forms = {}
	if form._implementation_date then
	    data[format{
		    self._date_template,
		    year = form._implementation_date[1],
		    month = form._implementation_date[2],
		    day = form._implementation_date[3]
		}] = { "Base" }
	end
	while next_form and not forms[next_form] and i < 10 do
	    forms[next_form] = true
	    form = Ship(next_form)
	    if form._implementation_date then
	        local d = format{
		        self._date_template,
		        year = form._implementation_date[1],
		        month = form._implementation_date[2],
		        day = form._implementation_date[3]
		    }
		    local name = form:suffix() and form:suffix() ~= "" and form:suffix() or form:name()
		    data[d] = data[d] or {}
	        table.insert(data[d], name)
	    end
	    next_form = form._remodel_to
        i = i + 1
	end
    local dates = U.isort(U.keys(data))
	self._vars.implementation_date = #dates == 0 and "??" or #dates == 1 and dates[1] or U.ijoin(U.imap(dates, function (d)
		return string.format("%s (%s)", d, U.ijoin(data[d], ", "))
	end), "<br>")
end

function ShipMetaKai:create_item()
	if self._args.name then
		self._ship = Ship(self._args.name, self._args.model)
	else
		self._ship = Ship(self._args[1])
	end
end

function ShipMetaKai:get_module()
	self._ship_data_module = Ship:get_module(self._args.name or self._args[1])
end

function ShipMetaKai:create_infobox_prep()
	self._vars = {}
	local table_classes = {"infobox", "infobox-kai"}
	if self._args.classes then
		table.insert(table_classes, self._args.classes)
	end
	local collapsible = self._args.collapsible
	if collapsible then
		table.insert(table_classes, "mw-collapsible")
		table.insert(table_classes, "mw-collapsed")
	end
	self._vars.table_class = table.concat(table_classes, " ")
	--self._vars.table_id = collapsible and collapsible ~= "true" and ("mw-customcollapsible-" .. collapsible) or ""
	--self._vars.float = self._args.float and format{self._float_style_template, float = self._args.float} or ""
	self._vars.voice_actor_header = self._voice_actor_header
	self._vars.artist_header = self._artist_header
end

function ShipMetaKai:format_template()
	for _, field in ipairs(self._fields) do
		self[field](self)
	end
	return format(self._args.thin and self._template or self._flat_template, self._vars)
end

function ShipMetaKai:add_fields()
	return
end

function ShipMetaKai:create_infobox()
	self:add_fields()
	self:create_item()
	self:get_module()
	self:create_infobox_prep()
	return self:format_template()
end

function ShipMetaKai.test()
    mw.log(ShipMetaKai:Infobox({ "Ayanami" }))
    mw.log(ShipMetaKai:Infobox({ "U-511" }))
    mw.log(ShipMetaKai:Infobox({ "Zuikaku" }))
end
-- p.test()

return ShipMetaKai