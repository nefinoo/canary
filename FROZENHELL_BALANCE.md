# Frozen Hell - balance de progresion v2

## 01 - Spawn inicial (nivel 8 a 15-20)

Base: send_first_items(1).lua proporcionado por el administrador (no sustituye el archivo del repositorio). Knight, Paladin, Sorcerer y Druid, sin equipo adicional, sin promocion y sin entrenamiento previo. Se mantienen los spells originales; no se modifica el loot.

| Criatura | Cantidad | HP | EXP base | Melee max/2s | Defensa | Armadura | Mitigacion |
|---|---:|---:|---:|---:|---:|---:|---:|
| Rat | 16 | 25 | 150 | 8 | 0 | 0 | 0.00 |
| Cave Rat | 10 | 35 | 240 | 12 | 1 | 1 | 0.05 |
| Slime | 6 | 50 | 380 | 18 | 2 | 1 | 0.10 |
| Slug | 4 | 70 | 550 | 24 | 3 | 2 | 0.15 |

Slime: sin invocaciones; Slug: ataque earth 4-8, 15% cada 2 segundos, alcance 3. Los cuatro tienen resistencia neutral a fisico, energia, tierra y fuego para no penalizar el arma inicial de una vocacion. Las ratas ya no huyen con poca vida. Los cambios afectan todas las instancias de estos tipos de monstruo.

EXP de una vuelta: 9,280 base. Con las etapas existentes de data/stages.lua (x7 nivel 8, x6 nivel 9-20), 55,680-64,960 EXP ganada como limites conservadores, nivel 17 al iniciar en 4,200 EXP (sin stamina bonus, prey, boost ni otras bonificaciones). El orden real cambia ligeramente la experiencia. El config.lua activo no esta versionado; config.lua.dist tiene rateUseStages=false y rateExp=1. Para la meta usar rateUseStages=true con las etapas actuales; si el servidor usa una tasa diferente, recalcular la EXP antes de desplegar. No se modifican tasas globales.

Pruebas pendientes: crear un personaje nuevo de cada vocacion a nivel 8, skill inicial 10 / ML inicial real, matar 36 criaturas, registrar nivel final, tiempo, daño, mana y pociones. Verificar la durabilidad y disponibilidad de spears: el archivo enviado da una sola spear, mientras el repositorio trae tambien arco y 50 flechas. No se modifica el equipo inicial en este commit. Los valores son una propuesta de balance, no mediciones dentro del servidor.
