local EnemyColors = {
	_common_background_color = "lightgrey",
	_background_color = "#a0a0a0",
	_background_image = "radial-gradient(circle farthest-corner at center center , rgba(102, 102, 102, 0) 0%, rgba(102, 102, 102, 0) 60%, rgba(102, 102, 102, 0.7) 100%);",
	_plain_rare_background_color = "#b0b040",
	_plain_rare_background_image = "background-image: radial-gradient(circle farthest-corner at center center , rgba(192, 192, 0, 0) 0%, rgba(192, 192, 0, 0.4) 60%, rgba(144, 144, 0, 0.7) 100%);",
	_elite_glow_background_color = "#b56464",
	_mid_boss_background_color = "#a67474",
	_mid_boss_background_image = "radial-gradient(circle farthest-corner at center center , rgba(140, 98, 98, 0) 0%, rgba(140, 98, 98, 0) 60%, rgb(140, 98, 98) 100%);",
	_rare_background_color = "#b04040",
	_rare_background_image = "radial-gradient(circle farthest-corner at center center , #C04040 0%, #B04040 80%, #A04040);",
	_elite_glow_background_image = "radial-gradient(circle farthest-corner at center center , rgba(204, 20, 20, 0) 0%, rgba(204, 20, 20, 0) 70%, rgba(204, 20, 20, 0.8) 100%)",
	_flagship_glow_background_image = "radial-gradient(circle farthest-corner at center center , rgba(252, 200, 0, 0) 0%, rgba(252, 200, 0, 0) 70%, rgba(252, 200, 0, 0.8) 100%)",
	_kai_glow_background_image = "radial-gradient(circle farthest-corner at left, rgba(90, 245, 255, 0) 0%, rgba(90, 245, 255, 0) 86%, rgba(90, 245, 255, 0.8) 100%)",
	_late_model_glow_background_image = "radial-gradient(circle farthest-corner at left, rgba(185, 195, 205, 0) 0%, rgba(185, 195, 205, 0) 70%, rgba(185, 195, 205, 0.8) 100%)",
}

function EnemyColors:rarity_colors(ship)
	local rarity = ship:rarity()
	local bg_color
	local background_image = nil
	if rarity then
		if rarity >= 4 and rarity <= 7 then
			if rarity == 5 then
				bg_color = self._elite_glow_background_color
			elseif rarity == 6.5 then
				bg_color = self._mid_boss_background_color
				extra_style = self._mid_boss_background_image
			elseif rarity == 7 then
			    bg_color = self._plain_rare_background_color
				extra_style = self._plain_rare_background_image
			else
				bg_color = self._background_color
				extra_style = self._background_image
			end
		elseif rarity < 4 then
			bg_color = self._common_background_color
		else
			bg_color = self._rare_background_color
			background_image = self._rare_background_image
		end
	else
		bg_color = self._common_background_color
	end
	return bg_color, background_image
end

function EnemyColors:variant_background_image(ship, original_background_image)
	local back = ship:back()
	if not back then
	    return ""
	end
	local background_image = {}
	if back <= -4 and back >= -6 then
		table.insert(background_image, self._kai_glow_background_image)
	elseif back <= -7 and back >= -9 then
		table.insert(background_image, self._late_model_glow_background_image)
	end
	if back >= -9 then
		local enemy_variant = math.abs(back) % 3
		if enemy_variant == 2 then
			table.insert(background_image, self._elite_glow_background_image)
		elseif enemy_variant == 0 then
			table.insert(background_image, self._flagship_glow_background_image)
		end
	end
	if original_background_image then
		table.insert(background_image, original_background_image)
	end
	if #background_image > 0 then
		return table.concat(background_image, ", ")
	end
end

return EnemyColors