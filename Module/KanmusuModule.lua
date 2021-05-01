local U = require('Module:Core')

local ShipList = {}

function ShipList.findID(frame)
    for id, data in pairs(ShipList.KanmusuData) do
        if ShipList.KanmusuData[id].name[3] == frame.args[1] then 
        	return id
        end
    end
    return "NotInDB"
end

function ShipList.getSortedIDList()
    local IDList = {}
    for id, data in pairs(ShipList.KanmusuData) do
        IDList[#IDList + 1] = id
        local x = #IDList
        while x > 1 and IDList[x] < IDList[x - 1] do
            IDList[x - 1], IDList[x] = IDList[x], IDList[x - 1]
            x = x - 1
        end
    end
    return IDList
end

function ShipList.TotalAircraft(frame) 
    local shipID = frame.args[1]
    -- if tonumber(shipID) == nil then
    --     shipID = ShipList.findID(frame)
    -- end
    local ship = ShipList.KanmusuData[shipID]
    local total = 0
    if ship.aircraft ~= "" then
    	for i, planes in pairs(ship.aircraft) do
    		if ship.aircraft[i] == nil or ship.aircraft[i] == "" then 
    			total = total + 0  
			else 
				total = total + ship.aircraft[i] 
			end
		end
	end
    return total
end

function ShipList.getWikiPage(id)
    --finding name of wiki page of ship
    shipname = ShipList.KanmusuData[id]["name"][3]
    pagename = shipname
    if string.sub(id,1,-2) == "Mist" then   -- fleet of fog check
    	if string.sub(id, -1) == '1' then
    		pagename = 'Iona_(fog)'
    	elseif string.sub(id, -1) == '2' then
    		pagename = 'Takao_(fog)'
    	elseif string.sub(id, -1) == '3' then
    		pagename = 'Haruna_(fog)'
		else
			pagename = 'Fleet of Fog'
		end
	else
		shipbasename = mw.text.split(shipname, '%s')[1]
		--Prinz/Graf/Teste check (for ship names that are 2 or more words)
		if mw.text.split(shipname, '%s')[2] ~= nil and not (mw.text.split(shipname, '%s')[2] == "Kai" or 
			mw.text.split(shipname, '%s')[2] == "A" or mw.text.split(shipname, '%s')[2] == "Zwei" or
			mw.text.split(shipname, '%s')[2] == "Drei" or mw.text.split(shipname, '%s')[2] == "Due") then
			shipbasename = shipbasename .. ' ' .. mw.text.split(shipname, '%s')[2]
		end
		pagename = shipbasename
	end
	return pagename
end

ShipList.KanmusuData = mw.loadData('Module:Data/Ship')

local shipdb = ShipList

local shipmodule = {}

shipmodule.data = shipdb.KanmusuData

local function getMarriedHp(hp, maxHp)
  return math.min(maxHp, hp + ({4, 4, 4, 5, 6, 7, 7, 8, 8, 9})[math.floor(hp / 10) + 1])
end

local function tooltip(content, title)
  return tostring(mw.html.create('span'):attr('title', title):addClass('explain'):wikitext(content))
end

function shipmodule.getIDNum(frame)
    local shipNum = frame.args[1]
    -- Getting ship ID, number, & info
    if (tonumber(string.sub(shipNum, 1, 3)) == nil and string.sub(shipNum, 1, 4) ~= "Mist" ) then -- if given a name instead of ID, this searches the db for the ship's corresponding ID
    	shipNum = shipdb.findID(frame)
    end
    return shipNum
end

function shipmodule.KanmusuInfo(frame) -- Kanmusu Info Template
    local shipNum = shipmodule.getIDNum(frame)
    local shipInfo = assert(shipmodule.data[shipNum], "KanMusu ID " .. shipNum .. " doesn't have a database entry")
    local upperTable = shipmodule.makeStatBox(frame)
    local DetailTable = shipmodule.EquipmentBox(frame) .. '<table style="width: 100%">' .. shipmodule.ModernizationBox(frame) .. shipmodule.getArtVoice(frame) .. '</table>'
    local shipInfoBox = '<div style="display: inline-block; vertical-align: top;"><table style="{{border-radius|10px 10px 10px 10px}} border: 1px solid #aaaaaa; min-width: 495px">'
    shipInfoBox = shipInfoBox .. '<tr><td>' .. upperTable .. '</td></tr>'
    shipInfoBox = shipInfoBox .. '<tr><td>' .. DetailTable .. '</td></tr></table></div>' .. shipmodule.createCategories(frame)
    return shipInfoBox
end

function shipmodule.makeStatBox(frame)
    local shipNum = shipmodule.getIDNum(frame)

    local shipInfo = assert(shipmodule.data[shipNum], "KanMusu ID " .. shipNum .. " doesn't have a database entry")

	local shipName = shipInfo.name[3]
    local CardImg = '<div style="text-align: center; width: 218px; height:300px;">[[File:{{#setmainimage:Ship Card ' .. shipName .. '.png}}|218x300px|' .. shipName .. ' Card]]</div>'
    local CardDmgImg = '<div style="text-align: center; width: 218px; height:300px;">[[File:Ship Card ' .. shipName .. ' Damaged.png|218x300px|' .. shipName .. ' Damaged Card]]</div>'
    local BannerImg = '<div style="text-align: center; width: 160px; height:40px;">[[File:Ship Banner ' .. shipName .. '.png|160px|' .. shipName .. ' Banner|class=imageCenter]]</div>'
    local BannerDmgImg = '<div style="text-align: center; width: 160px; height:40px;">[[File:Ship Banner ' .. shipName .. ' Damaged.png|160px|' .. shipName .. ' Damaged Banner|class=imageCenter]]</div>'

    local Cards = '<td rowspan="10" style="text-align: center; width: 218px; height:300px;">' .. frame:extensionTag('slideshow', CardImg .. CardDmgImg, {
    	sequence = 'forward', transition = 'fade', refresh = '10000', center = 'true'
    }) .. '</td>'
    local Banners = '<td colspan="3" style="text-align: center; width: 160px; height:40px;">' .. frame:extensionTag('slideshow', BannerImg .. BannerDmgImg, {
    	sequence = 'forward', transition = 'fade', refresh = '10000', center = 'true'
    }) .. '</td>'

    local sortNo = shipInfo.sortno or U.split(shipNum, '-')[1] or '?'
    local row1 = '<tr>' .. Cards .. '<th style="text-align: center;">' .. sortNo .. '</th>' .. Banners .. '</tr>'

    -- Formatting Japanese
    local kanji, form
	local formNum = mw.ustring.find(shipmodule.data[shipNum]["name"][1], "[乙改甲航]")
	if formNum == nil then 
		if mw.ustring.find(shipmodule.data[shipNum]["name"][1], "%szwei") ~= nil then
			formNum = mw.ustring.find(shipmodule.data[shipNum]["name"][1], "%szwei")
			kanji = mw.ustring.sub(shipmodule.data[shipNum]["name"][1], 1, formNum - 1)
			form = "&#32;zwei"
		elseif mw.ustring.find(shipmodule.data[shipNum]["name"][1], "%sdrei") ~= nil then
			formNum = mw.ustring.find(shipmodule.data[shipNum]["name"][1], "%sdrei")
			kanji = mw.ustring.sub(shipmodule.data[shipNum]["name"][1], 1, formNum - 1)
			form = "&#32;drei"
		elseif mw.ustring.find(shipmodule.data[shipNum]["name"][1], "%sdue") ~= nil then
			formNum = mw.ustring.find(shipmodule.data[shipNum]["name"][1], "%sdue")
			kanji = mw.ustring.sub(shipmodule.data[shipNum]["name"][1], 1, formNum - 1)
			form = "&#32;due"
		elseif mw.ustring.find(shipmodule.data[shipNum]["name"][1], "%sдва") ~= nil then
			formNum = mw.ustring.find(shipmodule.data[shipNum]["name"][1], "%sдва")
			kanji = mw.ustring.sub(shipmodule.data[shipNum]["name"][1], 1, formNum - 1)
			form = "&#32;два"
		elseif mw.ustring.find(shipmodule.data[shipNum]["name"][1], "%sMk.II") ~= nil then
            if mw.ustring.find(shipmodule.data[shipNum]["name"][1], "%sMk.II Mod.2") ~= nil then
                formNum = mw.ustring.find(shipmodule.data[shipNum]["name"][1], "%sMk.II Mod.2")
			    kanji = mw.ustring.sub(shipmodule.data[shipNum]["name"][1], 1, formNum - 1)
			    form = "&#32;Mk.II Mod.2"
            else
			    formNum = mw.ustring.find(shipmodule.data[shipNum]["name"][1], "%sMk.II")
			    kanji = mw.ustring.sub(shipmodule.data[shipNum]["name"][1], 1, formNum - 1)
			    form = "&#32;Mk.II"
                end
		elseif mw.ustring.find(shipmodule.data[shipNum]["name"][1], "%sреволюция") ~= nil then -- Gangut "Kai" exception
			kanji = mw.text.split(shipmodule.data[shipNum]["name"][1], "%s")[1] .. '<br/>' .. mw.text.split(shipmodule.data[shipNum]["name"][1], "%s")[2]
			form = ""
		else
			kanji = shipmodule.data[shipNum]["name"][1]
			form = ""
		end
	else
		kanji = mw.ustring.sub(shipmodule.data[shipNum]["name"][1], 1, formNum - 1)
		form = mw.ustring.sub(shipmodule.data[shipNum]["name"][1], formNum , -1)
	end
	
	local JaName = ""
	if shipNum == "147" or shipNum == "311" or shipNum == "312" or shipNum == "313" or shipNum == "313a" or shipNum == "316" then --Russian ship markup
		JaName = '<ruby lang="ru" xml:lang="ru"><rb>' .. kanji .. '</rb><rp> (</rp><rt lang="ja">' .. shipmodule.data[shipNum]["name"][2] .. '</rt><rp>) </rp></ruby>' .. frame:expandTemplate{ title = 'lang', args = { 'ru' , form } }
	else
		JaName = frame:expandTemplate{ title = 'ruby-ja', args = { kanji , shipmodule.data[shipNum]["name"][2] } } .. frame:expandTemplate{ title = 'lang', args = { 'ja' , form } }
	end

    -- Summary of basic ship info
    local row2 = '<tr><th colspan="2">' .. JaName .. '</th><th colspan="2">' .. shipmodule.data[shipNum]["name"][3] .. '</th></tr>'
    local row3 = '<tr><td colspan="4" style="text-align: center;">' .. shipmodule.data[shipNum]["class"] .. ' Class ' .. shipmodule.data[shipNum]["type"] .. '</td></tr>'
    local row4 = '<tr><td colspan="4"><hr style="border: 0; height: 1px; background-image: linear-gradient(to right, rgba(0,0,0,0), rgba(0,0,0,0.75), rgba(0,0,0,0));" /></td></tr>'

    -- Ship stats table
    local statLabel = '<th style="width: 65px; {{border-radius|12px 4px 4px 12px}} padding-left: 5px; padding-right: 5px; background-color: #eae1d1; color: #a3965c; text-align: right; vertical-align: baseline;">'
    local statBox = '<td style="{{border-radius|4px 12px 12px 4px}} padding-left: 5px; padding-right: 5px; border: 1px solid #a3965c; text-align: left; vertical-align: baseline;">'

    local hp = shipmodule.data[shipNum]["hp"][1]
    local maxHp = shipmodule.data[shipNum]["hp"][2]
    local HPinfo
    if maxHp then
      local marriedHp = getMarriedHp(hp, maxHp)
      local maxModHp = math.min(hp + 2, maxHp)
      local maxModMarriedHp = math.min(marriedHp + 2, maxHp)
      local hpSpan1 = tooltip(hp, string.format('%d with DE modernization', maxModHp))
      local hpSpan2 = tooltip(marriedHp, string.format('Married, %d with DE modernization', maxModMarriedHp))
      HPinfo = statLabel .. 'HP [[File:IcoHP.png|HP]]</th>' .. statBox .. hpSpan1 .. '→' .. hpSpan2 .. '</td>'
    else
      HPinfo = statLabel .. 'HP [[File:IcoHP.png|HP]]</th>' .. statBox .. hp .. '</td>'
    end

    local FPinfo = statLabel .. 'FP [[File:IcoAtk.png|Firepower]]</th>' .. statBox .. shipmodule.data[shipNum]["fp"][1] .. '→' .. shipmodule.data[shipNum]["fp"][2] .. '</td>'

    local row5 = '<tr>' .. HPinfo .. FPinfo .. '</tr>'

    -- Armor & Torpedo
    local Armorinfo = statLabel .. 'ARM [[File:IcoArmor.png|Armor]]</th>' .. statBox .. shipmodule.data[shipNum]["armor"][1] .. '→' .. shipmodule.data[shipNum]["armor"][2] .. '</td>'
    local Torpedoinfo = statLabel .. 'TORP [[File:IcoTorpedo.png|Torpedo]]</th>' .. statBox
    if shipmodule.data[shipNum]["torpedo"] == 0 then
        Torpedoinfo = Torpedoinfo .. shipmodule.data[shipNum]["torpedo"]
    else
        Torpedoinfo = Torpedoinfo .. shipmodule.data[shipNum]["torpedo"][1] .. '→' .. shipmodule.data[shipNum]["torpedo"][2]
    end

    local row6 = '<tr>' .. Armorinfo .. Torpedoinfo .. '</tr>'

    -- Evasion & AA
    local Evasioninfo = statLabel .. 'EVA [[File:IcoEvasion.png|Evasion]]</th>' .. statBox .. shipmodule.data[shipNum]["evasion"][1] .. '→' .. shipmodule.data[shipNum]["evasion"][2] .. '</td>'
    local AAinfo = statLabel .. 'AA [[File:IcoAA.png|Anti-Air]]</th>' .. statBox
    if shipmodule.data[shipNum]["aa"] == 0 then
        AAinfo = AAinfo .. shipmodule.data[shipNum]["aa"]
    else
        AAinfo = AAinfo .. shipmodule.data[shipNum]["aa"][1] .. '→' .. shipmodule.data[shipNum]["aa"][2]
    end

    local row7 = '<tr>' .. Evasioninfo .. AAinfo .. '</tr>'

    -- Planes & ASW
    local aircraftTotal = shipdb.TotalAircraft(frame)
    local Planeinfo = statLabel .. 'PLA [[File:IcoAircraft.png|Aircraft]]</th>' .. statBox .. aircraftTotal .. '</td>'
    local ASWinfo = statLabel .. 'ASW [[File:IcoASW.png|Anti-Submarine Warfare]]</th>' .. statBox
    if shipmodule.data[shipNum]["asw"] == 0 then
        ASWinfo = ASWinfo .. shipmodule.data[shipNum]["asw"]
    else
        ASWinfo = ASWinfo .. shipmodule.data[shipNum]["asw"][1] .. '→' .. shipmodule.data[shipNum]["asw"][2]
    end

    local row8 = '<tr>' .. Planeinfo .. ASWinfo .. '</tr>'

    -- Speed & LOS
    local Speedinfo = statLabel .. 'SPD [[File:IcoSpeed.png|Speed]]</th>' .. statBox .. shipmodule.data[shipNum]["spd"] .. '</td>'
    local LOSinfo = statLabel .. 'LOS [[File:IcoLOS.png|Line of Sight]]</th>' .. statBox .. shipmodule.data[shipNum]["los"][1] .. '→' .. shipmodule.data[shipNum]["los"][2] .. '</td>'

    local row9 = '<tr>' .. Speedinfo .. LOSinfo .. '</tr>'

    -- Range & Luck
    local Rangeinfo = statLabel .. 'RGE [[File:IcoRange.png|Range]]</th>' .. statBox .. shipmodule.data[shipNum]["range"] .. '</td>'
    local Luckinfo = statLabel .. 'LUK [[File:IcoLuck.png|Luck]]</th>' .. statBox .. shipmodule.data[shipNum]["luck"][1] .. '→' .. shipmodule.data[shipNum]["luck"][2] .. '</td>'

    local row10 = '<tr>' .. Rangeinfo .. Luckinfo .. '</tr>'
    local StatTable = '<table>' .. row1 .. row2 .. row3 .. row4 .. row5 .. row6 .. row7 .. row8 .. row9 .. row10 .. '</table>'
    return StatTable
end

function shipmodule.EquipmentBox(frame)
    local shipNum = shipmodule.getIDNum(frame)

    local shipInfo = assert(shipmodule.data[shipNum], "KanMusu ID " .. shipNum .. " doesn't have a database entry")

    -- Equipment table
    local equipHeader = ''
    local planeStyle = '<td style="width: 25%; white-space: nowrap; text-align: center; vertical-align: top;">'
    local equipStyle = ''
    if shipmodule.data[shipNum]["aircraft"] ~= "" then
        equipHeader1 = '<th style="width: 25%; white-space: nowrap; {{border-radius|12px 4px 4px 12px}} background-color: #efe6d7; color: #a3965c;">Aircraft</th>'
        equipHeader2 = '<th style="width: 75%; white-space: nowrap; {{border-radius|4px 12px 12px 4px}} background-color: #efe6d7; color: #a3965c; vertical-align: baseline;">Equipment</th>'
        equipHeader = equipHeader1 .. equipHeader2
        equipStyle = '<td style="width: 75%; max-width: 375px; text-align: center; vertical-align: baseline;">'
    else
        equipHeader = '<th style="white-space: nowrap; {{border-radius|12px 12px 12px 12px}} background-color: #efe6d7; color: #a3965c; vertical-align: baseline;">Equipment</th>'
        equipStyle = '<td style="white-space: nowrap; text-align: center; vertical-align: baseline;">'
    end

	local numRows = math.max(4, U.isize(shipmodule.data[shipNum]["equip"]))
    local equipTable = ''
    for i = 1, numRows, 1 do
    	local equipRow = '<tr>'
        if shipmodule.data[shipNum]["aircraft"] ~= "" then
        	if shipmodule.data[shipNum]["aircraft"][i] ~= nil then
        		equipRow = equipRow .. planeStyle .. shipmodule.data[shipNum]["aircraft"][i] .. '</td>' .. equipStyle
    		else
    			equipRow = equipRow .. planeStyle .. '</td>' .. equipStyle
    		end
            if shipmodule.data[shipNum]["equip"] ~= "" then
                if shipmodule.data[shipNum]["equip"][i] == "" or shipmodule.data[shipNum]["equip"][i] == "Unequipped" then
                    equipRow = equipRow .. '-Unequipped-</td></tr>'
                elseif shipmodule.data[shipNum]["equip"][i] == nil then
                    equipRow = equipRow .. '\'\'-Locked-\'\'</td></tr>'
                else
                    if string.find(shipmodule.data[shipNum]["equip"][i], "%★") then
                        a,b = string.match(shipmodule.data[shipNum]["equip"][i], "^(.+)★(.+)$")
                        equipRow = equipRow .. '[[' .. a .. '|' .. a .. '★' .. b .. ']]</td></tr>'
                    else
                        equipRow = equipRow .. '[[' .. shipmodule.data[shipNum]["equip"][i] .. ']]</td></tr>'
                    end
                end
            else
                equipRow = equipRow .. '\'\'-Locked-\'\'</td></tr>'
            end
        else
            equipRow = equipRow .. equipStyle
            if shipmodule.data[shipNum]["equip"] ~= "" then
                if shipmodule.data[shipNum]["equip"][i] == "" or shipmodule.data[shipNum]["equip"][i] == "Unequipped" then
                    equipRow = equipRow .. '-Unequipped-</td></tr>'
                elseif shipmodule.data[shipNum]["equip"][i] == nil then
                    equipRow = equipRow .. '\'\'Locked\'\'</td></tr>'
                else
                    if string.find(shipmodule.data[shipNum]["equip"][i], "%★") then
                        a,b = string.match(shipmodule.data[shipNum]["equip"][i], "^(.+)★(.+)$")
                        equipRow = equipRow .. '[[' .. a .. '|' .. a .. '★' .. b .. ']]</td></tr>'
                    else
                        equipRow = equipRow .. '[[' .. shipmodule.data[shipNum]["equip"][i] .. ']]</td></tr>'
                    end
                end
            else
                equipRow = equipRow .. '\'\'Locked\'\'</td></tr>'
            end
        end
        equipTable = equipTable .. equipRow
    end
    return '<table style="width: 100%">' .. equipHeader .. equipTable .. '</table>'
end

function shipmodule.ModernizationBox(frame)
    local shipNum = shipmodule.getIDNum(frame)
    local shipInfo = assert(shipmodule.data[shipNum], "KanMusu ID " .. shipNum .. " doesn't have a database entry")

    local RscHeader = '<th style="width: 25%; white-space: nowrap; {{border-radius|12px 4px 4px 12px}} background-color: #3baef5; color: #ffffff; padding-left: 5px; padding-right: 5px; text-align: right;">'
    local RscData = '<td style="width: 25%; white-space: nowrap; text-align: center;">'
    local RscData2 = '<td colspan="3" style="width: 75%; white-space: nowrap; text-align: center;">'

    -- Construction info
    local constrheader = ''
    local constrdata = ''

    if shipInfo["remodellv"] ~= nil and shipInfo["remodellv"] ~= "" then
        constrheader = 'Remodel Level'
        constrdata = shipInfo["remodellv"]
    else
        constrheader = 'Build Time'
        if shipInfo["buildtime"] == nil or shipInfo["buildtime"] == "" then
            constrdata = 'Not Buildable'
        else
            constrdata = shipInfo["buildtime"]
        end
    end

    local remodelinfo = ''
    if shipInfo.remodelreq and shipInfo.remodelreq ~= '' then
        remodelinfo = string.format('[[File:IcoSteel.png|18px|Steel]] %d [[File:IcoAmmo.png|18px|Ammo]] %d', shipInfo.remodelreq[1], shipInfo.remodelreq[2])
        if shipInfo.remodelbp then
          remodelinfo = remodelinfo .. ' ' .. string.format('[[File:Item Icon Remodel Blueprint.png|25px|Blueprint|link=Blueprints]] %d', shipInfo.remodelbp)
        end
        if shipInfo.remodelcatapult then
          remodelinfo = remodelinfo .. ' ' .. string.format('[[File:Item Icon Prototype Flight Deck Catapult.png|25px|Prototype Flight Deck Catapult]] %d', shipInfo.remodelcatapult)
        end
        if shipInfo.remodelar then
          remodelinfo = remodelinfo .. ' ' .. string.format('[[File:Item Icon Action Report.png|25px|Action Report]] %d', shipInfo.remodelar)
        end
        if shipInfo.remodeldevmat or shipInfo.remodelconmat or shipInfo.remodelgunmat or shipInfo.remodelairmat then
          remodelinfo = remodelinfo .. '<br>'
        end
        if shipInfo.remodeldevmat then
          remodelinfo = remodelinfo .. ' ' .. string.format('[[File:IcoDevmat.png|18px|Development Material]] %d', shipInfo.remodeldevmat)
        end
        if shipInfo.remodelconmat then
          remodelinfo = remodelinfo .. ' ' .. string.format('[[File:IcoConmat.png|18px|Construction Material]] %d', shipInfo.remodelconmat)
        end
        if shipInfo.remodelgunmat then
          remodelinfo = remodelinfo .. ' ' .. string.format('[[File:Item Icon New Model Gun Mount Improvement Material.png|18px|New Model Gun Mount Improvement Material]] %d', shipInfo.remodelgunmat)
        end
        if shipInfo.remodelairmat then
          remodelinfo = remodelinfo .. ' ' .. string.format('[[File:Item Icon New Model Aerial Armament Material.png|18px|New Model Aerial Armament Material]] %d', shipInfo.remodelairmat)
        end
        if shipInfo.remodelarmmat then
          remodelinfo = remodelinfo .. ' ' .. string.format('[[File:Item Icon New Model Armament Material.png|18px|New Model Armament Material]] %d', shipInfo.remodelarmmat)
        end
    end
    
    -- Construction & Remodel
    local row11 = ''
    if constrheader == 'Build Time' then
        row11 = '<tr>' .. RscHeader .. constrheader .. '</th>' .. RscData .. constrdata .. '</td><td colspan="2">&nbsp;</td></tr>'
    else
        row11 = '<tr>' .. RscHeader .. constrheader .. '</th>' .. RscData .. constrdata .. '</td>' .. RscHeader .. 'Remodel Req</th>' .. RscData .. remodelinfo .. '</td></tr>'
    end

    -- Consumption
    local consfuel = '[[File:IcoFuel.png|18px|Fuel]] ' .. shipInfo["consumption"][1]
    local consammo = '[[File:IcoAmmo.png|18px|Ammo]] ' .. shipInfo["consumption"][2]

    local row12 = '<tr>' .. RscHeader .. 'Consumption</th>' .. RscData .. consfuel .. ' ' .. consammo .. '</td>'

    -- Scrap Info
    local scrapfuel = '[[File:IcoFuel.png|18px|Fuel]] ' .. shipInfo["dismantle"][1]
    local scrapammo = '[[File:IcoAmmo.png|18px|Ammo]] ' .. shipInfo["dismantle"][2]
    local scrapsteel = '[[File:IcoSteel.png|18px|Steel]] ' .. shipInfo["dismantle"][3]
    local scrapbauxite = '[[File:IcoBauxite.png|18px|Bauxite]] ' .. shipInfo["dismantle"][4]
    local scrapinfo = scrapfuel .. ' ' .. scrapammo .. ' ' .. scrapsteel .. ' ' .. scrapbauxite
    local row12 = row12 .. RscHeader .. 'Dismantle</th>' .. RscData .. scrapinfo .. '</td></tr>'

    -- Modernization
    local modFP = '[[File:IcoAtkRemodel.png|25px|Firepower]] ' .. shipInfo["modernization"][1]
    local modTorp = '[[File:IcoTorpedoRemodel.png|25px|Torpedo]] ' .. shipInfo["modernization"][2]
    local modAA = '[[File:IcoAARemodel.png|25px|Anti-Air]] ' .. shipInfo["modernization"][3]
    local modArmor = '[[File:IcoArmorRemodel.png|25px|Armor]] ' .. shipInfo["modernization"][4]
    local modLuck = ''
    if shipInfo["modernization"][5] ~= nil and shipInfo["modernization"][5] ~= "" then
        -- modLuck = '[[File:IcoLuck|18px|Luck]] ' .. shipInfo["modernization"][5]
        modLuck = '[[File:IcoLuckRemodel.png|25px|Luck]] ' .. shipInfo["modernization"][5] -- Just a placeholder
    end

    local modInfo = modFP .. ' ' .. modTorp .. ' ' .. modAA .. ' ' .. modArmor
    if modLuck ~= '' then
        modInfo = modInfo .. ' ' .. modLuck
    end
    local row13 = '<tr>' .. RscHeader .. 'Modernization</th>' .. RscData2 .. modInfo .. '</td></tr>'
    -- return '<table style="width: 100%">' .. row13 .. row11 .. row12 .. '</table>'
    return row13 .. row11 .. row12
end

function shipmodule.getArtVoice(frame)
    local shipNum = shipmodule.getIDNum(frame)
    local shipInfo = assert(shipmodule.data[shipNum], "KanMusu ID " .. shipNum .. " doesn't have a database entry")
    local RscHeader = '<th style="width: 25%; white-space: nowrap; {{border-radius|12px 4px 4px 12px}} background-color: #3baef5; color: #ffffff; padding-left: 5px; padding-right: 5px; text-align: right;">'
    local RscData = '<td style="width: 25%; white-space: nowrap; text-align: center;">'
    local illustrator = ''
    local voiceactor = ''
    if shipmodule.data[shipNum]["artist"] ~= "Unknown" and shipmodule.data[shipNum]["artist"] ~= "" then
        illustrator = '[[:Category:' .. shipmodule.data[shipNum]["artist"] .. '|' .. shipmodule.data[shipNum]["artist"] .. ']]'
    else
        illustrator = 'Unknown'
    end
    art = RscHeader .. 'Artist</th>' .. RscData .. illustrator .. '</td>'
    if shipmodule.data[shipNum]["seiyuu"] ~= "Unknown" and shipmodule.data[shipNum]["seiyuu"] ~= "" then
        voiceactor = '[[:Category:' .. shipmodule.data[shipNum]["seiyuu"] .. '|' .. shipmodule.data[shipNum]["seiyuu"] .. ']]'
    else
        voiceactor = 'Unknown'
    end
    voice = RscHeader .. 'Seiyuu</th>' .. RscData .. voiceactor .. '</td>'
    --local row14 = '<table style="width: 100%">' .. art .. voice .. '</table>'
    return art .. voice
end

function shipmodule.createCategories(frame)
	local shipNum = shipmodule.getIDNum(frame)
	
    local shipInfo = assert(shipmodule.data[shipNum], "KanMusu ID " .. shipNum .. " doesn't have a database entry")

	local cat = '[[Category:Ships]]'
	cat = cat .. '[[Category:' .. shipmodule.data[shipNum]["class"] .. ' Class]][[Category:' .. shipmodule.data[shipNum]["type"] .. 's]]'
	if shipmodule.data[shipNum]["artist"] ~= "Unknown" and shipmodule.data[shipNum]["artist"] ~= "" then
	       cat = cat .. '[[Category:' .. shipmodule.data[shipNum]["artist"] .. ']]'
    end
    if shipmodule.data[shipNum]["seiyuu"] ~= "Unknown" and shipmodule.data[shipNum]["seiyuu"] ~= "" then
        cat = cat .. '[[Category:' .. shipmodule.data[shipNum]["seiyuu"] .. ']]'
    end
	return cat
end

function shipmodule.KanmusuList(frame)
    local shipType = frame.args[1]
    local shipListTable = '<table class="wikitable filterable sortable" style="width: 100%; min-width: 800px;"><tr>'
    shipListTable = shipListTable .. '<th style="text-align: center; background-color: SpringGreen;" class="unfilterable" data-sort-type="number">ID</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; background-color: SpringGreen;" class="unfilterable unsortable">Name</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; background-color: SpringGreen;" class="unfilterable unsortable">Class</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; background-color: SpringGreen;" class="unsortable">Type</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; vertical-align: middle; background-color: LightCoral;" class="unfilterable">[[File:IcoAtk.png|Firepower]]</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; vertical-align: middle; background-color: LightSkyBlue;" class="unfilterable">[[File:IcoTorpedo.png|Torpedo]]</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; vertical-align: middle; background-color: SandyBrown;" class="unfilterable">[[File:IcoAA.png|Anti-Air]]</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; vertical-align: middle; background-color: Seashell;" class="unfilterable">[[File:IcoASW.png|Anti-Submarine Warfare]]</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; vertical-align: middle; background-color: Aquamarine;" class="unfilterable">[[File:IcoLOS.png|Line of Sight]]</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; vertical-align: middle; background-color: PaleGreen;" class="unfilterable">[[File:IcoLuck.png|Luck]]</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; vertical-align: middle; background-color: Pink;" class="unfilterable">[[File:IcoHP.png|HP]]</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; vertical-align: middle; background-color: Yellow;" class="unfilterable">[[File:IcoArmor.png|Armor]]</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; vertical-align: middle; background-color: Violet;" class="unfilterable">[[File:IcoEvasion.png|Evasion]]</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; vertical-align: middle; background-color: Silver;" class="unfilterable">[[File:IcoAircraft.png|Aircraft]]</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; vertical-align: middle; background-color: Aqua;" class="unsortable">[[File:IcoSpeed.png|Speed|link=]]</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; background-color: SpringGreen;" class="unsortable">[[File:IcoRange.png|Range|link=]]</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; background-color: SpringGreen;" class="unfilterable">[[File:IcoFuel.png|Fuel Consumption]]</th>'
    shipListTable = shipListTable .. '<th style="text-align: center; background-color: SpringGreen;" class="unfilterable">[[File:IcoAmmo.png|Ammo Consumption]]</th></tr>'
    local IDList = shipdb.getSortedIDList()
    for num, id in pairs(IDList) do
        if shipType ~= nil then
            if shipType == shipmodule.data[id]["type"] then
                shipListTable = shipListTable .. shipmodule.KanmusuListEntry(id, frame.args[2] ~= nil)
            end
        else
            shipListTable = shipListTable .. shipmodule.KanmusuListEntry(id, frame.args[2] ~= nil)
        end
    end
    shipListTable = shipListTable .. '</table>'
    return shipListTable
end

function shipmodule.KanmusuListEntry(id, printMax) -- Kanmusu List Table
    local strings = '<tr>'
    local aircraftTotal = 0
    if shipmodule.data[id]["aircraft"] ~= "" then
    	local aircraftslot = {0, 0, 0, 0}
        for i = 1, 4, 1 do
            if shipmodule.data[id]["aircraft"][i] ~= nil then
                aircraftslot[i] = shipmodule.data[id]["aircraft"][i]
            else
                aircraftslot[i] = 0
            end
        end
        aircraftTotal = aircraftslot[1] + aircraftslot[2] + aircraftslot[3] + aircraftslot[4]
    else
        aircraftTotal = 0
    end
    
    --finding name of wiki page of ship
    shipname = shipmodule.data[id]["name"][3]
    pagename = shipname
    if string.sub(id,1,-2) == "Mist" then   -- fleet of fog check
    	if string.sub(id, -1) == '1' then
    		pagename = 'Iona_(fog)'
    	elseif string.sub(id, -1) == '2' then
    		pagename = 'Takao_(fog)'
    	elseif string.sub(id, -1) == '3' then
    		pagename = 'Haruna_(fog)'
		else
			pagename = 'Fleet of Fog'
		end
	else
		shipbasename = mw.text.split(shipname, '%s')[1]
		--Chitose/Chiyoda-Kou check; submarines should be unaffected
		if mw.text.split(shipbasename, '%p')[2] ~= nil and mw.text.split(shipbasename, '%p')[2] == "Kou" then
			shipbasename = mw.text.split(shipbasename, '%p')[1]
		end
		--Prinz/Graf/Teste check (for ship names that are 2 or more words)
		if mw.text.split(shipname, '%s')[2] ~= nil and not (mw.text.split(shipname, '%s')[2] == "Kai" or 
			mw.text.split(shipname, '%s')[2] == "A" or mw.text.split(shipname, '%s')[2] == "zwei" or
			mw.text.split(shipname, '%s')[2] == "drei" or mw.text.split(shipname, '%s')[2] == "Due" or
			mw.text.split(shipname, '%s')[2] == "Dva") then
			shipbasename = shipbasename .. ' ' .. mw.text.split(shipname, '%s')[2]
		end
		pagename = shipbasename
	end

    statLevel = 1 --base stat
    if printMax then
		statLevel = 2 --max stat
	end
	
    strings = strings .. '<td style="text-align: center;">' .. id .. '</td>'
    strings = strings .. '<td style="text-align: center;">[[' .. pagename .. '|' .. shipname ..']]</td>'
    strings = strings .. '<td style="text-align: center;">' .. shipmodule.data[id]["class"] .. '</td>'
    strings = strings .. '<td style="text-align: center;">' .. shipmodule.data[id]["type"] .. '</td>'
    strings = strings .. '<td style="text-align: center; background-color: #f0bbbb;">' .. shipmodule.data[id]["fp"][statLevel] .. '</td>'
    if shipmodule.data[id]["torpedo"] == 0 then
        strings = strings .. '<td style="text-align: center; background-color: #99eefa;">' .. shipmodule.data[id]["torpedo"] .. '</td>'
    else
        strings = strings .. '<td style="text-align: center; background-color: #99eefa;">' .. shipmodule.data[id]["torpedo"][statLevel] .. '</td>'
    end
    if shipmodule.data[id]["aa"] == 0 then
        strings = strings .. '<td style="text-align: center; background-color: #faccaa;">' .. shipmodule.data[id]["aa"] .. '</td>'
    else
        strings = strings .. '<td style="text-align: center; background-color: #faccaa;">' .. shipmodule.data[id]["aa"][statLevel] .. '</td>'
    end
    if shipmodule.data[id]["asw"] == 0 then
        strings = strings .. '<td style="text-align: center; background-color: #fff5ee;">' .. shipmodule.data[id]["asw"] .. '</td>'
    else
        strings = strings .. '<td style="text-align: center; background-color: #fff5ee;">' .. shipmodule.data[id]["asw"][statLevel] .. '</td>'
    end
    strings = strings .. '<td style="text-align: center; background-color: #afffee;">' .. shipmodule.data[id]["los"][statLevel] .. '</td>'
    strings = strings .. '<td style="text-align: center; background-color: #cbfbcb;">' .. shipmodule.data[id]["luck"][statLevel] .. '</td>'
    strings = strings .. '<td style="text-align: center; background-color: #ffe0eb;">' .. shipmodule.data[id]["hp"][statLevel] .. '</td>'
    strings = strings .. '<td style="text-align: center; background-color: #ffffaa;">' .. shipmodule.data[id]["armor"][statLevel] .. '</td>'
    strings = strings .. '<td style="text-align: center; background-color: #eeccee;">' .. shipmodule.data[id]["evasion"][statLevel] .. '</td>'
    strings = strings .. '<td style="text-align: center; background-color: #d9d9d9;">' .. aircraftTotal .. '</td>'
    strings = strings .. '<td style="text-align: center; background-color: #aaffff;">' .. shipmodule.data[id]["spd"] .. '</td>'
    strings = strings .. '<td style="text-align: center;">' .. shipmodule.data[id]["range"] .. '</td>'
    strings = strings .. '<td style="text-align: center;">' .. shipmodule.data[id]["consumption"][1] .. '</td>'
    strings = strings .. '<td style="text-align: center;">' .. shipmodule.data[id]["consumption"][2] .. '</td></tr>'
    return strings
end

local function numToID(num)
	return num < 10 and "00" .. num or num < 100 and "0" .. num or tostring(num)
end

function shipmodule.CardList()
	firstID = 1
	maxID = -1
	for KanMusuID, KanMusuData in pairs(shipmodule.data) do
		if tonumber(KanMusuID) ~= nil and tonumber(KanMusuID) > maxID then
			maxID = tonumber(KanMusuID)
		end
	end
	IDRange = math.ceil(maxID / 10) * 10
	wikipage = ""
	while firstID < IDRange do
		wikipage = wikipage .. "<h2>No. " .. tostring(firstID) .. "-" .. tostring(firstID+9) .. "</h2>"
		for i = 0, 9 do
			x = firstID + i
			shipID = numToID(x)
			if not shipmodule.data[shipID] then
				wikipage = wikipage .. "[[File:blank.png|150px]]"
			else
				local shipName = shipmodule.data[shipID].name[3]
				wikipage = wikipage .. "[[File:Ship Card " .. shipName .. ".png|150px|link=" .. shipdb.getWikiPage(shipID) .. "]]"
			end
			if x % 5 == 0 then
				wikipage = wikipage .. "<br>"
			end
		end
		wikipage = wikipage .. "<br>"
		firstID = firstID + 10
	end
	return wikipage
end

return shipmodule