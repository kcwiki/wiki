return {
	{
		label = 'E1',
		reqQuest = 'B2',
		title = 'はじめての「補給」！',
		title_en = [=[Your First "Resupply"!]=],
		detail_en = [=[''Resupply is important! "Resupply" fuel and ammo to a ship!''
*Completion Condition: Resupply a ship.]=],
		reward_fuel = 20,
		reward_ammo = 20,
		reward_steel = 0,
		reward_bauxite = 0,
		reward_other = [=[{{QuestRewardItem|Instant Repair Material}}]=],
		note = [=[]=],
	},
	{
		label = 'E2',
		reqQuest = 'B2',
		title = 'はじめての「入渠」！',
		title_en = [=[Your First "Docking"!]=],
		detail_en = [=[''Repair a ship damaged in battle by "Docking" to prepare for the next sortie!''
*Completion Condition: Put a ship in the repair dock.]=],
		reward_fuel = 0,
		reward_ammo = 0,
		reward_steel = 30,
		reward_bauxite = 0,
		reward_other = [=[{{QuestRewardItem|Development Material}}]=],
		note = [=[]=],
	},
	{
		label = 'E3',
		reqQuest = 'E2',
		title = '艦隊大整備！',
		title_en = [=[Large-Scale Fleet Checkup!]=],
		detail_en = [=[''Put 5 or more ships from different fleets into the docks for a large-scale checkup!''
*Completion Condition: Put 5 ships in the repair dock.]=],
		reward_fuel = 30,
		reward_ammo = 30,
		reward_steel = 30,
		reward_bauxite = 30,
		reward_other = [=[{{QuestRewardItem|Instant Repair Material|qty=2}}]=],
		note = [=[''Daily quest'']=],
	},
	{
		label = 'E4',
		reqQuest = 'E3',
		title = '艦隊酒保祭り！',
		title_en = [=[Fleet Bartender's Festival!]=],
		detail_en = [=[''Fleet Bartenders are having a festival! Perform resupply 15 or more times to ships!''
*Completion Condition: Resupply ships 15 times.]=],
		reward_fuel = 50,
		reward_ammo = 50,
		reward_steel = 50,
		reward_bauxite = 50,
		reward_other = [=[{{QuestRewardItem|Instant Construction Material}}
{{QuestRewardItem|Development Material}}]=],
		note = [=[''Daily quest'']=],
	},
}