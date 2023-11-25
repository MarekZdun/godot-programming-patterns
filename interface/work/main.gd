extends Node

@onready var actor = $Actor


func _ready():
	if Interface.node_implements_interface(actor, Interface.FireDamageable):
		var attack_update: AttackUpdate = AttackUpdate.new()
		attack_update.attack_damage = 10
		actor.take_fire_damage(attack_update)
		
	if Interface.node_implements_interface(actor, Interface.WaterDamageable):
		var attack_update: AttackUpdate = AttackUpdate.new()
		attack_update.attack_damage = 20
		actor.take_water_damage(attack_update)
		
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
