local re = {}

function re.findMatch(frame)
	-- args[1] = test string
	-- args[2] = Lua pattern
	result = string.match(frame.args[1], frame.args[2])
	if (result == nil) then
		result = ""
	end
	return result
end

return re