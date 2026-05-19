# Spawn near a random player
execute at @r run summon minecraft:armor_stand ~ ~ ~ {NoGravity:1b,Invisible:0b,Marker:0b,Invulnerable:1b,Silent:1b,Tags:["tom_entity"],CustomName:'[{"text":"Tom","color":"black","italic":false}]',CustomNameVisible:1b,Pose:{Head:[0f,0f,0f]}}

# Make Tom a fully black humanoid silhouette via leather armor + head
item replace entity @e[tag=tom_entity,sort=nearest,limit=1] armor.head with minecraft:player_head{SkullOwner:"MHF_Question",display:{Name:'{"text":"Tom"}'}}
item replace entity @e[tag=tom_entity,sort=nearest,limit=1] armor.chest with minecraft:leather_chestplate{display:{color:0}}
item replace entity @e[tag=tom_entity,sort=nearest,limit=1] armor.legs with minecraft:leather_leggings{display:{color:0}}
item replace entity @e[tag=tom_entity,sort=nearest,limit=1] armor.feet with minecraft:leather_boots{display:{color:0}}

# Reset next spawn cooldown immediately (2..10 minutes) for next appearance cycle
scoreboard players random #spawn_cd tom_cooldown 2400 12000

particle minecraft:smoke ~ ~1 ~ 0.6 1 0.6 0.03 20 force @a
playsound minecraft:entity.enderman.stare master @a ~ ~ ~ 0.7 0.7

tellraw @a [{"text":"[Tom] ","color":"dark_gray"},{"text":"Я уже рядом.","color":"black","italic":true}]
