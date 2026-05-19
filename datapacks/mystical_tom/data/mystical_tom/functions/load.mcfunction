# Recreate objectives on reload to avoid duplicate-objective errors
scoreboard objectives remove tom_cooldown
scoreboard objectives remove tom_roll
scoreboard objectives remove tom_loot_cd
scoreboard objectives remove tom_peace_cd

scoreboard objectives add tom_cooldown dummy
scoreboard objectives add tom_roll dummy
scoreboard objectives add tom_loot_cd dummy
scoreboard objectives add tom_peace_cd dummy

# Initialize random cooldowns
scoreboard players random #spawn_cd tom_cooldown 2400 12000
scoreboard players random #loot_cd tom_loot_cd 900 1800
scoreboard players random #peace_cd tom_peace_cd 600 1200

# Ensure old Tom entities are removed on reload
kill @e[tag=tom_entity]

tellraw @a [{"text":"[Mystical Tom] ","color":"dark_gray"},{"text":"Том проснулся в тени...","color":"black","italic":true}]
