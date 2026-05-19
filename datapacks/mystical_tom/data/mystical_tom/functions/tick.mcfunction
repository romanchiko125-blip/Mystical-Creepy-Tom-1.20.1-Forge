# Random roll each tick; very small chance to spawn Tom if absent
execute unless entity @e[tag=tom_entity,limit=1] run scoreboard players random #spawn_roll tom_roll 1 900
execute unless entity @e[tag=tom_entity,limit=1] if score #spawn_roll tom_roll matches 1 run function mystical_tom:spawn

# Behavior loop for active Tom
execute if entity @e[tag=tom_entity,limit=1] run function mystical_tom:behavior
