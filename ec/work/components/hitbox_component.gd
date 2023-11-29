class_name HitboxComponent
extends Area2D

@export var attack_element: StatusReceiverComponent.Element = StatusReceiverComponent.Element.NEUTRAL
@export var attack_damage: float = 10.0
@export var knockback_force: float = 100
@export var stun_time: float = 1.5
	
	
func get_attack() -> AttackUpdate:
	var attack := AttackUpdate.new()
	attack.attack_element = attack_element
	attack.attack_damage = attack_damage
	attack.knockback_force = knockback_force
	attack.attack_position = (owner as Node2D).global_position
	attack.stun_time = stun_time
	return attack
