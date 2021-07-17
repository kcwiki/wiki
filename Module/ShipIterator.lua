local Iterator = require('Module:Iterator')

local ShipIterator = {}

ShipIterator.allForms = require('Module:Collection/Ships')
ShipIterator.baseForms = require('Module:Collection/ShipsBase')
ShipIterator.enemyForms = require('Module:Collection/EnemyShips')

ShipIterator.base = Iterator.array(ShipIterator.baseForms)

return ShipIterator