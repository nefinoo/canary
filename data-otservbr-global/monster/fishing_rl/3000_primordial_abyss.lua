-- BALANCE PVE 8X / REFERENCIAL -- verificar in-game, no es una simulacion definitiva.
-- Unique fishing semiboss; client lookType/corpse borrowed from existing 15.25 monsters.
local mType = Game.createMonsterType("Primordial Abyss")
local monster = {}
monster.description = "primordial abyss"
monster.experience = 2726818 -- EXP base; 8 criaturas + benchmark hunt orientativo
monster.outfit = { lookType = 18, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }
monster.health = 493997 -- HP orientativos de encuentro semiboss
monster.maxHealth = 493997
monster.race = "blood"
monster.corpse = 5976
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
    { name = "gold coin", chance = 65000, maxCount = 95 },
    { name = "great health potion", chance = 2500 }
} -- TEST loot; no unique drops and no Super Food yet
-- REF: darklight_source (8x); HP 31550, EXP 22465, DPS bruto 630.00.
-- OBJETIVO: HP=493997, EXP=2726818, DPS bruto=14648.74; tipo=extrapolacion 1500+.
-- DPS formula: suma probabilistica de todos los ataques; puede diferir in-game por cooldown y resistencias.
monster.attacks = {
    {name = "melee", interval = 1000, chance = 100, minDamage = 0, maxDamage = -11719},
    {name = "combat", interval = 1000, chance = 100, type = COMBAT_PHYSICALDAMAGE,
        minDamage = -2930, maxDamage = -4395, range = 7,
        shootEffect = CONST_ANI_ARROW, target = true},
    {name = "combat", interval = 2000, chance = 50, type = COMBAT_DEATHDAMAGE,
        minDamage = -8203, maxDamage = -12305, range = 7, radius = 2,
        shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true},
    {name = "combat", interval = 1800, chance = 60, type = COMBAT_DEATHDAMAGE,
        minDamage = -6152, maxDamage = -9229, range = 7,
        shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true}
}
monster.defenses = {defense = 195, armor = 132, mitigation = 0.5}
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
