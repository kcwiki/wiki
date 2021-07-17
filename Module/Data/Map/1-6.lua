--Categories:
--[[Category:Map modules]]

return {
    -- api_id = 16,
    -- world_id = 1,
    -- map_id = 6,
    id = "1-6",
    name = "鎮守府近海航路",
    name_en = "Naval Base Adjacent Sea Route",
    strategy_name = "輸送船団護衛作戦",
    strategy_name_en = "Transport Ships Escort Operation",
    strategy_info = "対潜及び防空能力に優れた艦艇<br>を基幹戦力とした艦隊を編成、<br>輸送船団航路の護衛にあたれ！",
    strategy_info_en = "Form a fleet consisting of ships that excel at anti-submarine warfare and in anti-aircraft capabilities, and protect the transport ship routes!",
    stars = 5,
    banner_stars = 6,
    hp = false,
    kills_required = 7,
    ship_exp = false,
    hq_non_boss_exp = 80,
    hq_boss_exp = false,
    eo = {
        present_box = 1,
        points = 75,
    },
    items = { fuel = true, ammo = true, steel = true, bauxite = true },
    -- sally_flag = { 1, 0 },
}