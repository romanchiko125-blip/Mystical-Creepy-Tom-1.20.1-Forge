execute at @e[tag=tom_entity,limit=1] run particle minecraft:large_smoke ~ ~1 ~ 0.8 1 0.8 0.05 35 force @a
execute at @e[tag=tom_entity,limit=1] run playsound minecraft:entity.wither.ambient master @a ~ ~ ~ 0.6 1.3
kill @e[tag=tom_entity]
scoreboard players set #tom_life tom_life 0
tellraw @a [{"text":"[Tom] ","color":"dark_gray"},{"text":"...gone.","color":"gray","italic":true}]
