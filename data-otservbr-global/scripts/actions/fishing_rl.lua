-- Canary RL / Fishing por niveles -- prototipo de pruebas, NO balance final.
-- Cada criatura debe existir en data-otservbr-global/monster/fishing_rl/.
-- Nota: sin modificaciones a la experiencia de caza normal ni al sistema global de loot.
-- Para impedir entrenar mas de 150 con otras canas / fuentes de skill, aplica PARCHE_LIMITE_GLOBAL_150.md.

local fishing = Action()
local WATER_IDS = {622,4597,4598,4599,4600,12561,12563,4601,4602,4609,4610,4611,4612,4613,4614,629,630,631,632,633,634,7236,9582,13988,13989,12560,21414}
local LAVA_IDS = {599,600,601,23846,23848,23849,23850,23851,23857,23858,23859,23860,23868,23861,23862,23863,23864,23865,23866,23867}
local SWAMP_IDS = {4691,4692,2693,2694,2695,2696,2697,2698,2699,2700,2701,2702,2703,2704,2705,2706,2707,2708,2709,2710,2711,2712,4749,4750,4751,4752,4753,4754,4755}
local TAR_IDS = {708}

-- Tablas ordenadas desde el encuentro mas alto hacia el mas bajo.
-- 'scroll' solo controla los hitos de nivel especificados en el catalogo.
local waterMonsters = {
    { name = "Oceanus the Deep King", level = 1000, fishing = 80, key = 11, scroll = true, bowlable = false, serverBC = false },
    { name = "Oceanic Sovereign", level = 900, fishing = 74, key = 10, scroll = false, bowlable = false, serverBC = false },
    { name = "Leviathan Spawn", level = 800, fishing = 68, key = 9, scroll = false, bowlable = false, serverBC = false },
    { name = "Trench Ravager", level = 700, fishing = 61, key = 8, scroll = false, bowlable = false, serverBC = false },
    { name = "Drowned Guardian", level = 600, fishing = 54, key = 7, scroll = false, bowlable = false, serverBC = false },
    { name = "Ancient Sea Serpent", level = 500, fishing = 48, key = 6, scroll = false, bowlable = false, serverBC = false },
    { name = "Abyssal Lurker", level = 400, fishing = 41, key = 5, scroll = false, bowlable = false, serverBC = false },
    { name = "Reef Sentinel", level = 300, fishing = 34, key = 4, scroll = false, bowlable = false, serverBC = false },
    { name = "Tide Hunter", level = 200, fishing = 27, key = 3, scroll = false, bowlable = false, serverBC = false },
    { name = "Deepwater Crab", level = 100, fishing = 20, key = 2, scroll = false, bowlable = false, serverBC = false },
    { name = "Shallow Reef Warden", level = 8, fishing = 10, key = 1, scroll = false, bowlable = false, serverBC = false },
}

local swampMonsters = {
    { name = "Venomous Overlord", level = 1500, fishing = 100, key = 16, scroll = true, bowlable = false, serverBC = true },
    { name = "Rotting Colossus", level = 1400, fishing = 97, key = 15, scroll = false, bowlable = false, serverBC = false },
    { name = "Plague Behemoth", level = 1300, fishing = 93, key = 14, scroll = false, bowlable = false, serverBC = false },
    { name = "Toxic Devourer", level = 1200, fishing = 89, key = 13, scroll = false, bowlable = false, serverBC = false },
    { name = "Venom Bogwarden", level = 1100, fishing = 85, key = 12, scroll = false, bowlable = false, serverBC = false },
}

local lavaMonsters = {
    { name = "Volcanic Overlord", level = 2000, fishing = 120, key = 21, scroll = true, bowlable = false, serverBC = true },
    { name = "Ashen Titan", level = 1900, fishing = 116, key = 20, scroll = false, bowlable = false, serverBC = true },
    { name = "Molten Destroyer", level = 1800, fishing = 112, key = 19, scroll = false, bowlable = false, serverBC = true },
    { name = "Infernal Wyrm", level = 1700, fishing = 108, key = 18, scroll = false, bowlable = false, serverBC = true },
    { name = "Magma Colossus", level = 1600, fishing = 104, key = 17, scroll = false, bowlable = false, serverBC = true },
}

local tarMonsters = {
    { name = "Eternal Tar Devourer", level = 3200, fishing = 150, key = 32, scroll = true, bowlable = false, serverBC = true },
    { name = "Primordial Abyss", level = 3000, fishing = 148, key = 31, scroll = true, bowlable = false, serverBC = true },
    { name = "Abyssal Sovereign", level = 2900, fishing = 146, key = 30, scroll = false, bowlable = false, serverBC = true },
    { name = "Primordial Horror", level = 2800, fishing = 144, key = 29, scroll = false, bowlable = false, serverBC = true },
    { name = "Ancient Void Titan", level = 2700, fishing = 141, key = 28, scroll = false, bowlable = false, serverBC = true },
    { name = "Nightmare Abomination", level = 2600, fishing = 138, key = 27, scroll = false, bowlable = false, serverBC = true },
    { name = "Voidborn Colossus", level = 2500, fishing = 135, key = 26, scroll = false, bowlable = false, serverBC = true },
    { name = "Black Mire Reaper", level = 2400, fishing = 132, key = 25, scroll = false, bowlable = false, serverBC = true },
    { name = "Forgotten Devourer", level = 2300, fishing = 129, key = 24, scroll = false, bowlable = false, serverBC = true },
    { name = "Abyssal Horror", level = 2200, fishing = 126, key = 23, scroll = false, bowlable = false, serverBC = true },
    { name = "Tarbound Horror", level = 2100, fishing = 123, key = 22, scroll = false, bowlable = false, serverBC = true },
}

local AREA_TABLES = { water = waterMonsters, swamp = swampMonsters, lava = lavaMonsters, tar = tarMonsters }
local AREA_ORDER = {"water", "swamp", "lava", "tar"}
local MAX_FISHING_SKILL = 150  -- limite disenado; requiere parche en evento global para limitar TODA forma de entrenamiento
local AREA_NAMES = {water = "Agua", swamp = "Veneno", lava = "Lava", tar = "Tar"}
local AREA_MIN = {water = 10, swamp = 85, lava = 104, tar = 123}
local BASE_CAPTURE = {water = 800, swamp = 600, lava = 450, tar = 300}  -- por 10 000 lanzamientos
local RODS = { [3483] = true, [9306] = true, [52053] = true }
local SCROLL_STORAGE = 15000
local COUNTER_BASE = 870000   -- reservas: 870001-870032
local TOTAL_STORAGE = 871010
local STATS = {water = 871001, swamp = 871002, lava = 871003, tar = 871004,
    bass = 871011, smallBass = 871012, tinyBass = 871013}

local function storageCount(player, key)
    return math.max(0, tonumber(player:getStorageValue(key)) or -1)
end
local function addStorage(player, key, amount)
    player:setStorageValue(key, storageCount(player, key) + (amount or 1))
end
local function inList(list, id)
    for _, value in ipairs(list) do if value == id then return true end end
    return false
end
local function areaForItem(id)
    if inList(WATER_IDS, id) then return "water" end
    if inList(SWAMP_IDS, id) then return "swamp" end
    if inList(LAVA_IDS, id) then return "lava" end
    if inList(TAR_IDS, id) then return "tar" end
    return nil
end
local function eligibleMonsters(list, level, skill, scroll)
    local eligible = {}
    for _, entry in ipairs(list) do
        if level >= entry.level and skill >= entry.fishing
            and (not entry.scroll or scroll)
            and MonsterType(entry.name) then
            eligible[#eligible + 1] = entry
        end
    end
    return eligible
end
local function catchChance(skill, rodId, area)
    local bonusSkill = math.max(0, math.floor(skill) - AREA_MIN[area]) * 3
    local rodBonus = rodId == 9306 and 120 or 0
    return math.min(1300, BASE_CAPTURE[area] + bonusSkill + rodBonus) -- 3% a 13%
end
local function chooseTier(eligible)
    -- Solo las tres mejores etapas disponibles (aun si el usuario supera el nivel maximo de la zona).
    local count = math.min(3, #eligible)
    if count == 0 then return nil end
    if count == 1 then return eligible[1] end
    local weights = count == 2 and {40,60} or {20,30,50}
    local roll = math.random(1,100)
    local upto = 0
    for i = 1, count do
        upto = upto + weights[i]
        if roll <= upto then return eligible[i] end
    end
    return eligible[count]
end
local function hasActiveFishingMonster(owner)
    for id, state in pairs(FISHINGMONSTERS) do
        local mob = Monster(id)
        if not mob then
            FISHINGMONSTERS[id] = nil
        elseif state.owner == owner then
            return true
        end
    end
    return false
end

CANARY_RL_FISHING = {
    tables = AREA_TABLES, areaOrder = AREA_ORDER, areaNames = AREA_NAMES,
    areaMinimum = AREA_MIN, statStorage = STATS,
    scrollStorage = SCROLL_STORAGE, counterBase = COUNTER_BASE,
    totalStorage = TOTAL_STORAGE, maxSkill = MAX_FISHING_SKILL, getStorageCount = storageCount,
    getEligibleMonsters = eligibleMonsters, getCatchChance = catchChance,
    chooseTier = chooseTier
}
local knownKeys, knownNames = {}, {}
for area, entries in pairs(AREA_TABLES) do
    local previousLevel = math.huge
    for _, entry in ipairs(entries) do
        assert(entry.level < previousLevel, "Fishing RL: orden de nivel invalido en " .. area)
        assert(not knownKeys[entry.key] and not knownNames[entry.name], "Fishing RL: key o nombre duplicado")
        knownKeys[entry.key], knownNames[entry.name] = true, true
        previousLevel = entry.level
    end
end
FISHINGMONSTERS = FISHINGMONSTERS or {}

function fishing.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target or not target.itemid or not RODS[item.itemid] then return false end
    local area = areaForItem(target.itemid)
    if not area then return false end

    local rawSkill = player:getSkillLevel(SKILL_FISHING)
    local skill = math.min(MAX_FISHING_SKILL, rawSkill)
    if skill < AREA_MIN[area] then
        player:sendCancelMessage("Necesitas Fishing " .. AREA_MIN[area] .. " para " .. AREA_NAMES[area] .. ".")
        return true
    end
    local tile = Tile(player:getPosition())
    if tile and tile:hasFlag(TILESTATE_PROTECTIONZONE) then
        player:sendCancelMessage("No puedes pescar desde una zona de proteccion.")
        return true
    end
    if hasActiveFishingMonster(player:getName()) then
        player:sendCancelMessage("Primero derrota al semiboss que ya pescaste.")
        return true
    end
    local eligible = eligibleMonsters(AREA_TABLES[area], player:getLevel(), skill,
        player:getStorageValue(SCROLL_STORAGE) == 1)
    if #eligible == 0 then
        player:sendCancelMessage("Aun no tienes un encuentro habilitado para tu nivel y skill en esta zona.")
        return true
    end
    if player:getItemCount(3492) < 1 then
        player:sendCancelMessage("Necesitas una carnada (worm).")
        return true
    end
    if not player:removeItem(3492, 1) then return true end

    addStorage(player, STATS[area])
    -- Entrena Fishing con cada lanzamiento valido; no se bloquea por falta de capturas.
    if rawSkill < MAX_FISHING_SKILL then
        player:addSkillTries(SKILL_FISHING, 1)
    end
    local success = math.random(1,10000) <= catchChance(skill, item.itemid, area)
    local monsterCaught = false
    if success then
        local selected = chooseTier(eligible)
        if selected then
            local mob = Game.createMonster(selected.name, player:getPosition(), true, false)
            if mob then
                FISHINGMONSTERS[mob:getId()] = {owner = player:getName(), status = 1}
                addStorage(player, COUNTER_BASE + selected.key)
                addStorage(player, TOTAL_STORAGE)
                if player:getSkillLevel(SKILL_FISHING) < MAX_FISHING_SKILL then
                    player:addSkillTries(SKILL_FISHING, 1)
                end
                player:sendTextMessage(MESSAGE_STATUS, "Has pescado: " .. selected.name .. "!")
                if selected.serverBC then
                    Game.broadcastMessage(player:getName() .. " ha encontrado a " .. selected.name .. "!", MESSAGE_ADMINISTRATOR)
                end
                monsterCaught = true
            end
        end
    end

    -- Peces consumibles de agua: alternativas a un semiboss, no lo reemplazan.
    if area == "water" and not monsterCaught then
        local roll = math.random(1, 100)
        local id, counter
        if roll <= 1 then id, counter = 32043, STATS.bass
        elseif roll <= 11 then id, counter = 32044, STATS.smallBass
        elseif roll <= 46 then id, counter = 32045, STATS.tinyBass end
        if id and player:addItem(id, 1, true) then addStorage(player, counter) end
    end
    toPosition:sendMagicEffect(area == "lava" and CONST_ME_HITBYFIRE or CONST_ME_WATERSPLASH)
    return true
end
fishing:allowFarUse(true)
fishing:id(3483,9306,52053)
fishing:register()

local testFish = TalkAction("/testfish")
function testFish.onSay(player, words, param)
    local cfg = CANARY_RL_FISHING
    local args = (param or ""):split(",")
    local level = tonumber(args[1]) or player:getLevel()
    local skill = tonumber(args[2]) or player:getSkillLevel(SKILL_FISHING)
    local attempts = math.floor(tonumber(args[3]) or 1000)
    local area = (args[4] or "water"):lower():gsub("%s+", "")
    local rodId = tonumber(args[5]) or 3483
    local scroll = (args[6] == "1") or (not args[6] and player:getStorageValue(cfg.scrollStorage) == 1)
    if not cfg.tables[area] or level < 1 or attempts < 1 or attempts > 20000
        or not RODS[rodId] or skill < cfg.areaMinimum[area] or skill > cfg.maxSkill then
        player:sendCancelMessage("Uso: /testfish level,skill,intentos,water|swamp|lava|tar,rodId,scroll(0|1)")
        return false
    end
    local eligible = cfg.getEligibleMonsters(cfg.tables[area], level, skill, scroll)
    local results, successes = {}, 0
    for _ = 1, attempts do
        if #eligible > 0 and math.random(1,10000) <= cfg.getCatchChance(skill, rodId, area) then
            local mob = cfg.chooseTier(eligible)
            results[mob.name] = (results[mob.name] or 0) + 1
            successes = successes + 1
        end
    end
    local out = string.format("Prueba de Fishing RL | %s | Lv %d | Skill %d | Scroll %s\nIntentos: %d | Semibosses: %d | Tasa: %.2f%%\nProbabilidad por intento: %.2f%%\n\n",
        cfg.areaNames[area], level, skill, scroll and "si" or "no", attempts, successes,
        100 * successes / attempts, cfg.getCatchChance(skill, rodId, area) / 100)
    for _, mob in ipairs(eligible) do
        if results[mob.name] then
            out = out .. string.format("%s: %d\n", mob.name, results[mob.name])
        end
    end
    out = out .. "\nSimulacion: no genera monstruos, loot ni experiencia."
    player:showTextDialog(1950, out)
    return false
end
testFish:separator(" ")
testFish:groupType("god")
testFish:register()
