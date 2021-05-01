--[[
	Handles most of the boilerplate necessary to fetch arguments, such as trimming
	leading/trailing whitespace, making blank arguments evaluate to false, correctly
	choosing between current-frame and parent-frame, etc.

	Originally written on the English Wikipedia by Mr. Stradivarius, Jackmcbarn, and Anomie.

	Code released under the GPL v2+ as per:
	https://en.wikipedia.org/w/index.php?diff=624020648&oldid=624019645
	https://en.wikipedia.org/w/index.php?diff=624073793&oldid=624020648

	@license GNU GPL v2+
]]

local libraryUtil = require( 'libraryUtil' )

local sandboxSuffixPattern = string.format( '/%s$',
	mw.message.new( 'scribunto-template-sandbox-subpage-name' ):plain():gsub("%p", "%%%0")
)

local function tidyValDefault( k, v )
	if type( v ) == 'string' then
		v = v:match( '^%s*(.-)%s*$' )
		if v == '' then
			return nil
		end
	end
	return v
end

local function tidyValTrimOnly( k, v )
	if type( v ) == 'string' then
		return v:match( '^%s*(.-)%s*$' )
	else
		return v
	end
end

local function tidyValRemoveBlanksOnly( k, v )
	if type( v ) == 'string' and not v:find( '%S' ) then
		return nil
	else
		return v
	end
end

local function tidyValNoChange( k, v )
	return v
end

local function matchesTitle( given, title )
	local tp = type( given )
	return ( tp == 'string' or tp == 'number' ) and mw.title.new( given ).prefixedText == title
end

-- Checks whether title matches any wrapper templates that were specified by
-- the user.
local function titleIsWrapper( title, wrappers )
	title = title:gsub( sandboxSuffixPattern, '' )
	if matchesTitle( wrappers, title ) then
		return true
	elseif type( wrappers ) == 'table' then
		-- If either a key or a value matches, it's a match
		if wrappers[title] ~= nil then
			return true
		else
			for _,v in ipairs( wrappers ) do
				if matchesTitle( v, title ) then
					return true
				end
			end
		end
	end
	return false
end

return function( options )
	libraryUtil.checkType( 'getArgs', 1, options, 'table', true )
	local frame = options.frame
	if frame == nil then
		return {}
	end
	libraryUtil.checkTypeForNamedArg( 'getArgs', 'frame', frame, 'table' )

	--[[
	-- Get the tables to look up arguments from. These could be any of:
	-- * the frame arguments
	-- * the parent frame arguments
	-- * a table of arguments passed from a Lua module or from the debug console
	-- We try to select the correct one(s) based on whether we were passed a
	-- valid frame object and whether we are being called from a wrapper
	-- template. Usually we only use one of these tables, but if
	-- options.wrappersUseFrame is set we may use both the frame arguments and
	-- the parent frame arguments.
	--]]
	local argTables = {}
	if type( frame.args ) == 'table' and type( frame.getParent ) == 'function' then
		-- We were passed a valid frame. Find out if the title of its parent
		-- frame is contained in options.wrappers.
		if options.wrappers then
			local parent = frame:getParent()
			if parent and titleIsWrapper( parent:getTitle(), options.wrappers ) then
				argTables[1] = parent.args
			end
		end
		if not argTables[1] or options.wrappersUseFrame then
			table.insert( argTables, frame.args )
		end
	else
		-- Assume frame is a table of arguments passed from a Lua module or
		-- from the debug console.
		argTables[1] = frame
	end

	-- Get tidyVal, the function that we use to trim whitespace and remove
	-- blank arguments. This can be set by the user with options.valueFunc.
	-- Otherwise it is generated from options.trim and options.removeBlanks.
	-- We define four separate default tidyVal functions so that we can avoid
	-- checking options.trim and options.removeBlanks every time we look up an
	-- argument.
	local tidyVal = options.valueFunc
	if tidyVal then
		libraryUtil.checkTypeForNamedArg( 'getArgs', 'valueFunc', tidyVal, 'function' )
	elseif options.trim ~= false then
		if options.removeBlanks ~= false then
			tidyVal = tidyValDefault
		else
			tidyVal = tidyValTrimOnly
		end
	else
		if options.removeBlanks ~= false then
			tidyVal = tidyValRemoveBlanksOnly
		else
			tidyVal = tidyValNoChange
		end
	end

	-- Set up a metatable to allow transparent fetching of arguments from argTables
	-- * mt - the metatable
	-- * fetchedArgs - a table to store memoized arguments fetched from argTables
	-- * nilArgs - a table to memoize nil arguments
	-- * donePairs - whether pairs has been run
	-- * doneIpairs - whether ipairs has been run
	local mt, fetchedArgs, nilArgs = {}, {}, {}
	local donePairs, doneIpairs = false, false

	-- This function merges arguments from argument tables into fetchedArgs,
	-- Earlier argument tables take precedence over later ones; once a value
	-- is written it is not overwritten.
	local function mergeArgs( tables )
		for _, t in ipairs( tables ) do
			for key, val in pairs( t ) do
				if fetchedArgs[key] == nil and not nilArgs[key] then
					local tidiedVal = tidyVal( key, val )
					if tidiedVal == nil then
						nilArgs[key] = true
					else
						fetchedArgs[key] = tidiedVal
					end
				end
			end
		end
	end

	function mt.__index( t, key )
		local val = fetchedArgs[key]
		if val ~= nil then
			return val
		elseif donePairs or nilArgs[key] then
			-- If pairs has been run we already have all the arguments in
			-- fetchedArgs.
			return nil
		end
		for _, argTable in ipairs( argTables ) do
			local argTableVal = tidyVal( key, argTable[key] )
			if argTableVal ~= nil then
				fetchedArgs[key] = argTableVal
				return argTableVal
			end
		end
		nilArgs[key] = true
		return nil
	end

	function mt.__newindex( t, key, val )
		if val == nil then
			-- We need to memoize the nil so that we don't look up the key in
			-- the argument tables if it is accessed again.
			nilArgs[key] = true
		end
		fetchedArgs[key] = val
	end

	function mt.__pairs()
		if not donePairs then
			donePairs = true
			mergeArgs( argTables )
		end
		return pairs( fetchedArgs )
	end

	local function inext(t, i)
		-- This uses our __index metamethod
		local v = t[i + 1]
		if v ~= nil then
			return i + 1, v
		end
	end

	function mt.__ipairs(t)
		return inext, t, 0
	end

	return setmetatable( {}, mt )
end