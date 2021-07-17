local BaseData = require("Module:BaseData")

local PageTitle = BaseData{}

function PageTitle.ID(frame)
    return tostring(mw.title.getCurrentTitle().id)
end

function PageTitle.Title(frame)
    return tostring(mw.title.getCurrentTitle().prefixedText)
end

return PageTitle