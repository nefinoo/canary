local command = TalkAction("!fishing")
function command.onSay(player, words, param)
    local cfg = CANARY_RL_FISHING
    if not cfg then player:sendCancelMessage("Fishing RL no cargado."); return false end
    local out = "[Canary RL Fishing]\nFishing maximo: " .. cfg.maxSkill .. "\nNivel / Fishing / Scroll\n"
    for _, area in ipairs(cfg.areaOrder) do
        out = out .. string.format("\n[%s] Fishing minimo: %d\n", cfg.areaNames[area], cfg.areaMinimum[area])
        for i = #cfg.tables[area], 1, -1 do
            local mob = cfg.tables[area][i]
            local missing = MonsterType(mob.name) and "" or " [MONSTER PENDIENTE]"
            out = out .. string.format("%s: Lv%d / Fishing%d / %s%s\n", mob.name, mob.level, mob.fishing, mob.scroll and "Scroll" or "Sin scroll", missing)
        end
    end
    out = out .. "\nFishing Scroll: storage 15000 = 1."
    player:showTextDialog(52053, out)
    return false
end
command:separator(" ")
command:groupType("normal")
command:register()
