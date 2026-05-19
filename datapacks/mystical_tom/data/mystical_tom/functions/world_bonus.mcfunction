# Permanent luck refresh for players
execute as @a run effect give @s minecraft:luck 8 1 true

# Extra general loot periodically near random player
scoreboard players remove #loot_cd tom_loot_cd 1
execute if score #loot_cd tom_loot_cd matches ..0 at @r run loot spawn ~ ~1 ~ loot minecraft:chests/simple_dungeon
execute if score #loot_cd tom_loot_cd matches ..0 run scoreboard players random #loot_cd tom_loot_cd 900 1800
execute if score #loot_cd tom_loot_cd matches ..0 run tellraw @a [{"text":"[Мир] ","color":"gold"},{"text":"Удача усилилась: мир выдал дополнительный лут.","color":"yellow"}]

# More frequent peaceful mobs
scoreboard players remove #peace_cd tom_peace_cd 1
execute if score #peace_cd tom_peace_cd matches ..0 at @r run summon minecraft:cow ~3 ~ ~3
execute if score #peace_cd tom_peace_cd matches ..0 at @r run summon minecraft:sheep ~-3 ~ ~2
execute if score #peace_cd tom_peace_cd matches ..0 at @r run summon minecraft:pig ~2 ~ ~-3
execute if score #peace_cd tom_peace_cd matches ..0 at @r run summon minecraft:chicken ~-2 ~ ~-2
execute if score #peace_cd tom_peace_cd matches ..0 run scoreboard players random #peace_cd tom_peace_cd 600 1200
