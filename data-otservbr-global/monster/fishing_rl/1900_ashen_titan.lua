-- BALANCE PVE 8X / REFERENCIAL -- verificar in-game, no es una simulacion definitiva.
-- Unique fishing semiboss; client lookType/corpse borrowed from existing 15.25 monsters.
local mType = Game.createMonsterType("Ashen Titan")
local monster = {}
monster.description = "ashen titan"
monster.experience = 1771285 -- EXP base; 8 criaturas + benchmark hunt orientativo
monster.outfit = { lookType = 49, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }
monster.health = 320887 -- HP orientativos de encuentro semiboss
monster.maxHealth = 320887
monster.race = "blood"
monster.corpse = 8136
monster.speed = 340
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
    { name = "gold coin", chance = 65000, maxCount = 62 },
    { name = "great health potion", chance = 2500 }
} -- TEST loot; no unique drops and no Super Food yet
-- REF: sopping_carcass (8x); HP 32700, EXP 23425, DPS bruto 903.88.
-- OBJETIVO: HP=320887, EXP=1771285, DPS bruto=9515.55; tipo=extrapolacion 1500+.
-- DPS formula: suma probabilistica de todos los ataques; puede diferir in-game por cooldown y resistencias.
monster.attacks = {
    {name = "melee", interval = 1000, chance = 100, minDamage = 0, maxDamage = -7612},
    {name = "combat", interval = 1000, chance = 100, type = COMBAT_PHYSICALDAMAGE,
        minDamage = -1903, maxDamage = -2855, range = 7,
        shootEffect = CONST_ANI_ARROW, target = true},
    {name = "combat", interval = 2000, chance = 50, type = COMBAT_FIREDAMAGE,
        minDamage = -5329, maxDamage = -7993, range = 7, radius = 2,
        shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true},
    {name = "combat", interval = 1800, chance = 60, type = COMBAT_FIREDAMAGE,
        minDamage = -3997, maxDamage = -5995, range = 7,
        shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true}
}
monster.defenses = {defense = 129, armor = 88, mitigation = 0.5}
monster.elements = {
    {type = COMBAT_PHYSICALDAMAGE, percent = 0},
    {type = COMBAT_FIREDAMAGE, percent = 50},
    {type = COMBAT_ICEDAMAGE, percent = 0},
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
