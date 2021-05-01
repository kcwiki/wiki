local p = {}
local remiLib = require("Module:RemiLib")

function p.createDropTable(frame)
	-- entries are in the form of <Node>_<Ship Type> = <List of Ships>
	local drops = {}
	for param, list in pairs(frame.args) do
		local label = string.upper(mw.text.split(param, "_")[1]) -- Should be single letter in uppercase
		local shipCode = mw.text.split(param, "_")[2] -- One of DE, DD, CL, CA, BB, CV, CVL, AV, SS, AUX
		if drops[label] == nil then
			drops[label] = {}
		end
		drops[label][shipCode] = list
	end

	local numTypes = {}
	local validLabels = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","Z1", "Z2", "Z3", "Z4", "Z5", "Z6", "Z7", "Z8", "Z9", "ZZ1", "ZZ2", "ZZ3"}
	local shipTypes = {"DE", "DD", "CL", "CA", "BB", "CV", "CVL", "AV", "SS", "AUX"}

	for i, letter in pairs(validLabels) do
		numTypes[letter] = 0
	end
	for x, node in pairs(validLabels) do
		if drops[node] ~= nil then
			for y, ship in pairs(shipTypes) do
				if drops[node][ship] ~= nil then
					numTypes[node] = numTypes[node] + 1
				end
			end
		end
	end

	local tablehtml = '<table class="mw-collapsible mw-collapsed wikitable" style="width:100%">'
	tablehtml = tablehtml .. '<tr><th style="width:50px;">Node</th><th colspan="2">Ship List</th></tr>'

	local classLink = {}
	classLink["DE"] = '[[Destroyer Escorts]]'
	classLink["DD"] = '[[EliteDD|Destroyers]]'
	classLink["CL"] = '[[EliteCL|Light Cruisers]]'
	classLink["CA"] = '[[EliteCA|Heavy Cruisers]]'
	classLink["BB"] = '[[EliteBB|Battleships]]'
	classLink["CV"] = '[[EliteDD|Aircraft Carriers]]'
	classLink["CVL"] = '[[EliteDD|Light Aircraft Carriers]]'
	classLink["AV"] = '[[EliteAV|Seaplane Tenders]]'
	classLink["SS"] = '[[EliteSS|Submarines]]'
	classLink["AUX"] = '[[Auxiliary Ships]]'

	for x, node in pairs(validLabels) do
		if numTypes[node] > 0 then
			tablehtml = tablehtml .. '<tr><td style="text-align:center; font-size:18px; font-weight:bold;" '
			tablehtml = tablehtml .. 'rowspan="' .. numTypes[node] .. '">' .. node .. '</td>'
			
			remTypes = numTypes[node]
			for y, ship in pairs(shipTypes) do
				if drops[node][ship] ~= nil then
					tablehtml = tablehtml .. '<td style="text-align:center; width:70px;">' .. classLink[ship] .. '</td>'
					tablehtml = tablehtml .. '<td>' .. drops[node][ship] .. '</td>'
					remTypes = remTypes - 1
					if remTypes > 0 then
						tablehtml = tablehtml .. '</tr><tr>'
					else
						tablehtml = tablehtml .. '</tr>'
						break
					end
				end
			end
		end
	end

	tablehtml = tablehtml .. '</table>'
	return tablehtml
end

return p