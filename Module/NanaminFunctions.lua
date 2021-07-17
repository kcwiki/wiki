local Ship = require("Module:Ship")

local NanaminFunctions = {}

function NanaminFunctions.split(haystack, needle)
    local special_inputs = {
        "Zero Fighter Model 52C (w/ Iwai Flight)",
        "Zero Fighter Model 21 (w/ Iwamoto Flight)",
        "Zero Fighter Model 52A (w/ Iwamoto Flight)",
        "203mm/53 Twin Gun Mount",
        "Zero Fighter Model 62 (Fighter-bomber / Iwai Squadron)",
        "381mm/50 Triple Gun Mount Kai",
        "381mm/50 Triple Gun Mount",
    }
    local result = {}
    while mw.ustring.find(haystack, needle) do
        local split = mw.ustring.find(haystack, needle)
        local input = mw.ustring.sub(haystack, 1, split - 1)
        
        for _, value in pairs(special_inputs) do
            if mw.ustring.sub(haystack, 1, #value) == value then
                input = mw.ustring.sub(haystack, 1, #value)
                haystack = mw.ustring.sub(haystack, split + 1)
                split = mw.ustring.find(haystack, needle) or 0
                break
            end
        end
        
        table.insert(result, input)
        haystack = mw.ustring.sub(haystack, split + 1)
        if split == 0 then haystack = "" end
    end
    if haystack ~= "" then table.insert(result, haystack) end
    return result
end

function NanaminFunctions.add_to_fighter_power(current_fp, equip, planes)
    --Only fighter planes, dive bombers, torpedo bombers and seaplane bombers with an AA stat are counted
    local types_allowed = { [6] = true, [7] = true, [8] = true, [11] = true }
    if types_allowed[equip:type()] and equip:aa() then
        current_fp = current_fp + math.floor(math.sqrt(planes) * equip:aa())
    end
    return current_fp
end

function NanaminFunctions.add_to_elos_ship(current_elos, entry, use_los)
    if entry[3] == nil then return current_elos end
    local ship = Ship(entry[1], entry[2])
    local los = ship:los() or 0
    local los_max = ship:los_max() or los
    if use_los then
        los = tonumber(entry[3])
    else
        los = math.floor(los + ((los_max - los) * tonumber(entry[3]) / 99))
    end
    return current_elos + math.sqrt(los) * 1.69
end

function NanaminFunctions.add_to_elos(current_elos, equip)
    --[[Effective LoS = Dive Bomber LoS x (1.04) + Torpedo Bomber LoS x (1.37)
    + Carrier-based Recon Plane LoS x (1.66) + Recon Seaplane LoS x (2.00)
    + Seaplane Bomber LoS x (1.78) + Small Radar LoS x (1.00) + Large Radar LoS x (0.99)
    + Searchlight LoS x (0.91) + √(base LoS of each ship) * (1.69)
    + (HQ Lv. rounded up to the next multiple of 5) x (-0.61)--]]
    local multiplier = { [7] = 1.04, [8] = 1.04, [9] = 1.66, [10] = 2.00, [11] = 1.78, [12] = 1.00, [13] = 0.99, [29] = 0.91 }
    if multiplier[equip:type()] ~= nil and equip:los() then
        current_elos = current_elos + (equip:los() * multiplier[equip:type()])
    end
    return current_elos
end

function NanaminFunctions.get_hq_bracket(hq_level)
    local bracket = tonumber(hq_level or 0)
 
    --Get bracket of 5
    bracket = bracket - (bracket % 5) + 5
    if tonumber(hq_level or 0) % 5 == 0 then
        bracket = bracket + 5
    end
    
    return bracket
end

function NanaminFunctions.process_legacy_name(name)
    local names = {
        ["12cm Naval Gun"] = "12cm Single Gun Mount",
        ["12.7cm Naval Gun"] = "12.7cm Single Gun Mount",
        ["12.7cm Twin Mount Type-B Kai 2"] = "12.7cm Twin Gun Mount Model B Kai Ni",
        
        ["14cm Naval Gun"] = "14cm Single Gun Mount",
        ["15.5cm Triple Gun Mount (Main)"] = "15.5cm Triple Gun Mount",
        ["20.3cm(no.2) Twin Gun Mount"] = "20.3cm (No.2) Twin Gun Mount",
        ["20.3cm(no.3) Twin Gun Mount"] = "20.3cm (No.3) Twin Gun Mount",
        ["SKC34 20.3cm Twin Cannon"] = "SKC34 20.3cm Twin Gun Mount",
        
        ["Prototype 41cm Triple Cannon"] = "Prototype 41cm Triple Gun Mount",
        ["Prototype 51cm Twin Cannon"] = "Prototype 51cm Twin Gun Mount",
        
        ["15.2cm Naval Gun"] = "15.2cm Single Gun Mount",
        ["15.5cm Triple Gun Mount (Secondary)"] = "15.5cm Triple Secondary Gun Mount",
        ["15cm Twin Gun Mount"] = "15cm Twin Secondary Gun Mount",
        
        ["8cm Twin High-angle Mount"] = "8cm High-angle Gun",
        ["10cm Twin High-angle Mount"] = "10cm Twin High-angle Gun Mount",
        ["10cm Twin High-angle Gun Mount (Carriage)"] = "10cm Twin High-angle Carriage Mount",
        ["10cm Twin High-angle Mount + Anti-Aircraft Fire Director"] = "10cm Twin High-angle Gun Mount + Anti-Aircraft Fire Director",
        
        ["12.7cm High-angle Mount"] = "12.7cm Single High-angle Gun Mount",
        ["12.7cm Twin High-angle Mount"] = "12.7cm Twin High-angle Gun Mount",
        ["12.7cm Twin High-angle Mount (Late Model)"] = "12.7cm Twin High-angle Gun Mount (Late Model)",
        ["12.7cm Twin High-angle Mount + Anti-Aircraft Fire Director"] = "12.7cm High-angle Gun + Anti-Aircraft Fire Director",
        
        ["12.7mm Machine Gun"] = "12.7mm Single Machine Gun Mount",
        ["25mm Autocannon"] = "25mm Single Autocannon Mount",
        ["BI-type 40mm Twin Machine Gun"] = "Type Bi 40mm Twin Autocannon Mount",
        ["25mm Triple Autocannon Mount (Concentrated Deployment)"] = "25mm Triple Autocannon Mount Concentrated Deployment",  
        
        ["61cm Quad Torpedo Mount"] = "61cm Quadruple Torpedo Mount",
        ["61cm Quad Oxygen Torpedo Mount"] = "61cm Quadruple (Oxygen) Torpedo Mount",
        ["61cm Quint Oxygen Torpedo Mount"] = "61cm Quintuple (Oxygen) Torpedo Mount",
        ["53cm Hull-mount O2 Torpedoes"] = "53cm Bow (Oxygen) Torpedo Mount",
        ["53cm Submarine Bow Torpedo Mount (8 tubes)"] = "Submarine 53cm Bow Torpedo Mount (8 tubes)",
        ["Type A Ko-hyoteki"] = "Kouhyouteki",
        
        ["Type 21 Zero Fighter"] = "Type 0 Fighter Model 21",
        ["Type 21 Zero Fighter (Skilled)"] = "Type 0 Fighter Model 21 (Skilled)",
        ["Type 52 Zero Fighter"] = "Type 0 Fighter Model 52",
        ["Zero Fighter Type 52 Type C (601 Air Group)"] = "Zero Fighter Model 52C (601 Air Group)",
        ["Shiden Kai 2"] = "Shiden Kai Ni",
        ["Type 62 Zero Fighter-bomber"] = "Type 0 Fighter Model 62 (Fighter-bomber)",
        ["Type 2 Recon Aircraft"] = "Type 2 Reconnaissance Aircraft",
        
        ["Type 0 Recon Seaplane"] = "Type 0 Reconnaissance Seaplane",
        ["Type 98 Recon Seaplane (Night Recon)"] = "Type 98 Reconnaissance Seaplane (Night Recon)",
        
        ["Ka-type Observation Autogyro"] = "No. Ka Observation Autogyro",
        ["Type 3 Spotter/Liaison (ASW)"] = "Type 3 Command Liaison Aircraft (ASW)",
        ["Type 22 Surface RADAR Kai 4"] = "No. 22 Surface Radar Kai Yon",
        ["Type 13 AIR RADAR Kai"] = "No. 13 Air Radar Kai",
        ["Type 21 Air RADAR Kai"] = "No. 21 Air Radar Kai",
        
        ["Type 93 Passive SONAR"] = "Type 93 Passive Sonar",
        ["Type 3 SONAR"] = "Type 3 Active Sonar",
        ["Type 0 Passive SONAR"] = "Type 0 Passive Sonar",
        ["Type 94 Depth Charge"] = "Type 94 Depth Charge Projector",
        ["Type 3 Depth Charge"] = "Type 3 Depth Charge Projector",
        
        ["Type 91 Armor-Piercing (AP) Shell"] = "Type 91 Armor Piercing Shell",
        ["Type 1 Armor-Piercing (AP) Shell"] = "Type 1 Armor Piercing Shell",
        
        ["Improved Steam Turbine"] = "Improved Kanhon Type Turbine",
        ["Enhanced Steam Boiler"] = "Enhanced Kanhon Type Boiler",
        ["New High Pressure-Temperature Steam Boiler"] = "New Model High Temperature High Pressure Boiler",
        
        ["Repair Team"] = "Emergency Repair Personnel",
        ["Repair Goddess"] = "Emergency Repair Goddess",
        
        ["Anti-torpedo Bulge (Medium)"] = "Extension Bulge (Medium)",
        ["Anti-torpedo Bulge (Large)"] = "Extension Bulge (Large)",
        
        ["Drum Canister"] = "Drum Canister (Transport Use)",
        ["Daihatsu-class Landing Craft"] = "Daihatsu Landing Craft",
        
    }
    
    --Radar/sonar names without any special pieces
    name = name:gsub("^Type%s(.+)%sRADAR$", "No. %1 Radar")
    
    name = names[name] or name
    return name
end

function NanaminFunctions.shorten_name(page, name)
    if not name then
        name = page
    end
    --This takes an equipment name listed on Sandbox/EquipmentListKai/TypeSorted
    --and switches it with a shorter version of the name.
    local shortened = {
        ["12cm Single Gun Mount"] = "12cm Naval Gun" ,
        ["12.7cm Single Gun Mount"] = "12.7cm Naval Gun",
        ["12.7cm Twin Gun Mount Model B Kai Ni"] = "12.7cm Twin Mount Type-B Kai 2" ,
               
        ["14cm Single Gun Mount"] = "14cm Naval Gun",
        ["15.5cm Triple Gun Mount"] = "15.5cm Triple Gun Mount (Main)",
        ["20.3cm (No.2) Twin Gun Mount"] = "20.3cm(no.2) Twin Gun Mount",
        ["20.3cm (No.3) Twin Gun Mount"] = "20.3cm(no.3) Twin Gun Mount",
        ["SKC34 20.3cm Twin Gun Mount"] = "SKC34 20.3cm Twin Cannon",
               
        ["35.6cm Twin Gun Mount (Dazzle Camouflage)"] = "35.6cm Twin Gun Mount (Dazzle)",
        ["Prototype 41cm Triple Gun Mount"] = "Prototype 41cm Triple Cannon",
        ["Prototype 51cm Twin Gun Mount"] = "Prototype 51cm Twin Cannon",
               
        ["15.2cm Single Gun Mount"] = "15.2cm Naval Gun",
        ["15.5cm Triple Secondary Gun Mount"] = "15.5cm Triple Gun (Secondary)",
        ["15cm Twin Secondary Gun Mount"] = "15cm Twin Gun Mount",
        ["OTO 152mm Triple Rapid Fire Gun Mount"] = "152mm Triple Rapid Fire Gun",
               
        ["8cm High-angle Gun"] = "8cm Twin High-angle Mount",
        ["10cm Twin High-angle Gun Mount"] = "10cm Twin HA Mount",
        ["10cm Twin High-angle Carriage Mount"] = "10cm Twin HA Gun(Carriage)",
        ["10cm Twin High-angle Gun Mount + Anti-Aircraft Fire Director"] = "10cm Twin HA Gun + AAFD",
        ["12.7cm Single High-angle Gun Mount"] = "12.7cm High-angle Mount",
        ["12.7cm Twin High-angle Mount"] = "12.7cm Twin High-angle Gun Mount",
        ["12.7cm Twin High-angle Gun Mount (Late Model)"] = "12.7cm Twin HA Gun (L M)",
        ["12.7cm High-angle Gun + Anti-Aircraft Fire Director"] = "12.7cm High-angle Gun + AAFD",
               
        ["12.7mm Single Machine Gun Mount"] = "12.7mm Machine Gun",
        ["25mm Single Autocannon Mount"] = "25mm Autocannon",
        ["Type Bi 40mm Twin Autocannon Mount"] = "BI-type 40mm Twin Machine Gun",
        ["25mm Triple Autocannon Mount Concentrated Deployment"] = "25mm Triple Autocannon (C D)",  
       
        ["61cm Quadruple Torpedo Mount"] = "61cm Quad Torpedo",
        ["61cm Triple (Oxygen) Torpedo Mount"] = "61cm Triple (Oxygen) Torpedo",               
        ["61cm Quadruple (Oxygen) Torpedo Mount"] = "61cm Quad Oxygen Torpedo",
        ["61cm Quintuple (Oxygen) Torpedo Mount"] = "61cm Quint Oxygen Torpedo",
        ["53cm Bow (Oxygen) Torpedo Mount"] = "53cm Hull-mount O2 Torpedoes",
        ["Submarine 53cm Bow Torpedo Mount (8 tubes)"] = "53cm Submarine Bow Torpedo",
        ["Kouhyouteki"] = "Type A Ko-hyoteki",
        ["Prototype FaT Type 95 Oxygen Torpedo Kai"] = "Prototype FaT Type 95 Torpedo",
               
        ["Type 0 Fighter Model 21"] = "Type 21 Zero Fighter",
        ["Type 0 Fighter Model 21 (Skilled)"] = "Type 21 Zero Fighter (Skilled)",
        ["Type 0 Fighter Model 52"] = "Type 52 Zero Fighter",
        ["Zero Fighter Model 52C (601 Air Group)"] = "Zero Fighter Type 52 C (601)",
        ["Type 97 Torpedo Bomber (Skilled)"] = "Type 97 Torp Bomber (Skilled)",
        ["Type 97 Torpedo Bomber (931 Air Group)"] = "Type 97 Torpedo Bomber (931)",
        ["Type 97 Torpedo Bomber (Tomonaga Squadron)"] = "Type 97 Torpedo Bomber (Tomonaga)",
        ["Tenzan Model 12 (Tomonaga Squadron)"] = "Tenzan Model 12 (Tomonaga)",
        ["Type 0 Fighter Model 62 (Fighter-bomber)"] = "Type 0 Fighter Model 62 (Fighter-bomber)",
        ["Type 99 Dive Bomber (Egusa Squadron)"] = "Type 99 Dive Bomber (Egusa)",
        ["Type 2 Reconnaissance Aircraft"] = "Type 2 Recon Aircraft",
               
               
        ["Type 0 Reconnaissance Seaplane"] = "Type 0 Recon Seaplane",
        ["Type 98 Reconnaissance Seaplane (Night Recon)"] = "Night Recon",
       
        ["No. Ka Observation Autogyro"] = "Ka-type Observation Autogyro",
        ["Type 3 Command Liaison Aircraft (ASW)"] = "Type 3 Spotter/Liaison (ASW)",
               
        ["No. 13 Air Radar"] = "Type 13 Air RADAR",
        ["No. 14 Air Radar"] = "Type 14 Air RADAR ",
        ["No. 21 Air Radar"] = "Type 21 Air RADAR",
        ["No. 22 Surface Radar"] = "Type 22 Surface RADAR",
        ["No. 33 Surface Radar"] = "Type 33 Surface RADAR",
        ["No. 32 Surface Radar"] = "Type 32 Surface RADAR",
        ["No. 22 Surface Radar Kai Yon"] = "Type 22 Surface RADAR Kai 4",
        ["No. 13 Air Radar Kai"] = "Type 13 AIR RADAR Kai",
        ["No. 21 Air Radar Kai"] = "Type 21 Air RADAR Kai",
               
        ["Type 93 Passive Sonar"] = "Type 93 Passive SONAR",
        ["Type 3 Active Sonar"] = "Type 3 SONAR",
        ["Type 0 Passive Sonar"] = "Type 0 Passive SONAR",
        ["Type 94 Depth Charge Projector"] = "Type 94 Depth Charge",
        ["Type 3 Depth Charge Projector"] = "Type 3 Depth Charge",
               
        ["Type 91 Armor Piercing Shell"] = "Type 91 Armor-Piercing Shell",
        ["Type 1 Armor Piercing Shell"] = "Type 1 Armor-Piercing Shell",
               
        ["Improved Kanhon Type Turbine"] = "Improved Steam Turbine",
        ["Enhanced Kanhon Type Boiler"] = "Enhanced Steam Boiler",
        ["New Model High Temperature High Pressure Boiler"] = "High Pressure-Temperature Boiler",
       
        ["Emergency Repair Personnel"] = "Repair Team",
        ["Emergency Repair Goddess"] = "Repair Goddess",
               
        ["Extension Bulge (Medium)"] = "Anti-torpedo Bulge (Medium)",
        ["Extension Bulge (Large)"] = "Anti-torpedo Bulge (Large)",
        ["Pugliese Underwater Protection Bulkhead"] = "Pugliese Protection Bulkhead",
               
        ["Skilled Carrier-based Aircraft Maintenance Personnel"] = "SCAMP",
               
        ["Drum Canister (Transport Use)"] = "Drum Canister",
        ["Daihatsu Landing Craft"] = "Daihatsu-class Landing Craft",
    }
    
    if page ~= "" then
        return page, shortened[name] or name
    else
        return shortened[name] or name
    end
end

return NanaminFunctions