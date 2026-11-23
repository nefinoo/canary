-- Standalone test: from repository root, run lua tests/lua/test_fishing_loot_chance.lua
-- Uses the real production MonsterType:generateLootRoll and the real fishing bonus method
-- extracted from the player library, avoiding bootstrapping the full game.
local f = assert(io.open("data/libs/functions/player.lua", "r"))
local playerSource = f:read("*a")
f:close()
local bonusMethodBody = assert(playerSource:match("function Player:getFishingLootChanceBonus%(%)(.-)\nend"), "Fishing bonus method missing")
local fn = assert(load("return function(self)" .. bonusMethodBody .. "\nend"))()

SKILL_FISHING = 6
MAX_LOOTCHANCE = 100000
SCHEDULE_BOSS_LOOT_RATE = 100
configKeys = { RATE_LOOT = 1 }
configManager = { getNumber = function() return 1 end }
Player = {}
Player.getFishingLootChanceBonus = fn
function Player:getSkillLevel(skill)
    assert(skill == SKILL_FISHING)
    return self.baseSkill
end
function Player:canReceiveLoot()
    return self.canLoot ~= false
end

MonsterType = {}
function MonsterType:getLoot() return self.loot end
function MonsterType:isRewardBoss() return self.rewardBoss or false end
ItemType = function(id)
    return {
        getId = function() return id end,
        getCharges = function() return 0 end,
        isStackable = function() return false end,
        getType = function() return 0 end,
    }
end
local rollValue, jitter = 0, 100
getLootRandom = function() return rollValue end
math.random = function() return jitter end

dofile("data/libs/functions/monstertype.lua")

local function player(skill, canLoot)
    return setmetatable({baseSkill = skill, canLoot = canLoot}, {__index = Player})
end
local function roll(skill, value, chance, factor, rewardBoss, randomJitter, canLoot)
    rollValue = value
    jitter = randomJitter or 100
    local monster = setmetatable({
        loot = {{itemId = 123, chance = chance or 10000}},
        rewardBoss = rewardBoss or false,
    }, {__index = MonsterType})
    local owner = nil
    if skill ~= nil then
        owner = player(skill, canLoot)
    end
    local result = monster:generateLootRoll({factor = factor or 1.0, gut = false}, {}, owner)
    return result[123] ~= nil, result[123]
end

for skill, expected in pairs({
    [0] = 0.0, [10] = 0.01, [50] = 0.05,
    [100] = 0.10, [150] = 0.15, [250] = 0.15,
}) do
    assert(math.abs(player(skill):getFishingLootChanceBonus() - expected) < 0.0000001, "Bonus wrong at Fishing " .. skill)
end
assert(player(-10):getFishingLootChanceBonus() == 0)
assert(not roll(0, 10500), "No bonus must fail 10% drop at 10.5% roll")
assert(roll(100, 10500), "Fishing 100 must raise drop chance to 11%")
assert(not roll(100, 11200), "Fishing 100 must not raise chance to 11.2%")
assert(roll(150, 11200), "Fishing 150 must raise chance to 11.5%")
assert(not roll(250, 11600), "Fishing over 150 must not add more than 15%")
assert(not roll(nil, 10500), "Ownerless loot must have no bonus")
assert(not roll(150, 11200, 10000, 1, false, 100, false), "Low-stamina owner must receive no Fishing bonus")
assert(roll(100, 11700, 10000, 1.1), "Existing loot factor must multiply with Fishing")
assert(roll(100, 10500, 10000, 1, true), "Reward boss loot must get Fishing bonus")
assert(not roll(150, 97000, 100000, 1, false, 95), "Configured max-chance loot must keep old behavior")
assert(not roll(0, 97000, 100000, 1, false, 95), "Baseline maximum chance control failed")
local present, item = roll(150, 5000)
assert(present and item.count == 1, "Fishing bonus must not create extra rolls or item count")
print("Fishing loot chance: all tests passed")
