local _ = require('Module:Core')

function render(frame, args)
    args = args or _.getTemplateArgs(frame)
    local from = _.imap(_.split(args.explicit[1], '-'), function(e) return tonumber(e) end)
    local fromYear = from[1] or 2020
    local fromMonth = from[2] or 1
    local fromDay = from[3] or 1
    local days = tonumber(args.explicit[2]) or 31
    local teasers = {}
    for i = 0, days - 1 do
        local j, day = _.divMod(fromDay - 1 + i, 31)
        day = day + 1
        local k, month = _.divMod(fromMonth - 1 + j, 12)
        month = month + 1
        local year = fromYear + k
        for i, label in ipairs({'A', 'B', 'C', 'D', 'E'}) do
            local title = string.format('Teaser-%s-%s-%s-%s.png', year, _.pad(month, 2, '0'), _.pad(day, 2, '0'), label)
            if mw.title.makeTitle('File', title).exists then
                table.insert(teasers, string.format('[[File:%s]]', title))
            else
                break
            end
        end
    end
    return table.concat(teasers, '<br>')
end

return { render = render }