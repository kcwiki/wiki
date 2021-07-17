local U = require('Module:Core')
local format = U.format
local getArgs = require('Module:GetArgs')
local Ship = require('Module:Ship')

-- <span class="toggle" data-target="ship-quotes" data-default="show" style="float:right;cursor:pointer;color:#006cb0;font-weight:bold"><span class="toggle-show">[Collapse]</span><span class="toggle-hide">[Expand]</span></span>
-- toggle-target-ship-quotes

local templates = {
    header = [[{| class="wikitable" style="width:100%;"
! style="width:10%;" | Event
!Japanese
!English
! style="${note_style}" | Note]],
    footer = "|}",
    audio_file = "${ship}${suffix}-${line}.ogg",
    audio_file_new = "Ship Voice ${ship} ${line}.ogg",
    audio_button = [=[<span class="audio-button">[[File:${audio_file}|Play]]</span>]=],
    line_link = "[${link} ${line}]",
    remodel_row_style = [[style="border-left: 15px solid #aaa;"]],
    spoiler = [[<span style="background-color:#3a3a3a;color:#3a3a3a">${text}</span>]],
    incomplete_style = "background:#fee;",
    incomplete_category = U.category("Ship pages with incomplete quotes"),
    row = [=[|- ${style} class="shipquote" data-shipquote-id="${id}" data-shipquote-form="${form}"
| nowrap="nowrap" |${audio_button} ${line}
| colspan="${ja_colspan}" style="${ja_style}" class="shipquote-ja" |<span lang="ja" style="font-family: sans-serif;">${ja}</span>
${en_cell}|${note}]=],
    note = [[|-
| colspan="5" |　⇧ ${note}]],
}

local lines = {
    { name = "Introduction", id = 1 },
    { name = "Library", id = 25 },
    { name = "Secretary 1", id = 2 },
    { name = "Secretary 2", id = 3 },
    { name = "Secretary 3", id = 4 },
    { name = "Idle", extra = true, id = 29 },
    { name = "Secretary Married", spoiler = true, id = 28 },
    { name = "Wedding", spoiler = true, id = 24 },
    { name = "Looking At Scores", id = 8 },
    { name = "Joining A Fleet", id = 13 },
    { name = "Equipment 1", id = 9 },
    { name = "Equipment 2", id = 10 },
    { name = "Equipment 3", note = "shared with expedition selection, resource collection, instant repair and development", id = 26 },
    { name = "Supply", id = 27 },
    { name = "Docking Minor", id = 11 },
    { name = "Docking Major", id = 12 },
    { name = "Docking Complete", extra = true, id = 6 },
    { name = "Construction", id = 5 },
    { name = "Returning From Sortie", id = 7 },
    { name = "Starting A Sortie", id = 14 },
    { name = "Battle Start", id = 15 },
    { name = "Air Battle", extra = true, id = 17 },
    { name = "Attack", note = "shared with [[Combat#Artillery_Spotting|day]]/[[Combat#Night_Special_Attack_Modifier|night]] special attacks, [[Expedition#Support_expedition|support expedition team]] arrival", id = 16 },
    { name = "Special 1", extra = true, id = 900 },
    { name = "Special 2", extra = true, id = 901 },
    { name = "Special 3", extra = true, id = 902 },
    { name = "Special 4", extra = true, id = 903 },
    { name = "Night Battle", id = 18 },
    { name = "Night Attack", extra = true, id = 17, note = "shared with air battle", note_types = { 14 } },
    { name = "MVP", id = 23 },
    { name = "Minor Damage 1", id = 19 },
    { name = "Minor Damage 2", id = 20 },
    { name = "Major Damage", id = 21 },
    { name = "Sunk", spoiler = true, id = 22 },
}

local migrated = {
    ["Umikaze Kai Ni"] = true,
    ["Mikura"] = true,
    ["Mikura Kai"] = true,
    ["Grecale"] = true,
    ["Grecale Kai"] = true,
    ["Duca degli Abruzzi"] = true,
    ["Duca degli Abruzzi Kai"] = true,
    ["Janus"] = true,
    ["Janus Kai"] = true,
    ["Asashimo Kai Ni"] = true,
    ["Houston"] = true,
    ["Houston Kai"] = true,
    ["De Ruyter"] = true,
    ["De Ruyter Kai"] = true,
    ["Perth"] = true,
    ["Perth Kai"] = true,
    ["Shinshuu Maru"] = true,
    ["Shinshuu Maru Kai"] = true,
    ["Hirato"] = true,
    ["Hirato Kai"] = true,
    ["Atlanta"] = true,
    ["Atlanta Kai"] = true,
    ["Akishimo"] = true,
    ["Akishimo Kai"] = true,
    ["Yuubari Kai Ni"] = true,
    ["Yuubari Kai Ni Toku"] = true,
    ["Yuubari Kai Ni D"] = true,
    ["Okinami Kai Ni"] = true,
    ["Hiei Kai Ni C"] = true,
    ["Gotland Andra"] = true,
    ["Fletcher Mk.II"] = true,
    ["Jingei"] = true,
    ["Jingei Kai"] = true,
    ["Matsu"] = true,
    ["Matsu Kai"] = true,
    ["I-47"] = true,
    ["I-47 Kai"] = true,
    ["Usugumo"] = true,
    ["Usugumo Kai"] = true,
    ["Kaiboukan No.4"] = true,
    ["Kaiboukan No.4 Kai"] = true,
    ["South Dakota"] = true,
    ["South Dakota Kai"] = true,
    ["Hornet"] = true,
    ["Hornet Kai"] = true,
    ["Yashiro"] = true,
    ["Yashiro Kai"] = true,
    ["Helena"] = true,
    ["Helena Kai"] = true,
    ["Ariake"] = true,
    ["Ariake Kai"] = true,
    ["Kaga Kai Ni"] = true,
    ["Kaga Kai Ni Go"] = true,
    ["Dan Yang"] = true,
    ["Yukikaze Kai Ni"] = true,
    ["Akigumo Kai Ni"] = true,
    ["Scirocco"] = true,
    ["Scirocco Kai"] = true,
    ["Sheffield"] = true,
    ["Sheffield Kai"] = true,
    ["Washington"] = true,
    ["Washington Kai"] = true,
}

local audio_suffixes = {
    -- Remodel levels
    ["Kai"] = "Kai",
    ["Kai Ni"] = "Kai2",
    ["Kai Ni A"] = "Kai2A",
    ["Kai Ni B"] = "Kai2B",
    ["Kai Ni C"] = "Kai2C",
    ["Kai Ni D"] = "Kai2D",
    ["B Kai"] = "BKai",
    ["Kai B"] = "KaiB",
    ["D Kai"] = "DKai",
    ["A"] = "_A",
    ["Carrier"] = "Carrier",
    ["Carrier Kai"] = "CarrierKai",
    ["Carrier Kai Ni"] = "CarrierKai2",
    ["Andra"] = "Andra",
    -- Individual ship names
    ["Verniy"] = "Verniy",
    ["Ryuuhou"] = "Ryuuhou",
    ["Ryuuhou Kai"] = "RyuuhouKai",
    ["Ro-500"] = "Ro-500",
    ["Italia"] = "Italia",
    ["Taiyou"] = "Taiyou",
    ["Taiyou Kai"] = "TaiyouKai",
    ["Taiyou Kai Ni"] = "TaiyouKai2",
    ["Oktyabrskaya Revolyutsiya"] = "OktyabrskayaRevolyutsiya",
    ["UIT-25"] = "UIT-25",
    ["I-504"] = "I-504",
    -- Foreign alternatives to Kai Ni, etc.
    ["Zwei"] = "Zwei",
    ["Due"] = "Due",
    ["Dva"] = "Dva",
    ["Mk.II"] = "Mk.II",
    ["Mk.II Mod.2"] = "Mk.II Mod.2",
    ["Dan Yang"] = "Dan Yang",
}

function format_text(text, line)
    return text and line.spoiler and format{templates.spoiler, text = text} or text or ""
end

--[[
function isCarrier(base_ship_name, remodel)
    local ship = Ship(base_ship_name .. "/" .. (remodel or ""))
    return ship:type() == 11 or ship:type() == 16 or ship:type() == 18
end
]]--

-- Global variable, potentially altered by insertRow, checked by Quotes.ShipQuotes.
local complete = true

function insertRow(result, remodel, args, line, count, use_suffix, old)

    local ship = args.ship
    local suffix = audio_suffixes[remodel] or ""

    local remodel_string = remodel and remodel ~= "" and "/" .. remodel or ""
    
    local extra = line.extra

    if old then
        remodel_string = remodel_string .. "/Old"
        extra = true
    end

    local ja, en, note = args[line.name .. remodel_string], args[line.name .. remodel_string .. "/En"], args[line.name .. remodel_string .. "/Note"]
    local jaEn = args[line.name .. remodel_string .. "/Both"]
    local link = args[line.name .. remodel_string .. "/Link"]

    local same = args[line.name .. remodel_string .. "/Same"]
    if same then
        ja = ja or args[same .. remodel_string]
        en = en or args[same .. remodel_string .. "/En"]
        note = note or args[same .. remodel_string .. "/Note"]
        jaEn = jaEn or args[same .. remodel_string .. "/Both"]
        link = link or args[same .. remodel_string .. "/Link"]
    end

    local is_empty_pre_kai_line = not remodel and not ja and not en and not jaEn and (args[line.name .. "/Kai"] or args[line.name .. "/Kai/En"] or args[line.name .. "/Kai/Both"])

    --[[
    if line.name == "Night Attack" then
         line.extra = isCarrier(args.ship, remodel)
    elseif line.name == "Air Battle" then
         line.extra = not isCarrier(args.ship, remodel)
    end
    ]]--

    if (not remodel and not extra or jaEn or ja or en or note) and not is_empty_pre_kai_line then
        local line_name = count == 0 and (remodel and line.name .. " (" .. remodel .. ")" or line.name) or remodel or line.name
        if old then
             line_name = line_name == "" and "Old" or line_name .. " (Old)"
        end
        local ja_style = not jaEn and (not ja or ja == "" or ja == "?") and templates.incomplete_style
        local en_style = not jaEn and (not en or en == "" or en == "?") and templates.incomplete_style
        local jaEn_style = jaEn and (jaEn == "" or jaEn == "?") and templates.incomplete_style
        if ja_style or en_style or jaEn_style then
            complete = false
        end
        local shipName = use_suffix and remodel or U.ijoin({ship, remodel}, ' ')
        local isMigrated = migrated[shipName]
        table.insert(result, format{
            templates.row,
            style = remodel and count > 0 and templates.remodel_row_style or "",
            audio_button = args.no_audio and "" or format{
                templates.audio_button,
                audio_file = format{
                    isMigrated and templates.audio_file_new or templates.audio_file,
                    ship = isMigrated and shipName or use_suffix and suffix or ship,
                    suffix = use_suffix and "" or suffix,
                    line = (same or line.name) .. (old and " Old" or ""),
                },
            },
            id = line.id,
            form = remodel or "Base",
            line = link and format{templates.line_link, link = link, line = line_name} or line_name,
            ja = format_text(jaEn or ja, line),
            ja_colspan = jaEn and "2" or "1",
            ja_style = ja_style or jaEn_style or "",
            en_cell = jaEn and "" or '| style="' .. (en_style or "") .. '" class="shipquote-en" |' .. format_text(en, line) .. "\n",
            note = format_text(note, line),
        })
        return 1
    end

    return 0

end

function checkNoteTypes(ship_name, types)
    local ship = Ship(ship_name)
    -- [[Category:Todo]]: collect possible suffixes in insertRow?
    local shipKai = Ship(ship_name .. "/Kai")
    return U.find(types, ship:type()) or U.find(types, shipKai:type())
end

local Quotes = {}

function Quotes.ShipQuotes(frame, args)
    args = args or U.getTemplateArgs(frame)
    args.explicit.ship = args.explicit.ship or args.implicit.basepagename ~= "Sandbox" and args.implicit.basepagename or args.implicit.pagename or ""
    local result = {}
    table.insert(result, format{templates.header, note_style = args.explicit.note_style or ""})
    for _, line in pairs(lines) do
        
        local added = insertRow(result, nil, args.explicit, line, 0)
        -- Remodel levels
        added = added + insertRow(result, "Kai", args.explicit, line, added)
        added = added + insertRow(result, "Kai Ni", args.explicit, line, added)
        added = added + insertRow(result, "Kai Ni A", args.explicit, line, added)
        added = added + insertRow(result, "Kai Ni B", args.explicit, line, added)
        added = added + insertRow(result, "Kai Ni C", args.explicit, line, added)
        added = added + insertRow(result, "Kai Ni D", args.explicit, line, added)
        added = added + insertRow(result, "Kai Ni Toku", args.explicit, line, added)
        added = added + insertRow(result, "Kai Ni Go", args.explicit, line, added)
        added = added + insertRow(result, "Kai B", args.explicit, line, added)
        added = added + insertRow(result, "B Kai", args.explicit, line, added)
        added = added + insertRow(result, "D Kai", args.explicit, line, added)
        added = added + insertRow(result, "A", args.explicit, line, added)
        added = added + insertRow(result, "Carrier", args.explicit, line, added)
        added = added + insertRow(result, "Carrier Kai", args.explicit, line, added)
        added = added + insertRow(result, "Carrier Kai Ni", args.explicit, line, added)
        added = added + insertRow(result, "Andra", args.explicit, line, added)
        
        added = added + insertRow(result, "", args.explicit, line, added, false, true)
        added = added + insertRow(result, "Kai", args.explicit, line, added, false, true)
        
        added = added + insertRow(result, "Dan Yang", args.explicit, line, added, true)
        
        added = added + insertRow(result, "Kai Ni", args.explicit, line, added, false, true)
        -- Individual ship names
        added = added + insertRow(result, "Verniy", args.explicit, line, added, true)
        added = added + insertRow(result, "Ryuuhou", args.explicit, line, added, true)
        added = added + insertRow(result, "Ryuuhou Kai", args.explicit, line, added, true)
        added = added + insertRow(result, "Ro-500", args.explicit, line, added, true)
        added = added + insertRow(result, "Italia", args.explicit, line, added, true)
        added = added + insertRow(result, "Taiyou", args.explicit, line, added, true)
        added = added + insertRow(result, "Taiyou Kai", args.explicit, line, added, true)
        added = added + insertRow(result, "Taiyou Kai Ni", args.explicit, line, added, true)
        added = added + insertRow(result, "Oktyabrskaya Revolyutsiya", args.explicit, line, added, true)
        added = added + insertRow(result, "UIT-25", args.explicit, line, added, true)
        added = added + insertRow(result, "I-504", args.explicit, line, added, true)
        -- Foreign alternatives to Kai Ni, etc.
        added = added + insertRow(result, "Zwei", args.explicit, line, added)
        added = added + insertRow(result, "Due", args.explicit, line, added)
        added = added + insertRow(result, "Dva", args.explicit, line, added)
        added = added + insertRow(result, "Mk.II", args.explicit, line, added)
        added = added + insertRow(result, "Mk.II Mod.2", args.explicit, line, added)
        
        
        if line.note and added > 0 and (not line.note_types or checkNoteTypes(args.explicit.ship, line.note_types)) then
            table.insert(result, format{templates.note, note = line.note})
        end
    end
    table.insert(result, templates.footer)
    if not complete and args.implicit.basepagename ~= "Sandbox" and not args.explicit.no_categories then
        table.insert(result, templates.incomplete_category)
    end
    return table.concat(result, "\n")
end

function Quotes.test()
    return Quotes.ShipQuotes(
        nil,
        {
            explicit = {
                ["Introduction/Kai Ni"] = "?"
            },
            implicit = {
                pagename = "Umikaze"
            }
        }
    )
end

return Quotes