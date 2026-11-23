-- Bowls desactivados por defecto para nuevos semibosses (bowlable=false).
-- Activar solo despues de verificar que los respawns no dan EXP/loot duplicados.
local function findBossByName(cfg, name)
    for _, area in ipairs(cfg.areaOrder) do
        for _, entry in ipairs(cfg.tables[area]) do
            if entry.bowlable and entry.name == name then return entry end
        end
    end
    return nil
end
local function findBossByAid(cfg, aid)
    for _, area in ipairs(cfg.areaOrder) do
        for _, entry in ipairs(cfg.tables[area]) do
            if entry.bowlable and aid == 28000 + entry.key then return entry end
        end
    end
    return nil
end
local bowl = Action()
function bowl.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local cfg = CANARY_RL_FISHING
    if not cfg or not target or not target:isMonster() then return false end
    local entry = findBossByName(cfg, target:getName())
    if not entry then return player:sendCancelMessage("No se permite guardar ese semiboss.") end
    local record = FISHINGMONSTERS and FISHINGMONSTERS[target:getId()]
    if not record or record.owner ~= player:getName() or record.status ~= 1 then
        return player:sendCancelMessage("Solo puedes guardar una criatura recien pescada por ti.")
    end
    FISHINGMONSTERS[target:getId()] = nil
    target:remove()
    item:transform(5929)
    item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "Contains: " .. entry.name .. "\nOwner: " .. player:getName())
    item:setAttribute("aid", 28000 + entry.key)
    return true
end
bowl:id(5928)
bowl:register()

local release = Action()
function release.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local cfg = CANARY_RL_FISHING
    if not cfg then return false end
    local desc = item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION) or ""
    local owner = desc:match("\nOwner: ([^\n]+)")
    if owner ~= player:getName() then
        return player:sendCancelMessage("No eres el propietario de ese bowl.")
    end
    local entry = findBossByAid(cfg, item.actionid)
    if not entry then return player:sendCancelMessage("Bowl no reconocido.") end
    local tile = Tile(player:getPosition())
    if tile and tile:hasFlag(TILESTATE_PROTECTIONZONE) then
        return player:sendCancelMessage("No puedes liberarlo en zona de proteccion.")
    end
    local monster = Game.createMonster(entry.name, player:getPosition(), true, false)
    if not monster then return player:sendCancelMessage("No se pudo liberar la criatura.") end
    FISHINGMONSTERS[monster:getId()] = {owner = player:getName(), status = 2}
    item:remove(1)
    return true
end
release:id(5929)
release:register()
