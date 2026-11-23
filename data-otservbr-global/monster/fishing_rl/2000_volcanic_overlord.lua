-- BALANCE PVE 8X / REFERENCIAL -- verificar in-game, no es una simulacion definitiva.
-- Unique fishing semiboss; client lookType/corpse borrowed from existing 15.25 monsters.
local mType = Game.createMonsterType("Volcanic Overlord")
local monster = {}
monster.description = "volcanic overlord"
monster.experience = 1842137 -- EXP base; 8 criaturas + benchmark hunt orientativo
monster.outfit = { lookType = 35, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }
monster.health = 333723 -- HP orientativos de encuentro semiboss
monster.maxHealth = 333723
monster.race = "blood"
monster.corpse = 5995
monster.speed = 350
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
    { name = "gold coin", chance = 65000, maxCount = 65 },
    { name = "great health potion", chance = 2500 }
} -- TEST loot; no unique drops and no Super Food yet
-- REF: bloated_man_maggot (8x); HP 31700, EXP 21570, DPS bruto 905.50.
-- OBJETIVO: HP=333723, EXP=1842137, DPS bruto=9896.17; tipo=extrapolacion 1500+.
-- DPS formula: suma probabilistica de todos los ataques; puede diferir in-game por cooldown y resistencias.
monster.attacks = {
    {name = "melee", interval = 1000, chance = 100, minDamage = 0, maxDamage = -7917},
    {name = "combat", interval = 1000, chance = 100, type = COMBAT_PHYSICALDAMAGE,
        minDamage = -1979, maxDamage = -2969, range = 7,
        shootEffect = CONST_ANI_ARROW, target = true},
    {name = "combat", interval = 2000, chance = 50, type = COMBAT_FIREDAMAGE,
        minDamage = -5542, maxDamage = -8313, range = 7, radius = 2,
        shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true},
    {name = "combat", interval = 1800, chance = 60, type = COMBAT_FIREDAMAGE,
        minDamage = -4156, maxDamage = -6235, range = 7,
        shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true}
}
monster.defenses = {defense = 135, armor = 92, mitigation = 0.5}
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
