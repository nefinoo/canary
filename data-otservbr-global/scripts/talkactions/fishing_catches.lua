local command = TalkAction("!catchs")
function command.onSay(player, words, param)
    local cfg = CANARY_RL_FISHING
    if not cfg then player:sendCancelMessage("Fishing RL no cargado."); return false end
    local target = player
    if param and param ~= "" then
        target = Player(param)
        if not target then player:sendCancelMessage("Jugador desconectado."); return false end
    end
    local total = 0
    local out = "[Capturas Fishing RL: " .. target:getName() .. "]\n"
    for _, area in ipairs(cfg.areaOrder) do
        local subtotal = 0
        out = out .. "\n[" .. cfg.areaNames[area] .. "]\n"
        for i = #cfg.tables[area], 1, -1 do
            local mob = cfg.tables[area][i]
            local amount = cfg.getStorageCount(target, cfg.counterBase + mob.key)
            subtotal = subtotal + amount
            out = out .. string.format("%s: %d\n", mob.name, amount)
        end
        total = total + subtotal
        out = out .. string.format("Capturas: %d | Lanzamientos: %d\n", subtotal, cfg.getStorageCount(target, cfg.statStorage[area]))
    end
    out = out .. string.format("\nTotal semibosses: %d | Contador: %d\nBass: %d | Small Bass: %d | Tiny Bass: %d",
        total, cfg.getStorageCount(target, cfg.totalStorage), cfg.getStorageCount(target,cfg.statStorage.bass),
        cfg.getStorageCount(target,cfg.statStorage.smallBass),cfg.getStorageCount(target,cfg.statStorage.tinyBass))
    player:showTextDialog(32043, out)
    return false
end
command:separator(" ")
command:groupType("normal")
command:register()
