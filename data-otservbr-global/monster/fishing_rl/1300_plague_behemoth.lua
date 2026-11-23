-- BALANCE PVE 8X / REFERENCIAL -- verificar in-game, no es una simulacion definitiva.
-- Unique fishing semiboss; client lookType/corpse borrowed from existing 15.25 monsters.
local mType = Game.createMonsterType("Plague Behemoth")
local monster = {}
monster.description = "plague behemoth"
monster.experience = 945000 -- EXP base; 8 criaturas + benchmark hunt orientativo
monster.outfit = { lookType = 314, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }
monster.health = 253600 -- HP orientativos de encuentro semiboss
monster.maxHealth = 253600
monster.race = "blood"
monster.corpse = 9049
monster.speed = 280
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
    { name = "gold coin", chance = 65000, maxCount = 44 },
    { name = "great health potion", chance = 2500 }
} -- TEST loot; no unique drops and no Super Food yet
-- REF: bloated_man_maggot (8x); HP 31700, EXP 21570, DPS bruto 905.50.
-- OBJETIVO: HP=253600, EXP=945000, DPS bruto=7520.28; tipo=benchmark aproximado.
-- DPS formula: suma probabilistica de todos los ataques; puede diferir in-game por cooldown y resistencias.
monster.attacks = {
    {name = "melee", interval = 1000, chance = 100, minDamage = 0, maxDamage = -6016},
    {name = "combat", interval = 1000, chance = 100, type = COMBAT_PHYSICALDAMAGE,
        minDamage = -1504, maxDamage = -2256, range = 7,
        shootEffect = CONST_ANI_ARROW, target = true},
    {name = "combat", interval = 2000, chance = 50, type = COMBAT_EARTHDAMAGE,
        minDamage = -4211, maxDamage = -6317, range = 7, radius = 2,
        shootEffect = CONST_ANI_EARTH, effect = CONST_ME_GREEN_RINGS, target = true},
    {name = "combat", interval = 1800, chance = 60, type = COMBAT_EARTHDAMAGE,
        minDamage = -3159, maxDamage = -4738, range = 7,
        shootEffect = CONST_ANI_EARTH, effect = CONST_ME_GREEN_RINGS, target = true}
}
monster.defenses = {defense = 93, armor = 64, mitigation = 0.5}
monster.elements = {
    {type = COMBAT_PHYSICALDAMAGE, percent = 0},
    {type = COMBAT_FIREDAMAGE, percent = 0},
    {type = COMBAT_ICEDAMAGE, percent = 0},
    {type = COMBAT_EARTHDAMAGE, percent = 50},
    {type = COMBAT_DEATHDAMAGE, percent = 0}
}
monster.immunities = {
    {type = "paralyze", condition = false},
    {type = "outfit", condition = false},
    {type = "invisible", condition = true},
    {type = "bleed", condition = false}
}
mType:register(monster)
