extends Node2D

var implements = [Interface.FireDamageable, Interface.WaterDamageable]


func take_fire_damage(attack: AttackUpdate) -> void:
	print("actor was attacked with %s fire damage" % attack.attack_damage)
	
	
func take_water_damage(attack: AttackUpdate) -> void:
		print("actor was attacked with %s water damage" % attack.attack_damage)
