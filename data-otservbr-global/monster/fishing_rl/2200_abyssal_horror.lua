-- BALANCE PVE 8X / REFERENCIAL -- verificar in-game, no es una simulacion definitiva.
-- Unique fishing semiboss; client lookType/corpse borrowed from existing 15.25 monsters.
local mType = Game.createMonsterType("Abyssal Horror")
local monster = {}
monster.description = "abyssal horror"
monster.experience = 1992456 -- EXP base; 8 criaturas + benchmark hunt orientativo
monster.outfit = { lookType = 314, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }
monster.health = 360955 -- HP orientativos de encuentro semiboss
monster.maxHealth = 360955
monster.race = "blood"
monster.corpse = 9049
monster.speed = 370
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
    { name = "gold coin", chance = 65000, maxCount = 71 },
    { name = "great health potion", chance = 2500 }
} -- TEST loot; no unique drops and no Super Food yet
-- REF: oozing_carcass (8x); HP 27500, EXP 20980, DPS bruto 789.79.
-- OBJETIVO: HP=360955, EXP=1992456, DPS bruto=10703.70; tipo=extrapolacion 1500+.
-- DPS formula: suma probabilistica de todos los ataques; puede diferir in-game por cooldown y resistencias.
monster.attacks = {
    {name = "melee", interval = 1000, chance = 100, minDamage = 0, maxDamage = -8563},
    {name = "combat", interval = 1000, chance = 100, type = COMBAT_PHYSICALDAMAGE,
        minDamage = -2141, maxDamage = -3211, range = 7,
        shootEffect = CONST_ANI_ARROW, target = true},
    {name = "combat", interval = 2000, chance = 50, type = COMBAT_DEATHDAMAGE,
        minDamage = -5994, maxDamage = -8991, range = 7, radius = 2,
        shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true},
    {name = "combat", interval = 1800, chance = 60, type = COMBAT_DEATHDAMAGE,
        minDamage = -4496, maxDamage = -6743, range = 7,
        shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true}
}
monster.defenses = {defense = 147, armor = 100, mitigation = 0.5}
monster.elements = {
    {type = COMBAT_PHYSICALDAMAGE, percent = 0},
    {type = COMBAT_FIREDAMAGE, percent = 0},
    {type = COMBAT_ICEDAMAGE, percent = 0},
    {type = COMBAT_EARTHDAMAGE, percent = 0},
    {type = COMBAT_DEATHDAMAGE, percent = 50}
}
monster.immunities = {
    {type = "paralyze", condition = false},
    {type = "outfit", condition = false},
    {type = "invisible", condition = true},
    {type = "bleed", condition = false}
}
mType:register(monster)
