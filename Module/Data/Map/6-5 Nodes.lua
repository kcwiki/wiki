--Categories:
--[[Category:Map modules]]

return { {
    label = "A",
    name = "先遣任務部隊 前衛艦隊",
    patterns = { {
        fleet = { "Light Cruiser He-Class/Flagship", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model" },
        formations = { "Line Ahead" },
        exp = 100,
      }, {
        fleet = { "Light Cruiser He-Class/Flagship", "Light Cruiser Ho-Class/Flagship", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model" },
        formations = { "Line Ahead" },
        exp = 110,
      }, {
        fleet = { "Light Cruiser He-Class/Flagship", "Light Cruiser Ho-Class/Flagship", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model" },
        formations = { "Line Ahead" },
        exp = 120,
      }, {
        fleet = { "Light Cruiser He-Class/Flagship", "Light Cruiser Ho-Class/Flagship", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model" },
        formations = { "Line Ahead" },
        exp = 130,
      }, {
        fleet = { "Light Cruiser He-Class/Flagship", "Light Cruiser Ho-Class/Flagship", "Destroyer Ha-Class/Late Model", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model" },
        formations = { "Line Ahead" },
        exp = 140,
      }, {
        fleet = { "Light Cruiser He-Class/Flagship", "Light Cruiser Ho-Class/Flagship", "Destroyer Ha-Class/Late Model", "Destroyer Ha-Class/Late Model", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model" },
        formations = { "Line Ahead" },
        exp = 150,
      }, {
        fleet = { "Light Cruiser He-Class/Flagship", "Light Cruiser Ho-Class/Flagship", "Light Cruiser Ho-Class/Flagship", "Destroyer Ha-Class/Late Model", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model" },
        formations = { "Line Ahead" },
        exp = 160,
      }, {
        final = true,
        fleet = { "Light Cruiser He-Class/Flagship", "Light Cruiser Ho-Class/Flagship", "Light Cruiser Ho-Class/Flagship", "Destroyer Ha-Class/Late Model", "Destroyer Ha-Class/Late Model", "Destroyer Ha-Class/Late Model" },
        formations = { "Line Ahead" },
        exp = 170,
      }, {
        final = true,
        fleet = { "Light Cruiser He-Class/Flagship", "Light Cruiser He-Class/Flagship", "Light Cruiser Ho-Class/Flagship", "Light Cruiser Ho-Class/Flagship", "Destroyer Ha-Class/Late Model", "Destroyer Ha-Class/Late Model" },
        formations = { "Line Ahead" },
        exp = 180,
      } }
  }, {
    label = "B",
    name = "深海潜水艦隊 前方展開部隊",
    patterns = { {
        fleet = { "Submarine Ka-Class/Elite", "Submarine Ka-Class/Elite", "Submarine Ka-Class/Elite" },
        formations = { "Echelon" },
        exp = 90,
      }, {
        fleet = { "Submarine Ka-Class/Flagship", "Submarine Ka-Class/Elite", "Submarine Ka-Class/Elite" },
        formations = { "Echelon", "Line Abreast" },
        exp = 100,
      }, {
        fleet = { "Submarine Ka-Class/Flagship", "Submarine Ka-Class/Elite", "Submarine Ka-Class/Elite", "Submarine Ka-Class/Elite" },
        formations = { "Echelon", "Line Abreast" },
        exp = 120,
      }, {
        final = true,
        fleet = { "Submarine Ka-Class/Flagship", "Submarine Ka-Class/Flagship", "Submarine Ka-Class/Elite", "Submarine Ka-Class/Elite", "Submarine Ka-Class/Elite" },
        formations = { "Echelon", "Line Abreast" },
        exp = 160,
      } }
  }, {
    drops = { "Akigumo", "Hiyou", "Junyou", "Kuma", "Nagara", "Ryuujou", "Sendai" },
    label = "C",
    name = "先遣任務部隊",
    patterns = { {
        fleet = { "Standard Carrier Wo-Class/Kai Flagship IV", "Battleship Ta-Class/Flagship", "Light Cruiser Tsu-Class", "Light Cruiser Tsu-Class", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model" },
        formations = { "Diamond" },
        exp = 240,
      }, {
        fleet = { "Standard Carrier Wo-Class/Kai Flagship IV", "Battleship Ta-Class/Flagship", "Heavy Cruiser Ne-Class", "Light Cruiser Tsu-Class", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model" },
        formations = { "Diamond" },
        exp = 240,
      }, {
        fleet = { "Standard Carrier Wo-Class/Kai Flagship IV", "Battleship Ta-Class/Flagship", "Heavy Cruiser Ne-Class", "Heavy Cruiser Ne-Class", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model" },
        formations = { "Diamond" },
        exp = 240,
      }, {
        fleet = { "Standard Carrier Wo-Class/Kai Flagship IV", "Battleship Ta-Class/Flagship", "Light Cruiser Tsu-Class/Elite", "Light Cruiser Tsu-Class", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model" },
        formations = { "Diamond" },
        exp = 270,
      }, {
        fleet = { "Standard Carrier Wo-Class/Kai Flagship IV", "Battleship Ta-Class/Flagship", "Heavy Cruiser Ne-Class/Elite", "Light Cruiser Tsu-Class", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model" },
        formations = { "Diamond" },
        exp = 270,
      }, {
        fleet = { "Standard Carrier Wo-Class/Kai Flagship IV", "Battleship Ta-Class/Flagship", "Heavy Cruiser Ne-Class/Elite", "Heavy Cruiser Ne-Class", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model" },
        formations = { "Diamond" },
        exp = 270,
      }, {
        final = true,
        fleet = { "Standard Carrier Wo-Class/Kai Flagship IV", "Battleship Ta-Class/Flagship", "Light Cruiser Tsu-Class/Elite", "Light Cruiser Tsu-Class/Elite", "Destroyer Ha-Class/Late Model", "Destroyer Ha-Class/Late Model" },
        formations = { "Diamond" },
        exp = 300,
      }, {
        final = true,
        fleet = { "Standard Carrier Wo-Class/Kai Flagship IV", "Battleship Ta-Class/Flagship", "Heavy Cruiser Ne-Class/Elite", "Light Cruiser Tsu-Class/Elite", "Destroyer Ha-Class/Late Model", "Destroyer Ha-Class/Late Model" },
        formations = { "Diamond" },
        exp = 300,
      }, {
        final = true,
        fleet = { "Standard Carrier Wo-Class/Kai Flagship IV", "Battleship Ta-Class/Flagship", "Heavy Cruiser Ne-Class/Elite", "Heavy Cruiser Ne-Class/Elite", "Destroyer Ha-Class/Late Model", "Destroyer Ha-Class/Late Model" },
        formations = { "Diamond" },
        exp = 300,
      } }
  }, {
    drops = { "Abukuma", "Akigumo", "Hiyou", "Junyou", "Kinu", "Kitakami", "Kuma", "Nagara", "Ooi", "Ryuujou", "Sendai", "Shouhou" },
    label = "D",
    name = "深海護衛空母部隊 B群",
    patterns = { {
        fleet = { "Light Carrier Nu-Class/Flagship", "Light Carrier Nu-Class/Flagship", "Light Cruiser Tsu-Class", "Destroyer Ro-Class/Late Model", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model" },
        formations = { "Diamond", "Double Line", "Line Ahead" },
        exp = 200,
      }, {
        fleet = { "Light Carrier Nu-Class/Flagship", "Light Carrier Nu-Class/Flagship", "Heavy Cruiser Ne-Class/Elite", "Light Cruiser Tsu-Class", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model" },
        formations = { "Diamond", "Double Line", "Line Ahead" },
        exp = 240,
      }, {
        final = true,
        fleet = { "Light Carrier Nu-Class/Flagship", "Light Carrier Nu-Class/Flagship", "Heavy Cruiser Ne-Class/Elite", "Light Cruiser Tsu-Class/Elite", "Destroyer Ha-Class/Late Model", "Destroyer Ha-Class/Late Model" },
        formations = { "Diamond", "Double Line", "Line Ahead" },
        exp = 270,
      } }
  }, {
    label = "E",
    name = "深海潜水艦隊 精鋭群狼部隊",
    patterns = { {
        fleet = { "Submarine So-Class/Flagship", "Submarine So-Class/Elite", "Submarine So-Class/Elite" },
        formations = { "Echelon", "Line Abreast" },
        exp = 120,
      }, {
        fleet = { "Submarine So-Class/Flagship", "Submarine So-Class/Elite", "Submarine So-Class/Elite", "Submarine So-Class/Elite" },
        formations = { "Echelon", "Line Abreast" },
        exp = 180,
      }, {
        fleet = { "Submarine So-Class/Flagship", "Submarine So-Class/Elite", "Submarine So-Class/Elite", "Submarine So-Class/Elite", "Submarine So-Class/Elite" },
        formations = { "Echelon", "Line Abreast" },
        exp = 200,
      }, {
        fleet = { "Submarine So-Class/Flagship", "Submarine So-Class/Elite", "Submarine So-Class/Elite", "Submarine So-Class/Elite", "Submarine So-Class/Elite", "Submarine So-Class/Elite" },
        formations = { "Echelon" },
        exp = 220,
      }, {
        final = true,
        fleet = { "Submarine So-Class/Flagship", "Submarine So-Class/Flagship", "Submarine So-Class/Elite", "Submarine So-Class/Elite", "Submarine So-Class/Elite", "Submarine So-Class/Elite" },
        formations = { "Echelon", "Line Abreast" },
        exp = 250,
      } }
  }, {
    label = "F",
    name = "深海巡洋艦戦隊",
    patterns = { {
        fleet = { "Heavy Cruiser Ri-Class/Flagship", "Torpedo Cruiser Chi-Class/Flagship", "Torpedo Cruiser Chi-Class/Flagship", "Light Cruiser Ho-Class/Flagship", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model" },
        formations = { "Double Line", "Echelon", "Line Ahead" },
        exp = 120,
      }, {
        fleet = { "Heavy Cruiser Ri-Class/Flagship", "Torpedo Cruiser Chi-Class/Flagship", "Torpedo Cruiser Chi-Class/Flagship", "Light Cruiser He-Class/Flagship", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model" },
        formations = { "Double Line" },
        exp = 140,
       }, {
        final = true,
        fleet = { "Heavy Cruiser Ri-Class/Kai Flagship", "Torpedo Cruiser Chi-Class/Flagship", "Torpedo Cruiser Chi-Class/Flagship", "Light Cruiser He-Class/Flagship", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model" },
        formations = { "Double Line", "Echelon", "Line Ahead" },
        exp = 160,
      } }
  }, {
    label = "G",
    name = "深海任務部隊 艦載機群",
    type = "raid",
    patterns = { {
        fleet = { "Aircraft Carrier Princess", "Standard Carrier Wo-Class/Flagship IV", "Heavy Cruiser Ri-Class/Flagship", "Light Cruiser Tsu-Class/Elite", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model" },
        formations = { "Diamond" },
        exp = 200,
      }, {
        fleet = { "Aircraft Carrier Princess", "Standard Carrier Wo-Class/Flagship IV", "Standard Carrier Wo-Class/Flagship IV", "Light Cruiser Tsu-Class/Elite", "Destroyer Ha-Class/Late Model", "Destroyer Ha-Class/Late Model" },
        formations = { "Diamond" },
        exp = 250,
      }, {
        final = true,
        fleet = { "Aircraft Carrier Princess", "Standard Carrier Wo-Class/Flagship IV", "Standard Carrier Wo-Class/Flagship IV", "Light Cruiser Tsu-Class/Elite", "Destroyer Ni-Class/Late Model", "Destroyer Ni-Class/Late Model" },
        formations = { "Diamond" },
        exp = 250,
      } }
  }, {
    label = "H",
    name = "深海任務部隊 艦載機群",
    type = "raid",
    patterns = { {
        fleet = { "Standard Carrier Wo-Class/Flagship IV", "Heavy Cruiser Ri-Class/Flagship", "Light Cruiser Tsu-Class/Elite", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model" },
        formations = { "Diamond" },
        exp = 120,
      }, {
        fleet = { "Standard Carrier Wo-Class/Flagship IV", "Standard Carrier Wo-Class/Flagship IV", "Light Cruiser Tsu-Class/Elite", "Destroyer Ha-Class/Late Model", "Destroyer Ha-Class/Late Model", "Destroyer Ha-Class/Late Model" },
        formations = { "Diamond" },
        exp = 160,
      }, {
        final = true,
        fleet = { "Aircraft Carrier Princess", "Standard Carrier Wo-Class/Flagship IV", "Light Cruiser Tsu-Class/Elite", "Destroyer Ni-Class/Late Model", "Destroyer Ni-Class/Late Model", "Destroyer Ni-Class/Late Model" },
        formations = { "Diamond" },
        exp = 200,
      } }
  }, {
    drops = { "Hiyou", "Nagara", "Ryuujou" },
    label = "I",
    name = "深海護衛空母部隊 A群",
    patterns = { {
        fleet = { "Light Carrier Nu-Class/Flagship", "Light Carrier Nu-Class/Flagship", "Light Cruiser Tsu-Class", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model" },
        formations = { "Diamond", "Double Line" },
        exp = 200,
      }, {
        fleet = { "Light Carrier Nu-Class/Flagship", "Light Carrier Nu-Class/Flagship", "Light Cruiser Tsu-Class/Elite", "Destroyer Ha-Class/Late Model", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model" },
        formations = { "Diamond", "Double Line", "Line Ahead" },
        exp = 230,
      }, {
        final = true,
        fleet = { "Light Carrier Nu-Class/Flagship", "Light Carrier Nu-Class/Flagship", "Light Cruiser He-Class/Flagship", "Light Cruiser Tsu-Class/Elite", "Destroyer Ha-Class/Late Model", "Destroyer Ha-Class/Late Model" },
        formations = { "Diamond", "Double Line", "Line Ahead" },
        exp = 260,
      } }
  }, {
    drops = { "Abukuma", "I-19", "Kuma" },
    label = "J",
    name = "深海護衛空母部隊 C群",
    type = "night",
    patterns = { {
        fleet = { "Light Carrier Nu-Class/Flagship", "Light Cruiser He-Class/Flagship", "Light Cruiser Tsu-Class", "Destroyer I-Class", "Destroyer I-Class", "Destroyer I-Class" },
        formations = { "Diamond", "Double Line", "Line Ahead" },
        exp = 180,
      }, {
        fleet = { "Light Carrier Nu-Class/Flagship", "Light Cruiser He-Class/Flagship", "Light Cruiser Tsu-Class", "Destroyer I-Class/Late Model", "Destroyer I-Class", "Destroyer I-Class" },
        formations = { "Diamond", "Double Line", "Line Ahead" },
        exp = 190,
      }, {
        final = true,
        fleet = { "Light Carrier Nu-Class/Flagship", "Light Cruiser He-Class/Flagship", "Light Cruiser Tsu-Class", "Destroyer Ro-Class/Late Model", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model" },
        formations = { "Diamond", "Double Line", "Line Ahead" },
        exp = 200,
      } }
  }, {
    label = "K",
    type = "empty",
  }, {
    label = "L",
    type = "empty",
  }, {
    -- all from wikiwiki
    drops = { "Abukuma", "Akagi", "Akigumo", "Asashimo", "Atago", "Furutaka", "Haruna", "Harusame", "Hiei", "Kaga", "Kashima", "Kawakaze", "Kinu", "Kinugasa", "Kirishima", "Kongou", "Maikaze", "Makigumo", "Miyuki", "Mutsu", "Mutsuki", "Myoukou", "Naganami", "Nagato", "Nowaki", "Okinami", "Shoukaku", "Suzuya", "Takanami", "Takao", "Tatsuta", "Umikaze", "Yuubari", "Yuugumo", "Zuikaku" },
    label = "M",
    name = "任務部隊 主力群",
    type = "boss",
    patterns = { {
        fleet = { "Aircraft Carrier Princess", "Standard Carrier Wo-Class/Flagship IV", "Heavy Cruiser Ri-Class/Flagship", "Light Cruiser Tsu-Class/Elite", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model", "Light Cruiser He-Class/Flagship", "Heavy Cruiser Ri-Class/Flagship", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model" },
        formations = { "Cruising Formation 3" },
        exp = 500,
      }, {
        fleet = { "Aircraft Carrier Princess", "Standard Carrier Wo-Class/Flagship IV", "Standard Carrier Wo-Class/Flagship IV", "Light Cruiser Tsu-Class/Elite", "Destroyer Ha-Class/Late Model", "Destroyer Ha-Class/Late Model", "Light Cruiser He-Class/Flagship", "Heavy Cruiser Ri-Class/Flagship", "Heavy Cruiser Ri-Class/Flagship", "Destroyer Ha-Class/Late Model", "Destroyer I-Class/Late Model", "Destroyer I-Class/Late Model" },
        formations = { "Cruising Formation 3" },
        exp = 520,
      }, {
        final = true,
        fleet = { "Aircraft Carrier Princess", "Standard Carrier Wo-Class/Flagship IV", "Standard Carrier Wo-Class/Flagship IV", "Light Cruiser Tsu-Class/Elite", "Destroyer Ni-Class/Late Model", "Destroyer Ni-Class/Late Model", "Light Cruiser He-Class/Flagship", "Heavy Cruiser Ri-Class/Flagship", "Heavy Cruiser Ri-Class/Flagship", "Destroyer Ha-Class/Late Model", "Destroyer Ro-Class/Late Model", "Destroyer Ro-Class/Late Model" },
        formations = { "Cruising Formation 3" },
        exp = 550,
      } }
  } }