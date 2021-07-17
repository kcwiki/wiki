--Categories:
--[[Category:Map modules]]

return {
    -- api_id = 35,
    -- world_id = 3,
    -- map_id = 5,
    id = "3-5",
    name = "北方AL海域",
    name_en = "Northern AL Waters",
    strategy_name = "北方海域戦闘哨戒",
    strategy_name_en = "Northern Water Combat Patrols",
    strategy_info = "北方海域に敵増援の動きがある。<br>中規模の水上打撃部隊を派遣し、<br>敵増援を捕捉、これを撃滅せよ！",
    strategy_info_en = "There is a movement of enemy reinforcements to the northern sea.<br>Dispatch a medium size fleet, <br>intercept the enemy reinforcements and destroy it!",
    stars = 9,
    hp = false,
    kills_required = 4,
    ship_exp = 400,
    hq_non_boss_exp = 150,
    hq_boss_exp = 2300,
    eo = {
        medal = 1,
        points = 150,
    },
    items = { ammo = true },
    -- sally_flag = { 1, 0 },
}