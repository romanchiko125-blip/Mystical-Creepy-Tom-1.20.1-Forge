# Spawn a real mob far from players, then force it to stare at the nearest player
execute at @r run summon minecraft:husk ~30 ~ ~30 {Tags:["tom_entity"],CustomName:'[{"text":"Tom","color":"black","italic":false}]',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b,CanPickUpLoot:1b,ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:0}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:0}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:0}}},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:"MHF_Question",display:{Name:'{"text":"Tom"}'}}}],HandItems:[{id:"minecraft:air",Count:1b},{id:"minecraft:air",Count:1b}],HandDropChances:[0.0f,0.0f],ArmorDropChances:[0.0f,0.0f,0.0f,0.0f]}

# Life timer: exactly 30-40 seconds
scoreboard players random #tom_life tom_life 600 800

# Next spawn timer: 2-5 minutes
scoreboard players random #spawn_cd tom_cooldown 2400 6000

particle minecraft:smoke ~ ~1 ~ 0.6 1 0.6 0.03 25 force @a
playsound minecraft:entity.enderman.stare master @a ~ ~ ~ 0.8 0.8
tellraw @a [{"text":"[Tom] ","color":"dark_gray"},{"text":"I am here.","color":"gray","italic":true}]
