local _ = require('Module:Core')
-- local Data = require('Module:Data')
-- local View = require('Module:View')

local p = {}

p.cache = {}

-- [[Category:Todo]]:
-- * Support render : Args -> UI tree in Module:View, currently Args -> String
-- * Module:View/Table for table UI tree construction

local table_row_alias = [=[|- id="${label}" class="q${letter}" style="height:50px"
|rowspan="1"|'''${label}'''
|colspan="5"|See [[#${alias_of}|${alias_of}]].
]=]

local mapLetterType = {
	A = 'Composition',
	B = 'Sortie',
	C = 'PVP',
	D = 'Expedition',
	E = 'Supply',
	F = 'Factory',
	G = 'Modernization'
}

local function renderProtoQuests(args, frame)
	-- Filter term ([1] = pattern to match, [2] = data element to match)
	local filter = { (args.explicit['filterMatch'] or nil), (args.explicit['filterGroup'] or nil) }
	local idsList = nil
	if(args.explicit['filterIDs']) then
		idsList = mw.text.split(args.explicit['filterIDs'], '%s')
	end
	local result = {}
	for i, category in ipairs(args.explicit) do
		if not p.cache[category] then
			--HARDCODED FOR TESTING, REMOVE WHEN DATA ADDED
			if category == 'Sortie' then
				p.cache[category] = mw.loadData('Module:User:Fourinone/Sandbox/1')
			else
				p.cache[category] = mw.loadData('Module:Data/Quest/' .. category)
			end
			-- ^
			--p.cache[category] = mw.loadData('Module:Data/Quest/' .. category)
		end
		local data = p.cache[category]
		table.insert(result, frame:expandTemplate{title='ProtoQuestsHeader'})
		for i, q in ipairs(data) do
			local proceed = false
			if(idsList) then
				for j, qid in ipairs(idsList) do
					for k, label in ipairs(mw.text.split(q.label,',')) do
						if(label == qid) then
							proceed = true
							table.remove(idsList, j)
							break
						end
					end
					if proceed then break end
				end
			end
			if (proceed or (not idsList and not filter[1] and not filter[2]) or (filter[1] and filter[2] and q[filter[2]] and string.match(q[filter[2]], filter[1]))) then
				if(q.alias_of) then
					table.insert(result, _.format(table_row_alias, {
						label = q.label,
						letter = q.letter or q.label:sub(1, 1),
						alias_of = q.alias_of
					}))
				else
					reqQuests = {}
					if q.reqQuest then
						reqQuests = mw.text.split(q.reqQuest,',')
					end
					table.insert(result, frame:expandTemplate{title='ProtoQuests', args={
						type = q.type or mapLetterType[q.letter or q.label:sub(1,1)],
						listnum = q.label:gsub(',','<br>'),
						reqQuest = reqQuests[1],
						reqQuest2 = reqQuests[2],
						reqQuest3 = reqQuests[3],
						namejp = q.title,
						nameen = q.title_en,
						req = q.detail_en,
						fuel = q.reward_fuel,
						ammo = q.reward_ammo,
						steel = q.reward_steel,
						bauxite = q.reward_bauxite,
						other = q.reward_other,
						notes = q.note
					}})
				end
			end 
		end
		table.insert(result, '|}')
	end
	local s = _.join(result, '\n')
	return frame:preprocess(s)
end

p.render = function(frame)
	return renderProtoQuests(frame and _.getTemplateArgs(frame) or {}, frame)
end

return p