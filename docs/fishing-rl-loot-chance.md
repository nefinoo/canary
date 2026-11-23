# Fishing RL — +0.1% relativo de loot chance por Fishing Skill

**Implementación:** 22 noviembre 2026. Cambios limitados a la rama de Fishing RL; no se ha fusionado `main`.

## Cómo funciona

- Por cada skill base de Fishing, el propietario del cadáver recibe **+0.1% relativo** de probabilidad de loot. No se configura un máximo de Fishing ni un techo al bono.
- Fórmula: `bonus = max(0, fishing_base) * 0.001` y `probabilidad_ajustada = probabilidad_base * factor_existente * (1 + bonus)`.
- Ejemplo item con 1% nominal de drop: Fishing 10 → 1.01%; Fishing 50 → 1.05%; Fishing 100 → 1.10%; Fishing 150 → 1.15%; Fishing 250 → 1.25%; Fishing 300 → 1.30%, antes de los efectos de los demás boosts y la variación aleatoria original de Canary.
- Usa `player:getSkillLevel(SKILL_FISHING)` (base) y no `getEffectiveSkillLevel` (evita beneficiarse de buffs temporales de Fishing).
- Se aplica en `data/libs/functions/monstertype.lua` dentro de `generateLootRoll`, el camino compartido por loot normal, rolls extra de Prey/Boosted/Hazard/Wealth y rewards de bosses que lo utilizan.
- No crea loot adicional; no cambia `count`, `minCount`, `maxCount`, `charges` ni recompensas entregadas por fuera de `generateLootRoll`.
- Excluye entradas con `chance=0` y entradas cuya probabilidad configurada sea `>=MAX_LOOTCHANCE` para no alterar su comportamiento preexistente; la lógica anterior del factor aleatorio del servidor sigue vigente.
- Aplica **una sola vez por tirada** y no vuelve a multiplicar el bonus en `Player:calculateLootFactor`, que únicamente añade un texto informativo al loot.
- En party usa el Fishing Skill del **propietario del cadáver** (`corpse:getCorpseOwner()`); no suma los skills de los miembros ni de posibles personas cercanas.
- No se aplica si no se identifica propietario de loot. Si el propietario no puede recibir loot por stamina, **no recibe el bonus de Fishing**; la generación base preexistente no se altera.

## Archivos

1. `data/libs/functions/player.lua` — método `Player:getFishingLootChanceBonus()` y texto del bono junto a VIP/Taskboard.
2. `data/libs/functions/monstertype.lua` — multiplicador para todas las tiradas de loot con player identificado.
3. `data-otservbr-global/scripts/talkactions/fishing_info.lua` — muestra skill y porcentaje en `!fishing`.

## Pruebas antes de producción

1. Reiniciar Canary en el ambiente de pruebas para recargar libs Lua. Ningún cambio de C++ ni recompilación es necesaria.
2. Usar `!fishing` con skills 10, 50, 100, 150, 250 y 300; comprobar +1%, +5%, +10%, +15%, +25% y +30%.
3. Matar monstruos con loot común y raro, solo y en party, verificar que el propietario del cadáver determina el bonus.
4. Con suficientes muestras (miles de bajas) comprobar el incremento estadístico: un item de 1% nominal tiene 1.15% con Fishing 150 **antes** de otros factores.
5. Verificar Prey, Boosted, Hazard y Reward Boss, así como ausencia de cambios en los drops entregados mediante quests específicas.
6. Revisar logs Lua; si otras partes del servidor redefinen `Player:getFishingLootChanceBonus` o `MonsterType:generateLootRoll`, resolver la colisión.

**Estado:** código integrado a rama de revisión. Sin ejecución dentro del servidor real ni simulación estadística confirmada todavía.

## Progresion sin limite personalizado

- `data-otservbr-global/scripts/actions/fishing_rl.lua` ya no trunca el skill a 150, no bloquea los skill tries tras 150 y permite `/testfish` con cualquier skill valido.
- Los requisitos minimos de cada zona y de cada semiboss se mantienen: Fishing 150 sigue siendo el requisito para **Eternal Tar Devourer**, no el maximo del personaje.
- La probabilidad de captura aumenta con Fishing Skill y solo se limita al maximo matematico de 100%, nunca por nivel de skill.
- El motor de Canary sigue sujeto a sus propios limites tecnicos de tipos de datos y formula de entrenamiento. Este cambio elimina las restricciones artificiales de nuestro sistema RL.
