scoreboard objectives add tom_timer dummy
scoreboard objectives add tom_roll dummy
scoreboard objectives add tom_spawned dummy
scoreboard players set #state tom_spawned 0

# Ensure old Tom entities are removed on reload
kill @e[tag=tom_entity]

tellraw @a [{"text":"[Mystical Tom] ","color":"dark_gray"},{"text":"Том проснулся в тени...","color":"black","italic":true}]
