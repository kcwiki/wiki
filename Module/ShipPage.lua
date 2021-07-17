local U = require("Module:Core")
local format = require("Module:Core").format
local Formatting = require("Module:Formatting")
local BaseData = require("Module:BaseData")
local Ship = require("Module:Ship")
local ShipGraphicKai = require('Module:ShipGraphicKai')
local ShipCardKai = require('Module:ShipCardKai')
local ShipBattleCardKai = require('Module:ShipBattleCardKai')
local ShipMetaKai = require("Module:ShipMetaKai")
local ShipInfoKai = require("Module:ShipInfoKai")
local ShipCategoriesKai = require("Module:ShipCategoriesKai")

-- can't use Ship:remodel_to_level() normally for some reason
local reversible_forms = {}

function ship_remodel_forms(ship_name, seasonal_forms, ship_suffix, j)
    j = j or 1
    ship_suffix = ship_suffix or ""
    local forms = { ship_name .. "/" .. ship_suffix }
    local success, ship_data = Ship.requireModule(ship_name)
    if not success then
        return forms
    end
    local form_data = ship_data[ship_suffix]
    if seasonal_forms then
        for suffix, data in pairs(ship_data) do
            if (data._seasonal == true or data._season) and data._name and data._suffix then
                table.insert(seasonal_forms, data._name .. "/" .. data._suffix)
            end
        end
    end
    local i = 0
    while form_data and form_data._remodel_to and not U.find(forms, form_data._remodel_to) and i < 10 and j <= 3 do
        local ship_name_next, ship_suffix_next = Ship:process_ship_key(form_data._remodel_to)
        if ship_name_next ~= ship_name then
            return U.concat(forms, ship_remodel_forms(ship_name_next, seasonal_forms, ship_suffix_next, j + 1))
        else
            table.insert(forms, form_data._remodel_to)
            form_data = ship_data[ship_suffix_next]
            if form_data._remodel_to_level then
                 reversible_forms[form_data._name .. "/" .. (form_data._suffix or "")] = form_data._remodel_to
            end
        end
        i = i + 1
    end
    return forms
end

local ShipPage = {

    _header = "${notice}${ship_meta}__TOC__${clear}${ship_infoboxes}${ship_categories}",

    _ship_infobox = [[<div style="display:inline-block;">
===${title}===
${infobox}
</div>]],

    _ship_infobox_titles = {
        "Basic",
        "Upgrade",
        "Second Upgrade",
        "Third Upgrade",
        "Fourth Upgrade",
        "Fifth Upgrade"
    },

    _gallery_link = [=[*[[${fullpagename}/Gallery|View ${ship_name} CG]]]=],
    _ship_type_link = [=[*[[${ship_code}|List of ${ship_type}s]]]=],
    _wikipedia_link = [=[*[[wikipedia:${wikipedia}|Wikipedia entry on ${ship_type} ${ship_name}]]]=],

    _sandbox_notice = [=[<div style="width:90%; border:2px solid #aa5; background:#ffc; text-align:center; margin:15px auto 20px; padding:5px;">This is a testing ship page, it does not correspond to an actual ship.</div>
]=],

    _dd_notice = [=[<div style="width:90%; border:2px solid #aa5; background:#ffc; text-align:center; margin:15px auto 20px; padding:5px;">As part of the [[Thread:670693|Phase 2]] update, some remodels have had stock equipments changed, which may not yet be reflected on these pages. Please be patient while they are brought up to date.</div>
]=],

    _gallery_tabber = [[<div class="ship-page-gallery-tab">
{{#tag:tabber|
{{!}}-{{!}}Normal=${image}
{{!}}-{{!}}Damaged=${image_damaged}
}}
</div>]],

    _gallery_normal = [[<div class="ship-page-gallery-tab">
{{#tag:tabber|
{{!}}-{{!}}Normal=${image}
}}
</div>]],

    _gallery_damaged = [[<div class="ship-page-gallery-tab">
{{#tag:tabber|
{{!}}-{{!}}Damaged=${image}
}}
</div>]],

    _footer_sections = [=[<div class="ship-page-gallery">
==[[${name}/Gallery|CG]]==
${gallery}
</div>
==See Also==
${links}]=],

}

function ShipPage:format_ship_meta()
    self._vars.ship_meta = ShipMetaKai:Infobox({ self._vars.ship_name })
end

function ShipPage:format_ship_infoboxes(basepagename)
    local forms = ship_remodel_forms(self._vars.ship_name)
    local infoboxes = {}
    for i, form in ipairs(forms) do
        local override
        if basepagename == "Sandbox" then
            override = { _page = "Sandbox/" .. self._vars.ship_name }
        end
        local reverse_form_suffix
        if reversible_forms[form] then
            local lua_huh, reverse_form_suffix_ = Ship:process_ship_key(reversible_forms[form])
            reverse_form_suffix = reverse_form_suffix_
        end
        table.insert(infoboxes, format{
            self._ship_infobox,
            title = (self._ship_infobox_titles[i] or "?") ..
              (reverse_form_suffix and string.format(" (Reversible to %s)", reverse_form_suffix) or ""),
            infobox = ShipInfoKai:Infobox({ form, override = override })
        })
    end
    self._vars.ship_infoboxes = table.concat(infoboxes, "\n")
end

function ShipPage:format_ship_categories(basepagename, args)
    self._vars.ship_categories = (basepagename == "Sandbox" or args.no_categories) and "" or ShipCategoriesKai:Categories({ self._vars.ship_name })
end

function ShipPage:format_notice(basepagename)
    self._vars.notice = basepagename == "Sandbox" and self._sandbox_notice or "" -- Ship(basepagename):type() == 2 and self._dd_notice or ""
end

function ShipPage:format_header(ship_name, basepagename, args)
    self._vars = {
        ship_name = ship_name,
        clear = Formatting:clear(),
    }
    self:format_ship_meta()
    self:format_ship_infoboxes(basepagename)
    self:format_ship_categories(basepagename, args)
    self:format_notice(basepagename)
    return format(self._header, self._vars)
end

function ShipPage.Header(frame)
    local args = U.getTemplateArgs(frame)
    local basepagename = args.implicit.basepagename or ""
    local ship_name = args.explicit.ship or args.implicit.pagename or ""
    return ShipPage:format_header(ship_name, basepagename, args.explicit)
end

function ShipPage.FooterLinks(args)
    local basepagename = args.implicit.basepagename or ""
    local ship_name = args.explicit.ship or args.implicit.pagename or ""
    local ship = Ship(ship_name)
    local ship_type = ship:type()
    local ship_name_ = ship:name()
    local ship_type_ = Formatting:format_ship_type(ship_type)
    local ship_code = Formatting:format_ship_code(ship_type)
    local wikipedia = ship:wikipedia()
    local fullpagename = basepagename == "Sandbox" and ("Sandbox/" .. ship_name) or ship_name
    local links = {
        format{
            ShipPage._gallery_link,
            fullpagename = fullpagename,
            ship_name = ship_name_,
        }
    }
    if ship_type then
        table.insert(links, format{
            ShipPage._ship_type_link,
            ship_code = ship_code,
            ship_type = ship_type_,
        })
    end
    if wikipedia then
        table.insert(links, format{
            ShipPage._wikipedia_link,
            ship_name = ship_name_,
            ship_type = ship_type_,
            wikipedia = wikipedia,
        })
    end
    if args.explicit.links then
        links = U.concat(links, args.explicit.links)
    end
    return table.concat(links, "\n")
end

function ShipPage.ClassTemplate(frame, args)
    args = args or U.getTemplateArgs(frame)
    local basepagename = args.implicit.basepagename or ""
    local ship_name = args.explicit.ship or args.implicit.pagename or ""
    local ship = Ship(ship_name)
    local classI = ship:class()
    local class = classI and classI:name_override() or "Unknown Class"
    if basepagename == "Sandbox" then
        return "Sandbox/" .. class
    else
        return class
    end
end

function ShipPage.ClassTemplateTest(frame)
    local args = U.getTemplateArgs(frame)
    local ship_name = args.explicit.ship or args.implicit.pagename or ""
    local ship = Ship(ship_name)
    local classI = ship:class()
    local class = classI and classI:base_name_test() or "?"
    return string.format("|%s|%s|%s|", ship_name, ship:name(), tostring(class))
end

function ship_cgs(ship_name, ship_suffix, j, seasonal_forms, visited_modules)
	ship_suffix = ship_suffix or ""
    j = j or 1
    seasonal_forms = seasonal_forms or {}
    visited_modules = visited_modules or {}
    local forms = { { name = ship_name .. '/' .. ship_suffix, normal = true, damaged = true } }
    local success, ship_data = Ship.requireModule(ship_name)
    if not success then
        return forms
    end
    if not U.ifind(visited_modules, ship_name) then
    	table.insert(visited_modules, ship_name)
    	-- TODO: legacy seasonals, check if it is ok to delete
	    for suffix, data in pairs(ship_data) do
	        if data._seasonal or data._season then
	            local normal = data._cg ~= false
	            local damaged = data._cg_damaged ~= false
	            table.insert(seasonal_forms, {
	                suffux = data._suffix or suffix,
	                name = (data._name or ship_name) .. "/" .. (data._suffix or suffix),
	                seasonal = true,
	                normal = normal,
	                damaged = damaged,
	                season = data._season,
	                season_suffix = data._season_suffix,
	                battle_card = data._show_battle_card,
	            })
	        end
	    end
	    for _, data in ipairs(ship_data.seasonals or {}) do
	        local normal = data._cg ~= false
	        local damaged = data._cg_damaged ~= false
	        table.insert(seasonal_forms, {
	            suffux = data._suffix,
	            name = (data._name or ship_name) .. "/" .. data._suffix,
	            seasonal = true,
	            normal = normal,
	            damaged = damaged,
	            season = data._season,
	            season_suffix = data._season_suffix,
	            battle_card = data._show_battle_card,
	        })
	    end
    end
    local i = 1
    local form_data = ship_data[ship_suffix]
    while form_data and form_data._remodel_to and not U.find(forms, form_data._remodel_to, 'name') and i <= 15 and j <= 3 do
        local ship_name_next, ship_suffix_next = Ship:process_ship_key(form_data._remodel_to)
        if ship_name_next ~= ship_name then
            return U.concat(forms, ship_cgs(ship_name_next, ship_suffix_next, j + 1, seasonal_forms, visited_modules))
        else
            local name = form_data._remodel_to
            form_data = ship_data[ship_suffix_next]
            local normal = not (form_data._cg_reference and true or false)
            local damaged = not (form_data._cg_damaged_reference and true or false)
            table.insert(forms, { name = name, normal = normal, damaged = damaged })
        end
        i = i + 1
    end
    return U.concat(forms, seasonal_forms)
end

function cg(seasonal, name, damaged, size, battle_card)
    return format{
        [[<span class="advanced-tooltip">${cg}<div class="tooltip-contents">${card}${battle_card}</div></span>]],
        cg = ShipGraphicKai:Asset({ name, link = "nil", damaged = damaged, size = size, hd = true }),
        card = ShipCardKai:Asset({ name, link = "nil", damaged = damaged, hd = true }),
        battle_card = battle_card and ("<br>" .. ShipBattleCardKai:Asset({ name, link = "nil", damaged = damaged, hd = true })) or "",
    }
end

function getFirstSeason(season)
    if type(season) == "table" then
        if type(season[1]) == "table" then
            return season[1][1]
        else
            return season[1]
        end
    else
        return season
    end
end

function formatSeason(season)
    local seasons = type(season) == "table" and season or { season }
    local strings = U.imap(seasons, function(season)
        if type(season) == "table" then
            return format{"[[Seasonal/${season_link}|${season_name}]]", season_link = season[1], season_name = season[2]}
        else
            return format{"[[Seasonal/${season}|${season}]]", season = season}
        end
    end)
    return table.concat(strings, ", ")
end

function getTitle(form, base_name, name, suffix, short)
    if form.seasonal then
        if short then
            if form.season_suffix == false then
                return nil
            end
            if form.season_suffix then
                return form.season_suffix
            end
            local season = getFirstSeason(form.season) or "" -- string.match(form.season, "(.*) 20%d%d") or form.season
            local suffixInSeason = string.find(season, suffix)
            local seasonInSuffix = string.find(suffix, season)
            if suffixInSeason then
                return name ~= base_name and name
            elseif seasonInSuffix then
                return string.sub(suffix, 1, seasonInSuffix - 2)
            else
                return name == base_name and suffix or name .. " " .. suffix
            end
        else
            return name == base_name and suffix or name .. " " .. suffix
        end
    else
        return suffix ~= "" and suffix or name == base_name and "Base" or name
    end
end

local blur_options = [=[<div style="margin-top:5px;text-align:right">
<div class="toggle" data-target="nsfw" data-default="hide" data-classes="blur">
<span class="toggle-show" style="cursor:pointer;color:#006cb0;">☑ Blur NSFW CG</span>
<span class="toggle-hide" style="cursor:pointer;color:#006cb0;">☒ Blur NSFW CG</span>
</div>
<div class="toggle" data-target="nsfw-damaged" data-default="hide" data-classes="blur">
<span class="toggle-show" style="cursor:pointer;color:#006cb0;">☑ Blur other damaged CG</span>
<span class="toggle-hide" style="cursor:pointer;color:#006cb0;">☒ Blur other damaged CG</span>
</div>
</div>]=]

function ShipPage.Gallery(frame, args)
    args = args or U.getTemplateArgs(frame)
    local ship_name = args.explicit.ship or args.implicit.pagename or ""
    local forms = ship_cgs(ship_name)
    local result = { '<div class="ship-gallery-page">' }
    local first_seasonal
    for _, form in ipairs(forms) do
        local name, suffix = Ship:process_ship_key(form.name)
        suffix = suffix or ""
        local title = getTitle(form, ship_name, name, suffix, true)
        if not first_seasonal and form.seasonal then
            first_seasonal = true
            table.insert(result, "<h2>[[Seasonal]]s</h2>")
        end
        if form.seasonal and (form.normal or form.damaged) then
            if form.season and not title then
                table.insert(result, format{
                    "<h3>${seasons}</h3>",
                    seasons = formatSeason(form.season)
                })
            elseif form.season then
                table.insert(result, format{
                    "<h3>${seasons} (${title})</h3>",
                    title = title,
                    seasons = formatSeason(form.season)
                })
            else
                table.insert(result, "<h3>" .. title .. "</h3>")
            end
        elseif form.normal or form.damaged then
            table.insert(result, "<h2>" .. title .. "</h2>")
        end
        table.insert(result, '<div class="ship-gallery-page-section">')
        if form.normal then
            table.insert(result, '<div class="ship-gallery-page-section-image">')
            table.insert(result, cg(form.seasonal, form.name))
            table.insert(result, "</div>")
        end
        if form.damaged then
            table.insert(result, '<div class="ship-gallery-page-section-image">')
            table.insert(result, cg(form.seasonal, form.name, true))
            table.insert(result, "</div>")
        end
        table.insert(result, "</div>")
    end
    table.insert(result, "</div>")
    table.insert(result, blur_options)
    return table.concat(result, "\n")
end

function ShipPage.GalleryTabber(args)
    local ship_name = args.explicit.ship or args.implicit.pagename or ""
    local forms = ship_cgs(ship_name)
    local result = { "{{#tag:tabber|" }
    for _, form in ipairs(forms) do
        if form.normal or form.damaged then
            local name, suffix = Ship:process_ship_key(form.name)
            suffix = suffix or ""
            local title = getTitle(form, ship_name, name, suffix)
            table.insert(result, "{{!}}-{{!}}" .. title .. "=")
            if form.normal and form.damaged then
                local image = cg(form.seasonal, form.name, false, "300px", form.battle_card or not form.seasonal)
                local image_damaged = cg(form.seasonal, form.name, true, "300px", form.battle_card or not form.seasonal)
                table.insert(result, format{
                    ShipPage._gallery_tabber,
                    image = image,
                    image_damaged = image_damaged
                })
            elseif form.normal then
                local image = cg(form.seasonal, form.name, false, "300px", form.battle_card or not form.seasonal)
                table.insert(result, format{
                    ShipPage._gallery_normal,
                    image = image,
                })
            elseif form.damaged then
                local image_damaged = cg(form.seasonal, form.name, true, "300px", form.battle_card or not form.seasonal)
                table.insert(result, format{
                    ShipPage._gallery_damaged,
                    image = image_damaged,
                })
            end
        end
    end
    table.insert(result, "}}")
    table.insert(result, blur_options)
    return table.concat(result, "\n")
end

function ShipPage.BreakInstance(frame)
    local args = U.getTemplateArgs(frame)
    local ship_name = args.explicit.ship or args.implicit.pagename or ""
    local forms = ship_cgs(ship_name)
    return "<pre>\n" .. U.js(Ship(ship_name)) .. "\n</pre>"
end

function ShipPage.FooterSections(frame)
    local args = U.getTemplateArgs(frame)
    local ship_name = args.explicit.ship or args.implicit.pagename or ""
    return format{
        ShipPage._footer_sections,
        name = ship_name,
        gallery = frame:preprocess(ShipPage.GalleryTabber(args)),
        links = ShipPage.FooterLinks(args)
    }
end

return ShipPage