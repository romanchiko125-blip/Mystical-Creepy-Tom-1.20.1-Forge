# Keep Tom focused on players (staring behavior)
execute as @e[tag=tom_entity] at @s run tp @s ~ ~ ~ facing entity @p eyes

# Unpredictable movement and pressure
scoreboard players random #tp_roll tom_roll 1 100
execute as @e[tag=tom_entity] at @s if score #tp_roll tom_roll matches 1 run spreadplayers ~ ~ 24 40 false @s

execute as @a at @s if entity @e[tag=tom_entity,distance=..12] run effect give @s minecraft:darkness 2 0 true
execute as @a at @s if entity @e[tag=tom_entity,distance=..8] run effect give @s minecraft:slowness 2 1 true
execute as @a at @s if entity @e[tag=tom_entity,distance=..5] run damage @s 1 minecraft:magic

# Creepy random chat lines
scoreboard players random #msg_roll tom_roll 1 240
execute if score #msg_roll tom_roll matches 1 run tellraw @a [{"text":"[Tom] ","color":"dark_gray"},{"text":"Do not turn around.","color":"gray","italic":true}]
execute if score #msg_roll tom_roll matches 2 run tellraw @a [{"text":"[Tom] ","color":"dark_gray"},{"text":"I can see your path.","color":"gray","italic":true}]
execute if score #msg_roll tom_roll matches 3 run tellraw @a [{"text":"[Tom] ","color":"dark_gray"},{"text":"The lights will not help.","color":"gray","italic":true}]

# Fixed life window: disappear after 30-40 seconds
scoreboard players remove #tom_life tom_life 1
execute if score #tom_life tom_life matches ..0 run function mystical_tom:despawn
