# Tom spawn cooldown: from every 2 to 10 minutes (2400..12000 ticks)
execute unless entity @e[tag=tom_entity,limit=1] run scoreboard players remove #spawn_cd tom_cooldown 1
execute unless entity @e[tag=tom_entity,limit=1] if score #spawn_cd tom_cooldown matches ..0 run function mystical_tom:spawn

# Behavior loop for active Tom
execute if entity @e[tag=tom_entity,limit=1] run function mystical_tom:behavior

# Global bonus luck/loot and peaceful mob boosts
function mystical_tom:world_bonus
