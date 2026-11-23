-- BALANCE PVE 8X / REFERENCIAL -- verificar in-game, no es una simulacion definitiva.
-- Unique fishing semiboss; client lookType/corpse borrowed from existing 15.25 monsters.
local mType = Game.createMonsterType("Ancient Sea Serpent")
local monster = {}
monster.description = "ancient sea serpent"
monster.experience = 102000 -- EXP base; 8 criaturas + benchmark hunt orientativo
monster.outfit = { lookType = 20, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }
monster.health = 81536 -- HP orientativos de encuentro semiboss
monster.maxHealth = 81536
monster.race = "blood"
monster.corpse = 6067
monster.speed = 200
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
    { name = "gold coin", chance = 65000, maxCount = 20 },
    { name = "great health potion", chance = 2500 }
} -- TEST loot; no unique drops and no Super Food yet
-- REF: flimsy_lost_soul (8x); HP 4000, EXP 4500, DPS bruto 304.41.
-- OBJETIVO: HP=81536, EXP=102000, DPS bruto=2435.28; tipo=benchmark aproximado.
-- DPS formula: suma probabilistica de todos los ataques; puede diferir in-game por cooldown y resistencias.
monster.attacks = {
    {name = "melee", interval = 1000, chance = 100, minDamage = 0, maxDamage = -1948},
    {name = "combat", interval = 1000, chance = 100, type = COMBAT_PHYSICALDAMAGE,
        minDamage = -487, maxDamage = -731, range = 7,
        shootEffect = CONST_ANI_ARROW, target = true},
    {name = "combat", interval = 2000, chance = 50, type = COMBAT_ICEDAMAGE,
        minDamage = -1364, maxDamage = -2046, range = 7, radius = 2,
        shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEAREA, target = true},
    {name = "combat", interval = 1800, chance = 60, type = COMBAT_ICEDAMAGE,
        minDamage = -1023, maxDamage = -1534, range = 7,
        shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEAREA, target = true}
}
monster.defenses = {defense = 45, armor = 32, mitigation = 0.5}
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
