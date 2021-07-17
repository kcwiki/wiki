local BaseData = require("Module:BaseData")

local PersonData = BaseData()

--The name of the person.
function PersonData:name()
	return self._name
end

--A group of values passable to Formatting:format_external_link() to create a wikitext link to this person's profile (usually on pixiv/MyAnimeList/etc).
function PersonData:link()
	return self._link, self:name()
end

--The name of the person in Japanese.
function PersonData:japanese_name()
	return self._japanese_name
end

--The reading of the person's Japanese name.
function PersonData:reading()
	return self._reading
end

function PersonData:create(person)
	person = person or {}
	setmetatable(person, person)
	person.__index = self
	person.__call = self.__call
	return person
end

return PersonData