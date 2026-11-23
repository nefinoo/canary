# Fishing RL: balance inicial de 32 semibosses (8 enemigos equivalentes)

**Estado:** prototipo para pruebas. HP, EXP y DPS bruto estimados; no validado dentro del juego.
**Rama:** rama separada para revisar antes de fusionar con `main`.

## Criterios

- Nivel 100: 8 Heroes (1400 HP, 1200 EXP y ~66 DPS teóricos por Hero) = **11,200 HP, 9,600 EXP base, 528 DPS bruto teórico** del Deepwater Crab.
- Para los siguientes niveles se toman monstruos de caza existentes en los archivos Lua de este mismo repositorio; `DPS estimado = sum( (abs(minDamage + maxDamage)/2) * chance/100 * 1000/interval )`. El promedio asume disparos independientes; en vivo el resultado puede diferir.
- Se usan 8 enemigos como referencia inicial a partir del nivel 100, y **solo 2 Rotworms al nivel 8** para evitar una dificultad desproporcionada.
- Para evitar retrocesos bruscos entre etapas, se establece un incremento mínimo del 4% en HP, EXP y DPS cuando la referencia siguiente sea más débil. Para niveles 1100+ el crecimiento de HP tiene un techo provisional de +55% por etapa. En esas etapas el valor final puede diferir del 8x exacto.
- La EXP complementa el 8x con una fracción creciente de experiencia por hora publicada para hunts durante 180 segundos, sin mezclar esos valores con experiencia garantizada de cada monstruo. Los ejemplos de **team hunt no equivalen automáticamente a EXP/h individual**.
- Para niveles de 1500 a 3200 **no se encontraron benchmarks verificados en cada escalón**. Se extrapoló desde un punto orientativo de 29.4kk EXP/h en team hunt de nivel 1400, creciendo 3% por cada 100 niveles. Esto es una decisión de diseño, no una estadística comprobada.
- Deepwater Crab conserva la distribución de ataques original corregida: melee 240 DPS + ataque físico 240 DPS + hielo 48 DPS (antes de defensas). Los demás dividen el DPS entre melee físico, proyectil, área elemental y ataque elemental individual.

## Fuentes de referencia

- Monstruos RL del propio repositorio: `data-otservbr-global/monster` (EXP, HP y ataques).
- [TibiaFactory](https://tibiafactory.com/es): referencia sugerida, pero bloqueó el acceso completo durante la investigación.
- [Intibia Hunt Finder](https://intibia.com/hunts), [Tibia do Zero Hunts](https://tibiadozero.com/es/hunts) y [TibiaPal Hunting](https://tibiapal.com/hunting): guías de zonas y ejemplos aproximados de EXP/h, no medidas del personaje de pruebas.

## Valores actualizados

| Nivel | Fishing boss | Referencia RL | HP | EXP base | DPS bruto teórico |
|---:|---|---|---:|---:|---:|
| 8 | Shallow Reef Warden | Rotworm | 130 | 80 | 20 |
| 100 | Deepwater Crab | Hero | 11,200 | 9,600 | 528 |
| 200 | Tide Hunter | Grim Reaper | 31,200 | 44,000 | 1,110 |
| 300 | Reef Sentinel | Burster Spectre | 52,000 | 55,000 | 1,807.68 |
| 400 | Abyssal Lurker | Feral Sphinx | 78,400 | 90,000 | 2,267.84 |
| 500 | Ancient Sea Serpent | Flimsy Lost Soul | 81,536 | 102,000 | 2,435.28 |
| 600 | Drowned Guardian | Cobra Assassin | 84,798 | 123,750 | 2,532.69 |
| 700 | Trench Ravager | True Dawnfire Asura | 88,190 | 128,700 | 2,634 |
| 800 | Leviathan Spawn | Girtablilu Warrior | 91,718 | 371,250 | 2,960 |
| 900 | Oceanic Sovereign | Bulltaur Forgepriest | 95,387 | 386,100 | 3,078.4 |
| 1000 | Oceanus the Deep King | Bulltaur Brute | 99,203 | 795,000 | 3,201.54 |
| 1100 | Venom Bogwarden | Darklight Striker | 153,765 | 840,000 | 4,732 |
| 1200 | Toxic Devourer | Sopping Carcass | 238,336 | 892,500 | 7,231.04 |
| 1300 | Plague Behemoth | Bloated Man-Maggot | 253,600 | 945,000 | 7,520.28 |
| 1400 | Rotting Colossus | Rotten Man-Maggot | 263,744 | 1,396,500 | 7,821.09 |
| 1500 | Venomous Overlord | Oozing Carcass | 274,294 | 1,514,100 | 8,133.93 |
| 1600 | Magma Colossus | Darklight Source | 285,266 | 1,574,664 | 8,459.29 |
| 1700 | Infernal Wyrm | Darklight Matter | 296,677 | 1,637,651 | 8,797.66 |
| 1800 | Molten Destroyer | Meandering Mushroom | 308,545 | 1,703,158 | 9,149.57 |
| 1900 | Ashen Titan | Sopping Carcass | 320,887 | 1,771,285 | 9,515.55 |
| 2000 | Volcanic Overlord | Bloated Man-Maggot | 333,723 | 1,842,137 | 9,896.17 |
| 2100 | Tarbound Horror | Rotten Man-Maggot | 347,072 | 1,915,823 | 10,292.02 |
| 2200 | Abyssal Horror | Oozing Carcass | 360,955 | 1,992,456 | 10,703.7 |
| 2300 | Forgotten Devourer | Darklight Source | 375,394 | 2,072,155 | 11,131.85 |
| 2400 | Black Mire Reaper | Darklight Matter | 390,410 | 2,155,042 | 11,577.12 |
| 2500 | Voidborn Colossus | Meandering Mushroom | 406,027 | 2,241,244 | 12,040.2 |
| 2600 | Nightmare Abomination | Sopping Carcass | 422,269 | 2,330,894 | 12,521.81 |
| 2700 | Ancient Void Titan | Bloated Man-Maggot | 439,160 | 2,424,130 | 13,022.68 |
| 2800 | Primordial Horror | Rotten Man-Maggot | 456,727 | 2,521,096 | 13,543.59 |
| 2900 | Abyssal Sovereign | Oozing Carcass | 474,997 | 2,621,940 | 14,085.33 |
| 3000 | Primordial Abyss | Darklight Source | 493,997 | 2,726,818 | 14,648.74 |
| 3200 | Eternal Tar Devourer | Darklight Matter | 513,757 | 2,835,891 | 15,234.69 |

## Qué no está incluido

- No se modifica el loot universal de +0.1% por Fishing Skill, todavía pendiente de implementar.
- No se modifican los 4 scripts de Fishing, sus requisitos ni el máximo de diseño Fishing 150.
- No se incluyen pruebas de distribución de daño por vocación, daños pico, resistencias ni análisis de economía/loot.
- La experiencia y vida pueden requerir ajustes para alinear el tiempo real de captura + combate con una hunt normal.

## Pruebas necesarias antes de producción

1. Capturar en personaje de pruebas el nivel 100 y comparar 8 Heroes contra 1 Deepwater Crab (misma vocación, equipamiento, posición, consumibles y duración).
2. Comprobar ataques reales por segundo y picos de daño por objetivos y áreas; repetir con Knight, Paladin, Druid y Sorcerer.
3. Ejecutar `!fishing`, `!catchs` y `/testfish 100,20,1000,water,3483,0`.
4. Probar escalones altos y revisar si los semibosses derrotan al jugador antes de poder reaccionar; los bosses de grupo deben documentarlo.
5. Evaluar EXP/h de la actividad completa (tiempo esperando captura, tiempo de combate, muertes, loot y consumibles) y corregir las estimaciones.
