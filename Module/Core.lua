
local Utils = {}

-- * Function functions :V

function Utils.id(...)
	return ...
end

function Utils.second(_, x)
    return x
end

-- * Number functions.

function Utils.round(x)
	return math.floor(x + 0.5)
end

function Utils.divMod(x, y)
	return math.floor(x / y), x % y
end

-- * Collection functions.

function Utils.isize(xs)
	local r = 0
	for _ in ipairs(xs) do
		r = r + 1
	end
	return r
end

function Utils.isArray(xs)
	for k, _ in pairs(xs) do
		return k == 1
	end
	return true
end

function Utils.findBy(xs, p)
    if Utils.isArray(xs) then
	    for k, v in ipairs(xs) do
            if p(v, k) then
			    return v, k
		    end
        end
    else
	    for k, v in pairs(xs) do
		    if p(v, k) then
			    return v, k
		    end
        end
    end
	return nil
end

function Utils.find(tbl, v_, k_)
	for _, v in pairs(tbl) do
		if k_ and v and v[k_] == v_ or not k_ and v == v_ then
			return v
		end
	end
	return false
end

function Utils.includes(tbl, v_, k_)
	for _, v in pairs(tbl) do
		if k_ and v and v[k_] == v_ or not k_ and v == v_ then
			return true
		end
	end
	return false
end

function Utils.map(tbl, fn)
	local result = {}
	for k, v in pairs(tbl) do
		table.insert(result, fn(v, k))
	end
	return result
end
 
function Utils.filter(tbl, pred)
	local result = {}
	for k, v in pairs(tbl) do
		if pred(v, k) then
			table.insert(result, v)
		end
	end
	return result
end

function Utils.first(tbl)
    for k, v in pairs(tbl) do
        return k, v
    end
end

function Utils.keys(tbl)
	local result = {}
	for k, _ in pairs(tbl) do
		table.insert(result, k)
	end
	return result
end

function Utils.values(tbl)
	local result = {}
	for _, v in pairs(tbl) do
		table.insert(result, v)
	end
	return result
end

function Utils.ifind(arr, v_)
	for i, v in ipairs(arr) do
		if v == v_ then
			return i
		end
	end
	return false
end

function Utils.ifindBy(arr, p)
	for i, v in ipairs(arr) do
		if p(v) then
			return v, i
		end
	end
	return false
end

function Utils.imax(arr, def)
    local maxValue
    local maxIndex
	for i, v in ipairs(arr) do
		if not maxValue or v > maxValue then
			maxValue = v
			maxIndex = i
		end
	end
	return maxValue or def
end

function Utils.imin(arr, def)
    local minValue
    local minIndex
	for i, v in ipairs(arr) do
		if not minValue or v < minValue then
			minValue = v
			minIndex = i
		end
	end
	return minValue or def
end

function Utils.imap(arr, fn)
	local result = {}
	for i, v in ipairs(arr) do
		table.insert(result, fn(v, i))
	end
	return result
end

function Utils.ifilter(arr, pred)
	local result = {}
	for i, v in ipairs(arr) do
		if pred(v, i) then
			table.insert(result, v)
		end
	end
	return result
end

function Utils.ifirst(arr)
    for k, v in ipairs(arr) do
        return k, v
    end
end

function Utils.ilast(arr)
	return arr[#arr]
end

function Utils.insertNew(arr, el)
    if not Utils.find(arr, el) then
        table.insert(arr, el)
    end
end

function Utils.concat(arr1, arr2)
    for i = 1, #arr2 do
        arr1[#arr1 + 1] = arr2[i]
    end
    return arr1
end

Utils.join = table.concat

function Utils.ijoin(arr, sep)
    sep = sep or ""
    return table.concat(arr, sep)
end

function Utils.joinLines(arr)
  return table.concat(arr, "\n")
end

function Utils.icopy(arr)
    return Utils.imap(arr, function(v) return v end)
end

function Utils.isort(arr)
    local result = Utils.icopy(arr)
    table.sort(result)
    return result
end

function Utils.isum(arr, result)
    result = result or 0
    for _, v in ipairs(arr) do
        result = result + (v or 0)
    end
    return result
end

-- * Number functions.

function Utils.round(x)
    return x % 2 ~= 0.5 and math.floor(x + 0.5) or x - 0.5
end

-- * String functions.

function Utils.pad(s, n, c)
    c = c or " "
    n = n or 0
    s = tostring(s) or ""
    return #s < n and string.rep(c, n - #s) .. s or s
end

function Utils.trim(s)
    return string.gsub(s, "^%s*(.-)%s*$", "%1")
end

function Utils.startsWith(s, ss)
    return string.sub(s, 1, string.len(ss)) == ss
end

-- Capitalize each word in a string.
function Utils.capitalize(s)
    s = s:gsub("(%s)(%l)", function(a, b) return a .. string.upper(b) end)
    s = s:gsub("^(%l)", function(a) return string.upper(a) end)
    return s
end

-- * Wikitext/HTML functions.

function Utils.category(name)
    return "[[" .. "Category:" .. name .. "]]"
end

function Utils.red(s)
    return Utils.format{[[<span style="color:red">${s}</span>]], s = s}
end

-- * Calling arbitrary Lua functions using #invoke.

-- Used to call Formatting:tooltip in Template:Tooltip, mainly because Lua code properly escapes characters,
-- so that span's title attribute always works.
function Utils.method(frame)
	local m = require("Module:" .. frame.args[1])
	local f = frame.args[2]
	local args = {}
	for k, v in ipairs(frame.args) do
		if type(k) == "number" and k >= 3 and type(v) == "string" then
			table.insert(args, v)
		end
	end
	return m[f](m, unpack(args))
end

-- * Frame functions.

local getArgs = require("Module:GetArgs")

-- Unused.
function Utils.getContext(frame)
    local frame1 = frame:getParent()
    if frame1 then
        local frame2 = frame1:getParent()
        if frame2 then
            return { pagename = frame2:getTitle(), args = getArgs{ frame = frame2 } }
        else
            return { pagename = frame1:getTitle(), args = getArgs{ frame = frame1 } }
        end
    else
        return { pagename = frame:getTitle(), args = getArgs{ frame = frame } }
    end
end

-- getParent -> getArgs
function Utils.getParentArgs(frame)
    local frame1 = frame:getParent()
    if frame1 then
        return getArgs{ frame = frame1 }
    else
        return nil
    end
end

-- getArgs + getParent -> getArgs, "implicit" args can be defined in the template (e.g. pagename={{PAGENAME}})
-- "explicit" args are user defined.
function Utils.getTemplateArgs(frame)
    local frame1 = frame:getParent()
    if frame1 then
        return { implicit = getArgs{ frame = frame }, explicit = getArgs{ frame = frame1 } }
    else
        return { implicit = getArgs{ frame = frame }, explicit = {} }
    end
end

function Utils.requireModule(name)
    local success, data = pcall(function () return require(string.format("Module:%s", name)) end)
    -- module without return (or empty, nil, false, true return) gives success = true, data = true
    if data == true then
        return false, nil
    else
        return success, data
    end
end

function Utils.loadData(name)
    local success, data = pcall(function () return mw.loadData(string.format("Module:%s", name)) end)
    -- TODO: ???
    if data == true then
        return false, nil
    else
        return success, data
    end
end

-- * Testing functions.

function Utils.debugPrint(x, i)
    i = i or 0
    if type(x) == "table" then
        for k, v in pairs(x) do
            mw.log(
                string.rep("  ", i) .. tostring(k) .. " : " .. type(k) .. " = " ..
                (type(v) == "table" and "table" or tostring(v) .. " : " .. type(v))
            )
            if type(v) == "table" then
                Utils.debugPrint(v, i + 1)
            end
        end
    else
        mw.log(tostring(x) .. " : " .. type(x))
    end
end

local function showValue(v)
    return type(v) == "string" and string.format('"%s"', v) or type(v) == "function" and '"function"' or tostring(v)
end

function Utils.js(x, i)
    i = i or 0
    local r = ""
    if type(x) == "table" then
        r = "{\n"
        for k, v in pairs(x) do
            if type(v) == "table" then
                r = r .. string.rep("  ", i + 1) .. tostring(k) .. ": " .. Utils.js(v, i + 1)
            else
                r = r .. string.rep("  ", i + 1) .. tostring(k) .. ": " .. showValue(v) .. ",\n"
            end
        end
        r = r .. string.rep("  ", i) .. (i == 0 and "}\n" or "},\n")
    else
        return showValue(x)
    end
    return r
end

function Utils.registerFormatTests(obj, tests, fn)
    obj.run_format_tests = function()
        for _, test in ipairs(tests) do
            local result = obj.format(nil, test)
            mw.log(fn and fn(result) or result)
        end
    end
end

function Utils.registerTableTests(obj, tests, fn)
    obj.run_table_tests = function()
        for _, test in ipairs(tests) do
            local result = obj:Table(test)
            mw.log(fn and fn(result) or result)
        end
    end
end

function Utils.test(obj, desc, fn)
    obj.test = function()
        mw.log(desc)
        fn(obj)
        mw.log("ok")
    end
end

Utils.log = mw.log

function Utils.format(s, lookup)
	if not lookup then
		lookup = s
		s = lookup[1]
		table.remove(lookup, 1)
	end
	return (string.gsub(s, '${([^%.%!%:%}%[%]]+)%[?([^%.%!%:%}%]]*)%]?%.?([^%!%:%}]*)!?([^%:%}]?):?([^%}]*)}', 
		function(name, element, attribute, conversion, format_spec)
			--local start_of_value, end_of_value, value = string.find(x, '^${(.-)[[.!:}]')
			--local start_of_access, end_of_access, access = string.find(x, '^${.-%[(.-)%][!:}]')
			--if not access then
			--	start_of_access, end_of_access, access = string.find(x, '^${[^:]-%.(.-)[!:}]')
			--end
			--local start_of_conversion, end_of_conversion, conversion = string.find(x, '^${.-!(.)[:}]')
			--local start_of_format_spec, end_of_format_spec, format_spec = string.find(x, ':(.*)}$')

			local value = lookup[name]
			if string.len(element) > 0 then
				value = value[element]
			elseif string.len(attribute) > 0 then
				value = value[attribute]
			end

			if string.len(conversion) > 0 then
				if conversion == 's' then
					value = tostring(value)
				end
			end

			if string.len(format_spec) > 0 then
				local start_of_sign, end_of_sign, sign = string.find(format_spec, '([+%- ])')
				local start_of_width, end_of_width, width, comma, precision, option = string.find(format_spec, '(%d*)(,?)([.0-9]*)([bcdeEfFgGnosxX%%]?)$')
				precision = string.sub(precision, 2)
				local number = tonumber(value)
				if #width > 0 then
					if number then
						value = string.format(string.format(number % 1 ~= 0 and "%%0%s.%sf" or "%%0%sd", width, #precision > 0 and precision or 0), number)
					end
					value = string.format(string.format("%%0%ss", width), value)
				elseif #precision > 0 and number then
					value = string.format(string.format("%%0%s.%sf", width, precision), number)
				end
				if sign then
					if number and number > 0 then
						if sign == "+" then
							value = "+" .. value
						elseif sign == " " then
							value = " " .. value
						end
					end
				end
			end

			return value
		end))
end

function Utils.split(string, separator, max_split, plain)
	assert(separator ~= '')
	assert(max_split == nil or max_split >= 1)

	local default_separator = false

	local result = {}

	if not separator or separator == '' then
		separator = '%s+'
		plain = false
		string = mw.text.trim(string)
		if string == '' then
			return result
		end
	end

	max_split = max_split or -1

	local item_index, start_index = 1, 1
	local separator_start, separator_end = mw.ustring.find(string, separator, start_index, plain)
	while separator_start and max_split ~= 0 do
		result[item_index] = mw.ustring.sub(string, start_index, separator_start - 1)
		item_index = item_index + 1
		start_index = separator_end + 1
		separator_start, separator_end = mw.ustring.find(string, separator, start_index, plain)
		max_split = max_split - 1
	end
	result[item_index] = mw.ustring.sub(string, start_index)

	return result
end

Utils.romanizable = {'zh-hans', 'zh-hant', 'zh-cn', 'zh-tw', 'zh-hk', 'zh-sg', 'zh-mo', 'zh-my', 'ja', 'ko', 'vi'}

Utils.normalization_table = {['　'] = ' ', ['～'] = '~', ['！'] = '!', ['？'] = '?'}

-- checks if string is set and if it's non-empty
function Utils.isset(target)
  return target ~= nil and target ~= ""
end

--[[ simulates the (a ? b : c) notation of C/C++ and PHP languages.
     Similar to {{#if:{{{a|}}}|{{{b|}}}|{{{c|}}}}} from parser functions. ]]
function Utils.cv(a, b, c)
  if a then return b else return c end
end

--slices a table to return another table containing values within a certain range
--source: http://snippets.luacode.org/snippets/Table_Slice_116
function Utils.sliceTable (values,i1,i2)
    local res = {}
    local n = #values
    -- default values for range
    i1 = i1 or 1
    i2 = i2 or n
    if i2 < 0 then
        i2 = n + i2 + 1
    elseif i2 > n then
        i2 = n
    end
    if i1 < 1 or i1 > n then
        return {}
    end
    local k = 1
    for i = i1,i2 do
        res[k] = values[i]
        k = k + 1
    end
    return res
end

-- checks if a given page exists
function Utils.exists(page)
  if not Utils.isset(page) then return false end
  return mw.getCurrentFrame():preprocess('{{#ifexist:' .. page .. '|1|0}}') == '1'
end

--[[ Tries to get contents of a page with given name.
     If the function fails it returns nil (page doesn't exist or can't be loaded)
     On success it returns the contents of page (it can be be partially preprocessed, so watch out for parser markers). ]]
function Utils.getPage(name)
  if not Utils.isset(name) then return nil end

  local frame = mw.getCurrentFrame()

  -- do a safe call to catch possible errors, like "template doesn't exist"
  local stat,page = pcall(frame.expandTemplate, frame, {title = ':' .. name})

  if not stat then
    -- TODO: 'page' contains the error message. Do some debugging?
    return nil
  end

  return page
end

function Utils.stripTags(text)
  if Utils.isset(text) then
    local tmp
    repeat
      tmp = text
      -- a pair of tags, like <td style="">...</td>
      text = string.gsub(text, '<%s*(%w+).->(.-)<%s*/%s*%1%s*>', '%2')
      -- closed tag, like <br/>
      text = string.gsub(text, '<%s*%w+%s*/%s*>', '')
    until tmp == text
  end
  return text
end

--[[ Sort table and remove repeating elements.
     Since tbl is passed as reference, any changes in it will affect the passed table. ]]
function Utils.trunkTable(tbl)
  table.sort(tbl)
  local last
  local redo
  repeat
    redo = false
    last = nil
    for k,v in pairs(tbl) do
      if v ~= last then
        last = v
      else
        table.remove(tbl, k)
        redo = true
        break
      end
    end
  until not redo
end

--[[ Checks if a given value is among the elements of a table and returns its index.
      Returns nil if it can't find it. ]]
function Utils.isInTable(tbl, val)
  for k,v in pairs(tbl) do
    if v == val then return k end
  end
  return nil
end

--[[ Compare 'n' elements in two tables, starting from 's1' in first table and 's2' in second table. ]]
function Utils.partialTableCompare(t1, t2, s1, s2, n)
  if n < 1 then return true end -- basically there's nothing to compare, so no differences were found

  for i = 0,(n-1) do
    -- Note that nil values are also valid.
    if t1[s1+i] ~= t2[s2+i] then return false end
  end

  return true
end

-- naming based on "Navbox" elements
Utils.main_colors = {
  game = {border = '#A88580', title = '#FFC9C2', above = '#FFD1CA', group = '#FFD9D2', subgroup = '#FFE1DA', dark = '#FFEEE8', background = '#FFF4EE'};
  music = {border = '#A8A077', title = '#FFF3B4', above = '#FFF6C0', group = '#FFF7C8', subgroup = '#FFF8D0', dark = '#FFFBE4', background = '#FFFBEE'};
  printwork = {border = '#9298A8', title = '#DDE6FF', above = '#E1E7FF', group = '#E6E9FF', subgroup = '#EAECFF', dark = '#EDF2FF', background = '#F4F9FF'};
}

-- function for easy adding of styles to html tags
function Utils.addStyle(tbl, val)
  if Utils.isset(val) then
    local av = tostring(val):gsub("^%s*(.-)%s*$", "%1")
    if string.sub(av, -1) ~= ';' then av = av .. ';' end
    tbl[#tbl+1] = av
  end
end

return Utils