# Spawn timer: every 2-5 minutes when Tom is absent
execute unless entity @e[tag=tom_entity,limit=1] run scoreboard players remove #spawn_cd tom_cooldown 1
execute unless entity @e[tag=tom_entity,limit=1] if score #spawn_cd tom_cooldown matches ..0 run function mystical_tom:spawn

# Active Tom behavior
execute if entity @e[tag=tom_entity,limit=1] run function mystical_tom:behavior

# Global world bonuses
function mystical_tom:world_bonus
