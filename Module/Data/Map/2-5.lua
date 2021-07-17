--Categories:
--[[Category:Map modules]]

return {
    -- api_id = 25,
    -- world_id = 2,
    -- map_id = 5,
    id = "2-5",
    name = "沖ノ島沖",
    name_en = "Okinoshima Sea",
    strategy_name = "沖ノ島沖戦闘哨戒",
    strategy_name_en = "Okinoshima Combat Patrol",
    strategy_info = "同方面に敵反攻の兆候が報告さ<br>れた。巡洋艦を中心に哨戒部隊<br>を編成、敵艦隊の動向を探れ！",
    strategy_info_en = "There are reports of an enemy counteroffensive. Form a cruiser patrol group and track their movements!",
    stars = 8,
    hp = false,
    kills_required = 4,
    ship_exp = 250,
    hq_non_boss_exp = 100,
    hq_boss_exp = 1200,
    eo = {
        medal = 1,
        points = 100,
    },
    items = { fuel = true, steel = true },
    -- sally_flag = { 1, 0 },
}