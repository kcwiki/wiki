local _ = require('Module:Core')
local Formatting = require('Module:Formatting')
local ShipAsset = require('Module:ShipAsset')

local ShipBattleCardKai =
  ShipAsset {
  _battle_card_size = '160x40px',
  _battle_card_size_hd = '240x60px',
  _battle_card_layers = {
    attack_hawk_r = {image = 'Abyssal_Patrolling_Attack_Hawk_574_Equipment.png', top = 8, left = 126, width = 30, height = 28},
    attack_hawk_r1 = {image = 'Abyssal_Patrolling_Attack_Hawk_574_Equipment.png', top = 13, left = 106, width = 30, height = 28},
    attack_hawk_r2 = {image = 'Abyssal_Patrolling_Attack_Hawk_574_Equipment.png', top = 1, left = 127, width = 30, height = 28},
    attack_seaplane_kai_r = {image = 'Abyssal Attack Seaplane Kai.png', top = 0, left = 120, width = 35},
    cat_night_r = {image = 'Abyssal_Night_Cat_Fighter_581_Equipment.png', top = 8, left = 126, width = 35, height = 30},
    cat_night_r1 = {image = 'Abyssal_Night_Cat_Fighter_581_Equipment.png', top = 13, left = 106, width = 30, height = 28},
    cat_night_r2 = {image = 'Abyssal_Night_Cat_Fighter_581_Equipment.png', top = 1, left = 127, width = 35, height = 30},
    cat_r = {image = 'Hell plane 1.png', top = 8, left = 126, width = 25, height = 30},
    cat_r1 = {image = 'Hell plane 1.png', top = 13, left = 106, width = 25, height = 30},
    cat_r2 = {image = 'Hell plane 1.png', top = 1, left = 127, width = 25, height = 30},
    dive_night_r = {image = 'Abyssal_Night_Dive_Bomber_582_Equipment.png', top = 8, left = 126, width = 35, height = 30},
    dive_night_r1 = {image = 'Abyssal_Night_Dive_Bomber_582_Equipment.png', top = 13, left = 106, width = 26},
    dive_night_r2 = {image = 'Abyssal_Night_Dive_Bomber_582_Equipment.png', top = 1, left = 127, width = 35, height = 30},
    flagship = {image = 'Battle Card Flagship Icon.png', top = 2, right = 2, width = 18},
    fortress_ace_r1 = {image = 'Abyssal Sky Fortress Ace (Reconnaissance Model) 595 Equipment.png', top = 15, left = 104, width = 32, height = 24},
    fortress_ace_r2 = {image = 'Abyssal Sky Fortress Ace (Reconnaissance Model) 595 Equipment.png', top = 3, left = 125, width = 32, height = 24},
    fortress_heavy_ace_r1 = {image = 'Abyssal Sky Fortress Ace (Heavy Bomber Model) 598 Equipment.png', top = 15, left = 104, width = 32, height = 24},
    fortress_heavy_ace_r2 = {image = 'Abyssal Sky Fortress Ace (Heavy Bomber Model) 598 Equipment.png', top = 3, left = 125, width = 32, height = 24},
    fortress_heavy_r = {image = 'Abyssal Sky Fortress (Heavy Bomber Model) 597 Equipment.png', top = 10, left = 120, width = 32, height = 24},
    fortress_heavy_r1 = {image = 'Abyssal Sky Fortress (Heavy Bomber Model) 597 Equipment.png', top = 15, left = 104, width = 32, height = 24},
    fortress_heavy_r2 = {image = 'Abyssal Sky Fortress (Heavy Bomber Model) 597 Equipment.png', top = 3, left = 125, width = 32, height = 24},
    fortress_r = {image = 'Abyssal Sky Fortress (Reconnaissance Model) 594 Equipment.png', top = 10, left = 120, width = 32, height = 24},
    fortress_r1 = {image = 'Abyssal Sky Fortress (Reconnaissance Model) 594 Equipment.png', top = 15, left = 104, width = 32, height = 24},
    fortress_r2 = {image = 'Abyssal Sky Fortress (Reconnaissance Model) 594 Equipment.png', top = 3, left = 125, width = 32, height = 24},
    hell = {image = 'Hell plane 2.png', top = 5, left = 50, width = 30},
    hell_cat_kai_r = {image = 'Abyssal_Cat_Fighter_Kai_556_Equipment.png', top = 8, left = 126, width = 35, height = 30},
    hell_cat_kai_r1 = {image = 'Abyssal_Cat_Fighter_Kai_556_Equipment.png', top = 5, left = 104, width = 35, height = 30},
    hell_cat_kai_r2 = {image = 'Abyssal_Cat_Fighter_Kai_556_Equipment.png', top = 1, left = 127, width = 35, height = 30},
    hell_kai_l1 = {image = 'Abyssal Hell Dive Bomber Kai.png', top = 5, left = 39, width = 35},
    hell_kai_offset_l1 = {image = 'Abyssal Hell Dive Bomber Kai.png', top = 5, left = 39, width = 35},
    hell_kai_offset_r1 = {image = 'Abyssal Hell Dive Bomber Kai.png', top = 5, left = 104, width = 35},
    hell_kai_r1 = {image = 'Abyssal Hell Dive Bomber Kai.png', top = 5, left = 104, width = 35},
    hell_l1 = {image = 'Hell plane 2.png', top = 9, left = 44, width = 30},
    hell_offset_l1 = {image = 'Hell plane 2.png', top = 9, left = 44, width = 30},
    hell_offset_r1 = {image = 'Hell plane 2.png', top = 9, left = 109, width = 30},
    hell_r = {image = 'Hell plane 2.png', top = 5, left = 120, width = 30},
    hell_r1 = {image = 'Hell plane 2.png', top = 9, left = 109, width = 30},
    liberation_ace_r1 = {image = 'Abyssal Liberation Land-based Dive Bomber Ace 562 Equipment.png', top = 15, left = 104, width = 32, height = 24},
    liberation_ace_r2 = {image = 'Abyssal Liberation Land-based Dive Bomber Ace 562 Equipment.png', top = 3, left = 125, width = 32, height = 24},
    liberation_r = {image = 'Abyssal Liberation Land-based Dive Bomber 561 Equipment.png', top = 10, left = 120, width = 32, height = 24},
    liberation_r1 = {image = 'Abyssal Liberation Land-based Dive Bomber 561 Equipment.png', top = 15, left = 104, width = 32, height = 24},
    liberation_r2 = {image = 'Abyssal Liberation Land-based Dive Bomber 561 Equipment.png', top = 3, left = 125, width = 32, height = 24},
    revenge_kai_l2 = {image = 'Abyssal Revenge Torpedo Bomber Kai.png', top = 0, left = 60, width = 35, height = 44},
    revenge_kai_offset_l2 = {image = 'Abyssal Revenge Torpedo Bomber Kai.png', top = 0, left = 60, width = 35, height = 44},
    revenge_kai_offset_r2 = {image = 'Abyssal Revenge Torpedo Bomber Kai.png', top = 0, left = 125, width = 35, height = 44},
    revenge_kai_r1 = {image = 'Abyssal Revenge Torpedo Bomber Kai.png', top = 5, left = 104, width = 35, height = 44},
    revenge_kai_r2 = {image = 'Abyssal Revenge Torpedo Bomber Kai.png', top = 0, left = 125, width = 35, height = 44},
    revenge_night_r = {image = 'Abyssal_Night_Revenge_Torpedo_Bomber_583_Equipment.png', top = 8, left = 126, width = 35, height = 30},
    revenge_night_r1 = {image = 'Abyssal_Night_Revenge_Torpedo_Bomber_583_Equipment.png', top = 5, left = 104, width = 35, height = 30},
    revenge_night_r2 = {image = 'Abyssal_Night_Revenge_Torpedo_Bomber_583_Equipment.png', top = 2, left = 128, width = 30},
    revenge_r2 = {image = 'Hell plane 3.png', top = 3, left = 130, width = 30, height = 33},
    ring = {image = 'Battle Card Marriage Ring.png', top = 19, left = 140, width = 20, height = 21},
    ring_glow = {image = 'Battle Card Marriage Ring Glow.png', top = 10, left = 126, width = 36, opacity = 0.7},
    smudge_heavy = {image = 'Battle Card Smudge Heavy.png', top = 0, left = 0, width = 160, height = 40},
    smudge_light = {image = 'Battle Card Smudge Light.png', top = 0, left = 0, width = 160, height = 40},
    smudge_medium = {image = 'Battle Card Smudge Medium.png', top = 0, left = 0, width = 160, height = 40},
    status_expedition = {image = 'Battle Card Status Expedition.png', top = 0, left = 0, width = 160, height = 40},
    status_heavy_damage = {image = 'Battle Card Status Heavy Damage.png', top = 0, left = 0, width = 160, height = 40},
    status_heavy_damage_installation = {image = 'Battle Card Status Heavy Damage Installation.png', top = 0, left = 0, width = 160, height = 40},
    status_light_damage = {image = 'Battle Card Status Light Damage.png', top = 0, left = 0, width = 160, height = 40},
    status_light_damage_installation = {image = 'Battle Card Status Light Damage Installation.png', top = 0, left = 0, width = 160, height = 40},
    status_medium_damage = {image = 'Battle Card Status Medium Damage.png', top = 0, left = 0, width = 160, height = 40},
    status_medium_damage_installation = {image = 'Battle Card Status Medium Damage Installation.png', top = 0, left = 0, width = 160, height = 40},
    status_repair = {image = 'Battle Card Status Repair.png', top = 0, left = 0, width = 160, height = 40},
    status_retreat = {image = 'Battle Card Status Retreat.png', top = 0, left = 0, width = 160, height = 40},
    status_sunk = {image = 'Battle Card Status Sunk.png', top = 0, left = 0, width = 160, height = 40},
    status_sunk_installation = {image = 'Battle Card Status Sunk Installation.png', top = 0, left = 0, width = 160, height = 40},
    takoyaki = {image = 'Hell plane 2.png', top = 5, left = 50, width = 30},
  }
}

function ShipBattleCardKai:get_source(ship, args)
  return args.damaged and args.damaged ~= 'false' and ship:battle_card_damaged(true) or ship:battle_card(true)
end

local function scaleLayer(scaleWidth, scaleHeight, layer)
  local top, left, right, width, height = layer.top, layer.left, layer.right, (layer.width or layer.height), (layer.height or layer.width)
  layer.style = layer.style or {}
  if top then
    layer.style.top = _.round(scaleHeight * top) .. 'px'
  end
  if left then
    layer.style.left = _.round(scaleWidth * left) .. 'px'
  end
  if right then
    layer.style.right = _.round(scaleWidth * right) .. 'px'
  end
  if width and height then
    layer.size = _.round(scaleWidth * width) .. 'x' .. _.round(scaleHeight * height) .. 'px'
  end
  if layer.opacity then
    layer.style.opacity = tostring(layer.opacity)
  end
  return layer
end

function ShipBattleCardKai:get_layer(scaleWidth, scaleHeight, name)
  return scaleLayer(scaleWidth, scaleHeight, self._battle_card_layers[name])
end

local function parseSize(s)
    local width, height = string.match(s, "(%d+)x(%d+)")
    if width and height then
        return tonumber(width), tonumber(height)
    end
end

function ShipBattleCardKai:get(ship, args, link)
  if not args then
    args = ship
    ship = args.ship
    link = args.link
  end
  args[1] = self:get_source(ship, args)
  if not args.size then
    args.size = args.hd and self._battle_card_size_hd or self._battle_card_size
  end
  if args.marginLeft then
      self._image_wrapper_style['margin-left'] = args.marginLeft
  end
  if args.marginTop then
      self._image_wrapper_style['margin-top'] = args.marginTop
  end
  local width, height = parseSize(args.size)
  local scaleWidth = 1
  local scaleHeight = 1
  if width and height then
    scaleWidth = width / 160
    scaleHeight = height / 40
  end
  args.link = link
  local image = Formatting:format_image(args)
  local ship_layers = ship:battle_card_layers()
  if ship_layers or args.flagship or args.layers or args.grayscale then
    local stack = self:_create_stack(image, args.grayscale)
    if ship_layers then
      for i, name in ipairs(ship_layers) do
        self:_add_layer(stack, self:get_layer(scaleWidth, scaleHeight, name), ship, args, link)
      end
    end
    if args.flagship then
      self:_add_layer(stack, self:get_layer(scaleWidth, scaleHeight, 'flagship'), ship, args, link)
    end
    if args.layers then
      for i, name in ipairs(_.split(args.layers)) do
        local layer = self:get_layer(scaleWidth, scaleHeight, name)
        if layer then
          self:_add_layer(stack, layer, ship, args, link)
        end
      end
    end
    image = tostring(stack)
  end
  return image
end

function ShipBattleCardKai.formatLayerTestTable()
  local parts = {'{|\n!Code!!SD!!HD'}
  for _, layer in ipairs(_.isort(_.keys(ShipBattleCardKai._battle_card_layers))) do
    table.insert(
      parts,
      string.format(
        '|-\n!%s\n|%s\n|%s',
        layer,
        ShipBattleCardKai:Asset({'Taihou/Kai', layers = layer}),
        ShipBattleCardKai:Asset({'Taihou/Kai', layers = layer, hd = 'true'})
      )
    )
  end
  table.insert(parts, '|}')
  return table.concat(parts, '\n')
end

return ShipBattleCardKai