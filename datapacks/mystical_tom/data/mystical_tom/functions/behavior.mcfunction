# Unpredictable movement: sudden teleports near players
scoreboard players random #tp_roll tom_roll 1 120
execute as @e[tag=tom_entity] at @s if score #tp_roll tom_roll matches 1 run tp @s @r

# Survival-like pressure on players (can mine/chase vibe via effects)
execute as @a at @s if entity @e[tag=tom_entity,distance=..10] run effect give @s minecraft:darkness 2 0 true
execute as @a at @s if entity @e[tag=tom_entity,distance=..6] run effect give @s minecraft:slowness 2 1 true
execute as @a at @s if entity @e[tag=tom_entity,distance=..4] run damage @s 1 minecraft:magic

# Creepy random chat messages
scoreboard players random #msg_roll tom_roll 1 260
execute if score #msg_roll tom_roll matches 1 run tellraw @a [{"text":"[Tom] ","color":"dark_gray"},{"text":"Я вижу, как ты копаешь.","color":"black","italic":true}]
execute if score #msg_roll tom_roll matches 2 run tellraw @a [{"text":"[Tom] ","color":"dark_gray"},{"text":"Не оборачивайся.","color":"black","italic":true}]
execute if score #msg_roll tom_roll matches 3 run tellraw @a [{"text":"[Tom] ","color":"dark_gray"},{"text":"Я умею всё, что умеешь ты.","color":"black","italic":true}]
execute if score #msg_roll tom_roll matches 4 run tellraw @a [{"text":"[Tom] ","color":"dark_gray"},{"text":"Тьма уже в твоем доме.","color":"black","italic":true}]
execute if score #msg_roll tom_roll matches 5 run tellraw @a [{"text":"[Tom] ","color":"dark_gray"},{"text":"Твои факелы не спасут.","color":"black","italic":true}]

# Rare despawn to allow sudden re-appearance later
scoreboard players random #despawn_roll tom_roll 1 1800
execute if score #despawn_roll tom_roll matches 1 run function mystical_tom:despawn
