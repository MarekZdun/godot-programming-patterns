class_name StatusReceiverComponent
extends Node2D

enum Element {NEUTRAL, WATER, EARTH, FIRE, WIND}

@export_range(0, 1) var attack_damage_mod: float = 1.0
@export_range(0, 1) var knockback_force_mod: float = 1.0
@export_range(0, 1) var stun_time_mod: float = 1.0
@export_range(0, 1) var neutral_resistance: float = 0.0
@export_range(0, 1) var water_resistance: float = 0.0
@export_range(0, 1) var earth_resistance: float = 0.0
@export_range(0, 1) var fire_resistance: float = 0.0
@export_range(0, 1) var wind_resistance: float = 0.0


func apply_attack_transformation(attack_update: AttackUpdate) -> void:
	if !attack_update:
		return
		
	match attack_update.attack_element:
		Element.NEUTRAL: 
			attack_update.attack_damage -= neutral_resistance * attack_update.attack_damage
		Element.WATER: 
			attack_update.attack_damage -= water_resistance * attack_update.attack_damage
		Element.EARTH: 
			attack_update.attack_damage -= earth_resistance * attack_update.attack_damage
		Element.FIRE: 
			attack_update.attack_damage -= fire_resistance * attack_update.attack_damage
		Element.WIND: 
			attack_update.attack_damage -= wind_resistance * attack_update.attack_damage
		_: 
			pass
	
	attack_update.attack_damage *= attack_damage_mod
	attack_update.attack_position
	attack_update.knockback_force *= knockback_force_mod
	attack_update.stun_time *= stun_time_mod
	
