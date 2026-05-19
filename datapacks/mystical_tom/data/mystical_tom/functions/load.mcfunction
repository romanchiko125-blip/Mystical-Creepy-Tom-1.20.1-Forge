# Safe objective reset on reload
scoreboard objectives remove tom_cooldown
scoreboard objectives remove tom_roll
scoreboard objectives remove tom_loot_cd
scoreboard objectives remove tom_peace_cd
scoreboard objectives remove tom_life

scoreboard objectives add tom_cooldown dummy
scoreboard objectives add tom_roll dummy
scoreboard objectives add tom_loot_cd dummy
scoreboard objectives add tom_peace_cd dummy
scoreboard objectives add tom_life dummy

# Randomized initial timers
scoreboard players random #spawn_cd tom_cooldown 2400 6000
scoreboard players random #loot_cd tom_loot_cd 900 1800
scoreboard players random #peace_cd tom_peace_cd 600 1200
scoreboard players set #tom_life tom_life 0

# Cleanup old Tom entities
kill @e[tag=tom_entity]

tellraw @a [{"text":"[Mystical Tom] ","color":"dark_gray"},{"text":"Tom is now watching.","color":"gray","italic":true}]
