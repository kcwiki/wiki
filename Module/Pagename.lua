local getArgs = require('Module:GetArgs')

return {
    format = function(frame)
        local f1 = frame
        local f2 = f1 and f1:getParent()
        local f3 = f2 and f2:getParent()
        local a1 = f1 and getArgs{ frame = f1 }
        local a2 = f2 and getArgs{ frame = f2 }
        local a3 = f3 and getArgs{ frame = f3 }
        local s1 = f1 and (f1:getTitle() .. ',' .. (a1 and a1.pagename or '-')) or '='
        local s2 = f2 and (f2:getTitle() .. ',' .. (a2 and a2.pagename or '-')) or '='
        local s3 = f3 and (f3:getTitle() .. ',' .. (a3 and a3.pagename or '-')) or '='
        return s1 .. ';' .. s2 .. ';' .. s3
    end
}