-- PROVISIONAL / TEST ONLY: calibrated EXP requires representative hunting benchmarks.
-- Unique fishing semiboss; client lookType/corpse borrowed from existing 15.25 monsters.
local mType = Game.createMonsterType("Drowned Guardian")
local monster = {}
monster.description = "drowned guardian"
monster.experience = 138447 -- PROVISIONAL: reference Lv100 = 7,200 EXP for 3 minutes of hunt
monster.outfit = { lookType = 449, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }
monster.health = 144669 -- PROVISIONAL: do not assume a 3-minute kill before testing
monster.maxHealth = 144669
monster.race = "blood"
monster.corpse = 13849
monster.speed = 210
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
    { name = "gold coin", chance = 65000, maxCount = 23 },
    { name = "great health potion", chance = 2500 }
} -- TEST loot; no unique drops and no Super Food yet
monster.attacks = {
    {name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1127 },
    {name = "combat", interval = 2400, chance = 23, type = COMBAT_ICEDAMAGE, minDamage = -244, maxDamage = -733, range = 7, radius = 2, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEAREA, target = true }
}
monster.defenses = {defense = 51, armor = 36, mitigation = 0.5}
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
