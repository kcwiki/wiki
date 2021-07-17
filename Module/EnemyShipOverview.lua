local EnemyShipOverview = {}

local ShipBattleCardKai = false
local EnemyShipInfoMini = false

local getArgs = require('Module:GetArgs')
local format = require('Module:Core').format

function _prepareShipBattleCardKai()
	if not ShipBattleCardKai then
		ShipBattleCardKai = require('Module:ShipBattleCardKai')
	end
end

function _prepareEnemyShipInfoMini()
	if not EnemyShipInfoMini then
		EnemyShipInfoMini = require('Module:EnemyShipInfoMini')
	end
end

local collapsible_template = [[<div style="display:inline-block;">
<div class="mw-customtoggle-${toggle_id}">
{|class="wikitable" style="cursor: pointer; margin: auto; border: 1px solid darkgray;"
| ${card_image}
|}
</div>
<div class="mw-collapsible mw-collapsed" id="mw-customcollapsible-${toggle_id}">
${table}
</div>
</div>]]

function EnemyShipOverview.EnemyInfoboxMini(frame)
	local args = getArgs{frame = frame:getParent()}
	args.link = "nil"
	_prepareShipBattleCardKai()
	_prepareEnemyShipInfoMini()
	return format{
		collapsible_template,
		toggle_id = args.id,
		card_image = ShipBattleCardKai:Asset(args),
		table = EnemyShipInfoMini:Infobox(args),
	}
end

return EnemyShipOverview