--Categories:
--[[Category:Map modules]]

return {
    -- api_id = 15,
    -- world_id = 1,
    -- map_id = 5,
    id = "1-5",
    name = "鎮守府近海",
    name_en = "Adjacent Seas of the Naval Base",
    strategy_name = "鎮守府近海対潜哨戒",
    strategy_name_en = "Naval base adjacent waters anti-submarine patrol",
    strategy_info = "なるべく小編成の対潜哨戒部隊<br>を編成し、鎮守府近海に出没す<br>る敵潜水艦を発見・制圧せよ！",
    strategy_info_en = "Organize a small seek-and-destroy ASW fleet to clean up the submarine-infested waters near the naval base!",
    stars = 5,
    hp = false,
    kills_required = 4,
    ship_exp = 150,
    hq_non_boss_exp = 75,
    hq_boss_exp = 1050,
    eo = {
        medal = 1,
        points = 75,
    },
    items = false,
    -- sally_flag = { 1, 0 },
}