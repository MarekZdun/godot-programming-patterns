class_name HealthComponent
extends Node2D

signal health_changed(health_update)
signal died(element)

@export var max_health: float:
	set(value):
		max_health = value
		if current_health > max_health:
			current_health = max_health
	get:
		return max_health

var current_health: float:
	set(value):
		var previous_health := current_health
		current_health = clamp(value, 0, max_health)
		var health_update := HealthUpdate.new()
		health_update.previous_health = previous_health
		health_update.current_health = current_health
		health_update.max_health = max_health
		health_update.health_percent = current_health_percent()
		health_update.is_heal = previous_health <= current_health
		health_changed.emit(health_update)
		if !has_health_remaining() and !_has_died:
			_has_died = true
			died.emit(_element_damage)
	get:
		return current_health

var _has_died: bool
var _element_damage: StatusReceiverComponent.Element


func _ready():
	reset_health.call_deferred()
	
	
func damage(attack_update: AttackUpdate) -> void:
	_element_damage = attack_update.attack_element
	current_health -= attack_update.attack_damage
	
	
func reset_health() -> void:
	current_health = max_health


func is_damaged() -> bool:
	return current_health < max_health


func has_health_remaining() -> bool:
	return !is_equal_approx(current_health, 0.0)
	
	
func current_health_percent() -> float:
	return (current_health / max_health) if (max_health > 0) else 0.0
