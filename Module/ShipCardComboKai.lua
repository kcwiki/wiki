local Formatting = require('Module:Formatting')
local ShipAsset = require('Module:ShipAsset')
local ShipBattleCardKai = require('Module:ShipBattleCardKai')
local ShipCardKai = require('Module:ShipCardKai')
local U = require("Module:Core")

local format = U.format
local split = U.split

local ShipCardComboKai = ShipAsset{
	_template = [[<span class="advanced-tooltip">${battle_card}<div class="tooltip-contents">${card}</div></span>]]
}

function ShipCardComboKai:get_source(ship, args)
	return ShipBattleCardKai:get_source(ship, args) .. "|" .. ShipCardKai:get_source(ship, args)
end

function ShipCardComboKai:get(ship, args, link)
	if not args then
		args = ship
		ship = args.ship
		link = args.link
	end
	return format{self._template, battle_card = ShipBattleCardKai:get(ship, {unpack(args)}, link), card = ShipCardKai:get(ship, args)}
end

return ShipCardComboKai