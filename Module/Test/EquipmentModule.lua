local U = require('Module:Core')

local equipment = {}

equipment.data = mw.loadData('Module:Data/Equipment')
equipment.refit = mw.loadData("Module:Data/EquipmentRefit")

local function getSortedIDList()
    local IDList = {}
    for id, data in pairs(equipment.data) do
        IDList[#IDList + 1] = id
        local x = #IDList
        while x > 1 and IDList[x] < IDList[x - 1] do
            IDList[x - 1], IDList[x] = IDList[x], IDList[x - 1]
            x = x - 1
        end
    end
    return IDList
end

local function getEquipmentIcon(frame, eq)
  local names = {
  	[49] = 'Heavy Bomber',
  }
  return names[eq.iconID]
    and string.format(
      '[[File:Equipment Icon %s.png|%s|36px]]',
      names[eq.iconID] ~= '' and names[eq.iconID] or tostring(eq.iconID),
      names[eq.iconID] ~= '' and names[eq.iconID] or '???')
    or frame:expandTemplate{ title = eq.icon }
end

function equipment.EquipmentInfo(frame)
    local arg = frame.args[1]
    local pagename = U.getTemplateArgs(frame).implicit.pagename
    local equipmentNum = arg and arg ~= '' and arg or pagename
    if equipmentNum == nil then
        assert(equipmentNum, "No Equipment ID provided!")
    end
    --If not num, then search equipment db using equipment name
    if tonumber(equipmentNum) == nil then
    	local _, key = U.findBy(equipment.data, function(e) return e.name[2] == equipmentNum or e.legacy == equipmentNum end)
    	equipmentNum = key or '???'
	end
    --Add leading zeros if not correctly formatted
    local equipmentNum = string.rep('0', 3-#equipmentNum) .. equipmentNum
    --Error if no data found (malformed ID, etc)
    local equipmentErr = assert(equipment.data[equipmentNum], "This Equipment ID does not contain any data")

    --Done purposely. Save an unneccessary 4-13 template calls each time the module is called.
    local images = {
        ["hp"] = '[[File:icon_HP.png|Health]]',
        ["fp"] = '[[File:icon_Gun.png|Firepower]]',
        ["armor"] = '[[File:icon_Armor.png|Armor]]',
        ["torpedo"] = '[[File:icon_Torpedo.png|Torpedo Attack]]',
        ["bombing"] = '[[File:Icon Dive.png|Dive Bomber Attack]]',
        ["evasion"] = '[[File:icon_Evasion.png|Evasion]]',
        ["aa"] = '[[File:icon_AA.png|Anti-Air]]',
        ["accuracy"] = '[[File:Icon Hit.png|Accuracy]]',
        ["asw"] = '[[File:icon_ASW.png|Anti-Submarine]]',
        ["los"] = '[[File:icon_LOS.png|View Range]]',
        ["range"] = '[[File:icon_Range.png|Range]]',
        ["speed"] = '[[File:icon_Speed.png|Speed]]',
        ["luck"] = '[[File:icon_Luck.png|Luck]]',
        ["fuel"] = '[[File:Fuel.png|Fuel|25px]]',
        ["ammo"] = '[[File:Ammunition.png|Ammunition|25px]]',
        ["steel"] = '[[File:Steel.png|Steel|25px]]',
        ["bauxite"] = '[[File:Bauxite.png|Bauxite|25px]]',
        hit = '[[File:Icon_Hit.png|Anti-Bomber]]',
        interception = '[[File:Icon_Interception.png|Interception]]',
    }

    local equipmentInfo = equipment.data[equipmentNum]
    --Remove leading zeros
    equipmentNum = tostring(tonumber(equipmentNum))
    local equipmentName = equipmentInfo.name[2]
    local equipmentJName = equipmentInfo.name[1]
    local equipmentIcon = getEquipmentIcon(frame, equipmentInfo)
    local equipmentType = equipmentInfo.type

    local equipmentEffect = ""
	for _, stat in ipairs({"hp", "fp", "armor", "torpedo", "bombing", "evasion", "aa", "accuracy", "asw", "los", "range", "speed", "luck"}) do
		local value = tonumber(equipmentInfo[stat])
		if value and value ~= 0 then
			if equipmentInfo.typeID and equipmentInfo.typeID == 48 then
				stat = ({ evasion = 'interception', accuracy = 'hit' })[stat] or stat
			end
			equipmentEffect = equipmentEffect .. " " .. images[stat] .. (value < 0 and string.format('<font color="red">%d</font>', value) or "+" .. value)
		end
	end
	-- Add range stat, assuming it's 'Short', 'Medium', 'Long', or 'Very Long'
	if (equipmentInfo.range == "Short") or (equipmentInfo.range == "Medium") or (equipmentInfo.range == "Long") or (equipmentInfo.range == "Very Long") then
		equipmentEffect = equipmentEffect .. " " .. images["range"] .. " " .. equipmentInfo.range
	end

    local equipmentScrap = ""
    local scrap = {"fuel", "ammo", "steel", "bauxite"}
    
    for i = 1, #scrap do
        if equipmentInfo.dismantle[i] ~= 0 then
            equipmentScrap = equipmentScrap .. " " .. images[scrap[i]] .. equipmentInfo.dismantle[i]    
        end
    end

    local html = ""
    --html = '<table style="border: 1px solid darkgray; width: 400px;">'
    html = '<table style="border: 1px solid darkgray; width: 400px; border-radius: 10px 10px 10px 10px;">'
    html = html .. '<tr>'
    --html = html .. '<td colspan="2" style="text-align: center; background-color: LightSkyBlue;">'
    html = html .. '<td colspan="2" style="text-align: center; background-color: LightSkyBlue; border-radius: 10px 10px 0px 0px;">'
    html = html .. '<p style="font-size:25px"><b>' .. equipmentName .. '</b></p>'
    html = html .. '<p style="font-size:20px"><b>No.' .. equipmentNum .. ' <span lang="ja">' .. equipmentJName .. '</span>' .. '</b></p>'
    html = html .. '</td>'
    html = html .. '</tr>'

    html = html .. '<tr>'
    html = html .. '<td colspan="2" style="text-align: center;>'
    html = html .. '<p><b>' .. equipmentIcon .. " " .. equipmentType .. '</b></p>'
    if equipmentEffect ~= "" then
        html = html .. '<p><b>Effects: ' .. equipmentEffect .. '</b></p>'
    end
    if equipmentInfo.radius ~= 0 then
        html = html .. '<p><b>[[Land-Based Air Squadron|Combat Radius]]: ' .. equipmentInfo.radius .. '</b></p>'
    end
    if equipmentScrap ~= "" then
        html = html .. '<p><b>Scrap Value: ' .. equipmentScrap .. '</b></p>'
    end
    html = html .. '</td>'
    html = html .. '</tr>'

    --Old display method
    --html = html .. '<tr>'
    --html = html .. '<td colspan="2" style="text-align: center;>'
    --local image1 = 'Equipment' .. equipmentNum .. '-1.png\n'
    --local image2 = 'Equipment' .. equipmentNum .. '-2.png\n'
    --local image3 = 'Equipment' .. equipmentNum .. '-3.png\n'
    --local image4 = 'Equipment' .. equipmentNum .. '-4.png'
    --html = html .. frame:extensionTag('gallery', image1 .. image2 .. image3 .. image4, {type="slideshow", widths="360px", position="center", hideaddbutton="true"}) .. '</td>'
    --html = html .. '</tr>'

    html = html .. '<tr>'
    html = html .. '<td colspan="2" style="text-align: center;>'
    local assetName = equipmentName:gsub('/', ' '):gsub('  ', ' ')
    local tab1 = 'Card=[[File:Equipment Card ' .. assetName ..'.png|x260px]]|-|'
    local tab2 = 'Fairy=[[File:Equipment Character ' .. assetName ..'.png|x260px]]|-|'
    local tab3 = 'Equipment=[[File:Equipment Item ' .. assetName ..'.png|x260px]]|-|'
    local tab4 = 'Combination=[[File:Equipment Full ' .. assetName ..'.png|x260px]]'
    html = html .. frame:extensionTag('tabber', tab1 .. tab2 .. tab3 .. tab4) .. '</td>'
    html = html .. '</tr>'

    html = html .. '<tr>'
    html = html .. '<td colspan="2" style="text-align: center; background-color: LightSkyBlue;">'
    html = html .. '<b>Development</b>'
    html = html .. '</td>'
    html = html .. '</tr>'
    local craftable = "#d85658"
    local improvable = "#d85658"
    if equipmentInfo.craftable then craftable = "#51fb51" end
    if equipmentInfo.improvable then improvable = "#51fb51" end
    html = html .. '<tr>'
    html = html .. '<td style="width: 200px; text-align: center; background-color: ' .. craftable .. ';">Craftable</td>'
    html = html .. '<td style="width: 200px; text-align: center; background-color: ' .. improvable .. ';">Improvable</td>'
    html = html .. '</tr>'

    html = html .. '<tr>'
    html = html .. '<td colspan="2" style="text-align: center; background-color: LightSkyBlue;">'
    html = html .. '<b>Refittable Class</b>'
    html = html .. '</td>'
    html = html .. '</tr>'

	local canEquipCells = {
		{ type = 1,  name = 'Coastal Defense Ship' },
		{ type = 2,  name = 'Destroyer' },
		{ type = 3,  name = 'Light Cruiser' },
		{ type = 4,  name = 'Torpedo Cruiser' },
		{ type = 5,  name = 'Heavy Cruiser' },
		{ type = 6,  name = 'Aviation Cruiser' },
		{ type = 9,  name = 'Battleship' },
		{ type = 10, name = 'Aviation Battleship' },
		{ type = 8,  name = 'Fast Battleship' },
		{ type = 7,  name = 'Light Carrier' },
		{ type = 11, name = 'Standard Carrier' },
		{ type = 18, name = 'Armored Carrier' },
		{ type = 16, name = 'Seaplane Tender' },
		{ type = 20, name = 'Submarine Tender' },
		{ type = 13, name = 'Submarine' },
		{ type = 14, name = 'Submarine Carrier' },
		{ type = 19, name = 'Repair Ship' },
		{ type = 21, name = 'Training Cruiser' },
		{ type = 22, name = 'Fleet Oiler' },
		{ type = 17, name = 'Amphibious Assault Ship' },
	}

    for i, cell in ipairs(canEquipCells) do
		if i % 2 == 1 then
			html = html .. '<tr>'
		end
        local refit = equipment.refit[cell.type][equipmentInfo.typeID]
        html = html .. string.format(
        	'<td style="width:200px;text-align:center;background-color:%s">%s</td>',
        	refit == true and '#51fb51' or type(refit) == 'string' and '#ffff00' or '#fcfcfc',
        	type(refit) == 'string' and string.format('<span style="cursor:help;border-bottom:1px dotted" title="%s">%s</span>', refit, cell.name) or cell.name
        )
		if i % 2 == 0 then
			html = html .. '</tr>'
		end
    end
    --[[
    if restrict ~= "" and restrict ~= nil then
        html = html .. '<tr>'
        html = html .. '<td colspan="2" style="text-align: center; background-color: LightSkyBlue;">'
        --html = html .. '<b>Notes</b>'
        html = html .. '<b>Special Restrictions</b>'
        html = html .. '</td>'
        html = html .. '</tr>'

        html = html .. '<tr>'
        html = html .. '<td colspan="2" style="text-align: center;">'
        --html = html .. '<b>Special Restrictions:</b>'
            html = html  .. '<ul>'
            local restricted = mw.text.split(restrict, "#")
            for i = 1, #restricted - 1 do
                html = html .. '<li style="text-align: left; margin-right: 5px;">'
                html = html .. restricted[i];
                html = html .. '</li>'
            end
            html = html .. '</ul>'
        html = html .. '</td>'
        html = html .. '</tr>'
    end
	]]--
    html = html .. '</table>'
    return html
end

function equipment.EquipmentList(frame)
    --local equipmentDisplay = frame.args[1]
    local equipmentType = tonumber(frame.args[1])
    local accuracyLabel = 'Accuracy'
    local evasionLabel = '[[File:icon_Evasion.png|Evasion|link=]]'

	if equipmentType == 48 then
		accuracyLabel = 'Anti-Bomber'
		evasionLabel = '[[File:Icon_Interception.png|Interception|link=]]'
	end

	local planeTypes = {
		[6] = true,
		[7] = true,
		[8] = true,
		[9] = true,
		[10] = true,
		[11] = true,
		[41] = true,
		[45] = true,
		[47] = true,
		[48] = true,
		[49] = true,
		[57] = true,
		[94] = true
	}

	local bomberTypes = {
		[7] = true,
		[8] = true,
		[9] = true,
		[11] = true,
		[47] = true,
		[57] = true
	}

    local equipmentListTable = '<table class="wikitable sortable style="width: 100%; min-width: 900px;"><tr>'
    equipmentListTable = equipmentListTable .. '<th style="text-align: center">ID</th>'
    equipmentListTable = equipmentListTable .. '<th style="text-align: center">Name</th>'
    equipmentListTable = equipmentListTable .. '<th style="text-align: center; vertical-align: middle; background-color:rgb(240,128,128);">[[File:icon_Gun.png|Firepower|link=]]</th>'
    equipmentListTable = equipmentListTable .. '<th style="text-align: center; vertical-align: middle; background-color:rgb(135,206,250);">[[File:icon_Torpedo.png|Torpedo|link=]]</th>'
    if bomberTypes[equipmentType] then
    	equipmentListTable = equipmentListTable .. '<th style="text-align: center; vertical-align: middle; background-color: firebrick;">[[File:icon Dive.png|Bombing|link=]]</th>'
    end
    equipmentListTable = equipmentListTable .. '<th style="text-align: center; vertical-align: middle; background-color:rgb(244,164,96);">[[File:icon_AA.png|Anti-Air|link=]]</th>'
    equipmentListTable = equipmentListTable .. '<th style="text-align: center; vertical-align: middle; background-color:yellow;">[[File:icon_Armor.png|Armor|link=]]</th>'
    equipmentListTable = equipmentListTable .. '<th style="text-align: center; vertical-align: middle; background-color:rgb(255,245,238);">[[File:icon_ASW.png|Anti-Submarine Warfare|link=]]</th>'
    equipmentListTable = equipmentListTable .. '<th style="text-align: center; vertical-align: middle; background-color:rgb(127,255,212);">[[File:icon_LOS.png|Line of Sight|link=]]</th>'
    equipmentListTable = equipmentListTable .. '<th style="text-align: center; vertical-align: middle; background-color:rgb(244,164,96);">[[File:Icon Hit.png|'.. accuracyLabel ..'|link=]]</th>'
    equipmentListTable = equipmentListTable .. '<th style="text-align: center; vertical-align: middle; background-color:rgb(238,130,238);">'.. evasionLabel ..'</th>'
    equipmentListTable = equipmentListTable .. '<th style="text-align: center; background-color: lightseagreen;">[[File:Icon_Range.png|Range|link=]]</th>'
    if planeTypes[equipmentType] then
    	equipmentListTable = equipmentListTable .. '<th style="text-align: center; vertical-align: middle; background-color: lightseagreen;">[[File:icon_Range.png|Combat Radius|link=]]</th>'
    end
    equipmentListTable = equipmentListTable .. '<th style="text-align: center;">Craftable</th>'
    equipmentListTable = equipmentListTable .. '<th style="text-align: center;>Improvable</th></tr>'

	local IDList = getSortedIDList()
    for num, id in pairs(IDList) do
    	if equipmentType == equipment.data[id]["typeID"] then
            equipmentListTable = equipmentListTable .. equipment.EquipmentListEntry(id)
        end	
    	
    	--[[
        if equipmentDisplay == "kanmusu" then
            if tonumber(id) < 500 then
                if equipmentType ~= nil and equipmentType ~= "" then
                    if equipmentType == "craftable" then
                        if equipment.data[id]["craftable"] then
                            equipmentListTable = equipmentListTable .. equipment.EquipmentListEntry(id)
                        end
                    elseif equipmentType == "improvable" then
                        if equipment.data[id]["improvable"] then
                            equipmentListTable = equipmentListTable .. equipment.EquipmentListEntry(id)
                        end
                    else
                        if equipmentType == equipment.data[id]["typeID"] then
                            equipmentListTable = equipmentListTable .. equipment.EquipmentListEntry(id)
                        end
                    end
                else
                    equipmentListTable = equipmentListTable .. equipment.EquipmentListEntry(id)
                end 
            end
        elseif equipmentDisplay == "abyssal" then
            if tonumber(id) > 500 then
                if equipmentType ~= nil and equipmentType ~= "" then
                    if equipmentType == equipment.data[id]["typeID"] and equipmentDisplay ~= "" then
                        equipmentListTable = equipmentListTable .. equipment.EquipmentListEntry(id)
                    end
                else
                    equipmentListTable = equipmentListTable .. equipment.EquipmentListEntry(id)
                end        
            end
        else
            if equipmentDisplay ~= nil and equipmentDisplay ~= "" then
                if equipmentDisplay == equipment.data[id]["typeID"] then
                    equipmentListTable = equipmentListTable .. equipment.EquipmentListEntry(id)
                end
            else
                equipmentListTable = equipmentListTable .. equipment.EquipmentListEntry(id)
            end
        end
        ]]--
    end
    equipmentListTable = equipmentListTable .. '</table>'
    return equipmentListTable
end

function equipment.EquipmentListEntry(id)
    local strings = '<tr>'

	local planeTypes = {
		[6] = true,
		[7] = true,
		[8] = true,
		[9] = true,
		[10] = true,
		[11] = true,
		[41] = true,
		[45] = true,
		[47] = true,
		[48] = true,
		[49] = true,
		[57] = true,
		[94] = true
	}

	local bomberTypes = {
		[7] = true,
		[8] = true,
		[9] = true,
		[11] = true,
		[47] = true,
		[57] = true
	}

    strings = strings .. '<td style="text-align: center;">' .. tonumber(id) .. '</td>'
    strings = strings .. '<td style="text-align: center;">[[' .. equipment.data[id]["name"][2] .. '|' .. equipment.data[id]["name"][2] ..']]</br>'.. equipment.data[id]["name"][1]  ..'</td>'
    strings = strings .. '<td style="text-align: center;">' .. equipment.data[id]["fp"] .. '</td>'
    strings = strings .. '<td style="text-align: center;">' .. equipment.data[id]["torpedo"] .. '</td>'
    if bomberTypes[equipment.data[id]["typeID"]] then
    	strings = strings .. '<td style="text-align: center;">' .. equipment.data[id]["bombing"] .. '</td>'
    end
    strings = strings .. '<td style="text-align: center;">' .. equipment.data[id]["aa"] .. '</td>'
    strings = strings .. '<td style="text-align: center;">' .. equipment.data[id]["armor"] .. '</td>'
    strings = strings .. '<td style="text-align: center;">' .. equipment.data[id]["asw"] .. '</td>'
    strings = strings .. '<td style="text-align: center;">' .. equipment.data[id]["los"] .. '</td>'
    strings = strings .. '<td style="text-align: center;">' .. equipment.data[id]["accuracy"] .. '</td>'
	strings = strings .. '<td style="text-align: center;">' .. equipment.data[id]["evasion"] .. '</td>'
    strings = strings .. '<td style="text-align: center;">' .. (equipment.data[id]["range"] or '') .. '</td>'
    if planeTypes[equipment.data[id]["typeID"]] then
    	strings = strings .. '<td style="text-align: center;">' .. equipment.data[id]["radius"] .. '</td>'
    end
    if equipment.data[id]["craftable"] then
        strings = strings .. '<td style="text-align: center;">' .. 'Yes' .. '</td>'
    else
        strings = strings .. '<td style="text-align: center;">' .. 'No' .. '</td>'
    end
    if equipment.data[id]["improvable"] then
        strings = strings .. '<td style="text-align: center;">' .. 'Yes' .. '</td>'
    else
        strings = strings .. '<td style="text-align: center;">' .. 'No' .. '</td>'
    end
    strings = strings .. '</tr>'
    
    return strings
end

function equipment.EquipmentTypeEquipBy(frame)
	local equipmentType = tonumber(frame.args[1])
	local returnString = ""
	local shipClassList = {
		{ type = 1,  name = 'DE' },
		{ type = 2,  name = 'DD' },
		{ type = 3,  name = 'CL' },
		{ type = 4,  name = 'CLT' },
		{ type = 5,  name = 'CA' },
		{ type = 6,  name = 'CAV' },
		{ type = 9,  name = 'BB' },
		{ type = 10, name = 'BBV' },
		{ type = 8,  name = 'FBB' },
		{ type = 7,  name = 'CVL' },
		{ type = 11, name = 'CV' },
		{ type = 18, name = 'CVB' },
		{ type = 16, name = 'AV' },
		{ type = 20, name = 'AS' },
		{ type = 13, name = 'SS' },
		{ type = 14, name = 'SSV' },
		{ type = 19, name = 'AR' },
		{ type = 21, name = 'CT' },
		{ type = 22, name = 'AO' },
		{ type = 17, name = 'LHA' },
	}
	
	for i, shipClass in ipairs(shipClassList) do
		local refit = equipment.refit[shipClass.type][equipmentType]
		local shipString = refit == true and shipClass.name or type(refit) == 'string' and string.format('<span style="cursor:help;border-bottom:1px dotted" title="%s">%s</span>', refit, shipClass.name) or ''
		returnString = returnString .. shipString .. ' '
	end
	return returnString
end

return equipment