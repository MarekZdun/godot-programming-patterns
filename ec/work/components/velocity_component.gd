class_name VelocityComponent
extends Node

@export var _max_speed: float = 300.0
@export var _jump_force: float = -400.0
#@export var _acceleration_coefficient: float = 10

var velocity: Vector2 = Vector2.ZERO
#var speed_multiplier: float = 1.0
#var acceleration_coefficient_multiplier: float = 1.0
var _direction_horizontal: float
var _jump_requested: bool = false
var _knockback_force: float = 0.0
var _knockback_from: Vector2 = Vector2.ZERO
var _knockback_requested: bool = false
var _knockback_duration: float = 0.0
var _knockbacking: bool = false

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


#func accelerate_to_velocity(p_velocity: Vector2) -> void:
#	pass
	
	
func accelerate_in_horizontal_direction(p_direction_horizontal: float) -> void:
	_direction_horizontal = p_direction_horizontal


func jump_request() -> void:
	_jump_requested = true
	
	
func knockback_request(attack_update: AttackUpdate) -> void:
	_knockback_from = attack_update.attack_position
	_knockback_force = attack_update.knockback_force
	_knockback_duration = attack_update.stun_time
	_knockback_requested = true
	
	
#func get_calculated_max_speed() -> float:
#	return _max_speed * ()


func move(actor: CharacterBody2D, delta: float) -> void:
	if _knockback_requested:
		_knockback_requested = false
		_knockbacking = true
		get_tree().create_timer(_knockback_duration, false).timeout.connect(func(): _knockbacking = false)
		velocity = _knockback_from.direction_to(actor.global_position) * _knockback_force
	
	if not actor.is_on_floor():
		if _jump_requested:
			_jump_requested = false
		velocity.y += gravity * delta
		
	if _jump_requested and actor.is_on_floor():
		_jump_requested = false
		velocity.y = _jump_force
		
	if _direction_horizontal:
		velocity.x = _direction_horizontal * _max_speed
		
	if _direction_horizontal == 0.0 and not _knockbacking:
		velocity.x = move_toward(velocity.x, 0, _max_speed)
	
	actor.velocity = velocity
	actor.move_and_slide()
