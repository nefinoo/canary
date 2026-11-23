-- BALANCE PVE 8X / REFERENCIAL -- verificar in-game, no es una simulacion definitiva.
-- Unique fishing semiboss; client lookType/corpse borrowed from existing 15.25 monsters.
local mType = Game.createMonsterType("Deepwater Crab")
local monster = {}
monster.description = "deepwater crab"
monster.experience = 9600 -- EXP base; 8 criaturas + benchmark hunt orientativo
monster.outfit = { lookType = 20, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }
monster.health = 11200 -- HP orientativos de encuentro semiboss
monster.maxHealth = 11200
monster.race = "blood"
monster.corpse = 6067
monster.speed = 160
monster.manaCost = 0
monster.changeTarget = {interval = 4000, chance = 12}
monster.strategiesTarget = {nearest = 100}
monster.flags = { summonable = false, attackable = true, hostile = true, convinceable = false,
    pushable = false, rewardBoss = false, illusionable = false, canPushItems = true,
    canPushCreatures = true, staticAttackChance = 95, targetDistance = 1,
    runHealth = 0, healthHidden = false, isBlockable = false,
    canWalkOnEnergy = true, canWalkOnFire = true, canWalkOnPoison = true }
monster.light = {level = 0, color = 0}
monster.voices = {interval = 5000, chance = 0}
monster.loot = {
    { name = "gold coin", chance = 65000, maxCount = 8 },
    { name = "great health potion", chance = 2500 }
} -- TEST loot; no unique drops and no Super Food yet
-- REF: hero (8x); HP 1400, EXP 1200, DPS bruto 66.00.
-- OBJETIVO: HP=11200, EXP=9600, DPS bruto=528.00; tipo=benchmark aproximado.
-- DPS formula: suma probabilistica de todos los ataques; puede diferir in-game por cooldown y resistencias.
monster.attacks = {
    {name = "melee", interval = 1000, chance = 100, minDamage = 0, maxDamage = -480},
    {name = "combat", interval = 1000, chance = 100, type = COMBAT_PHYSICALDAMAGE,
        minDamage = -160, maxDamage = -320, range = 1,
        effect = CONST_ME_DRAWBLOOD, target = true},
    {name = "combat", interval = 2000, chance = 40, type = COMBAT_ICEDAMAGE,
        minDamage = -180, maxDamage = -300, range = 7, radius = 2,
        shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEAREA, target = true}
}
monster.defenses = {defense = 21, armor = 16, mitigation = 0.5}
monster.elements = {
    {type = COMBAT_PHYSICALDAMAGE, percent = 0},
    {type = COMBAT_FIREDAMAGE, percent = 0},
    {type = COMBAT_ICEDAMAGE, percent = 50},
    {type = COMBAT_EARTHDAMAGE, percent = 0},
    {type = COMBAT_DEATHDAMAGE, percent = 0}
}
monster.immunities = {
    {type = "paralyze", condition = false},
    {type = "outfit", condition = false},
    {type = "invisible", condition = true},
    {type = "bleed", condition = false}
}
mType:register(monster)
