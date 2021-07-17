local EnemyShip = require('Module:EnemyShip')
local Formatting = require('Module:Formatting')
local getArgs = require('Module:GetArgs')
 
local EnemyShipCard = {
	_battle_card_size = "160x40px",
}
 
function EnemyShipCard:battle_card(ship, args)
	if not args then
		args = ship
		ship = args.ship
	end
	return Formatting:format_image{ship:battle_card(), size = args.size or self._battle_card_size, link = ship:base_name(), caption = ship:name()}
end
 
function EnemyShipCard:create_ship(args)
	return EnemyShip(args[1], args[2])
end
 
function EnemyShipCard:BattleCard(args)
	local ship = self:create_ship(args)
	return EnemyShipCard:battle_card(ship, args)
end

function EnemyShipCard.getFrame(frame)
	local args = getArgs{frame = frame:getParent()}
	return EnemyShipCard:BattleCard(args)
end

return EnemyShipCard