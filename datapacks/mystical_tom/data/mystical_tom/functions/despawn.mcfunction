execute at @e[tag=tom_entity,limit=1] run particle minecraft:large_smoke ~ ~1 ~ 0.8 1 0.8 0.05 30 force @a
execute at @e[tag=tom_entity,limit=1] run playsound minecraft:entity.wither.ambient master @a ~ ~ ~ 0.5 1.4
kill @e[tag=tom_entity]
tellraw @a [{"text":"[Tom] ","color":"dark_gray"},{"text":"...","color":"black","italic":true}]
