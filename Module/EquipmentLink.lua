local getArgs = require("Module:GetArgs")
local U = require("Module:Core")
local F = require("Module:Formatting")
local Equipment = require("Module:Equipment")
local EquipmentCardKai = require("Module:EquipmentCardKai")
local EquipmentGraphicKai = require("Module:EquipmentGraphicKai")

local EquipmentLink = {}

function EquipmentLink.format(frame, args)

    args = args
        or U.getTemplateArgs(frame).implicit[1] and U.getTemplateArgs(frame).implicit
        or U.getTemplateArgs(frame).explicit

    local name = args[1] or "??"
    local text = args.text
    local link = args.link
    local image = args.image
    local icon = args.icon

    local size = args.size or (args[2] and "160px" or "260px")

    local cards = {}
    for _, arg in ipairs(args) do
        local equip = arg ~= "-" and Equipment(arg)
        table.insert(
            cards,
            arg == "-" and
            "<br />" or
            equip:id() and equip:id() > 500 and
            EquipmentGraphicKai:get{ equip = equip, size = size } or
            EquipmentCardKai:get{ equip = equip, size = size }
        )
    end

    local formatted_image
        = image
        and EquipmentCardKai:Asset({ name, size = image == "true" and "50px" or image, link = link or name })
        or ""

    local formatted_icon
        = icon
        -- [[Category:Todo]] again, would be nice to share Equipment object with EquipmentCardKai
        and F:format_image{ F:format_equipment_icon(Equipment(name):icon()) }
        or ""
        
    local formatted_text
    
    if text then
        if text == "true" then
            formatted_text = F:format_link(link or name, name)
        else
            formatted_text = F:format_link(link or name, text)
        end
    else
        if image then
            formatted_text = ""
        else 
            formatted_text = F:format_link(link or name, name)
        end
    end

    local tooltip_content = F:class_span("tooltip-contents", nil, #cards > 0 and table.concat(cards, "") or "??")

    return F:class_span("advanced-tooltip", nil, formatted_icon .. formatted_image .. formatted_text .. tooltip_content)

end

U.registerFormatTests(EquipmentLink, {
    { "Prototype 51cm Twin Gun Mount" },
    { "Type 4 Passive Sonar", link = "Sonar" },
    { "Prototype 51cm Twin Gun Mount", "P51cm" },
    { "Prototype 51cm Twin Gun Mount", image = "50px" },
    { "Prototype 51cm Twin Gun Mount", icon = "x" },
    { "Prototype 51cm Twin Gun Mount", "Prototype 51cm Twin Gun Mount" },
    { },
    { icon = "x" },
})
-- p.run_format_tests()

return EquipmentLink