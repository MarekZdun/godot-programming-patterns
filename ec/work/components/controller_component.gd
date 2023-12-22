class_name ControllerComponent
extends Node

@export var _velocity_component: VelocityComponent

var active: bool = true:
	set = set_active
	
var lock_due_to_interaction: bool = false:
	set = set_lock_due_to_interaction


func scan_input() -> void:
	if _velocity_component == null:
		return
	
	if active and not lock_due_to_interaction:
		if Input.is_action_just_pressed("ui_accept"):
			_velocity_component.jump_request()
			
		_velocity_component.accelerate_in_horizontal_direction(Input.get_axis("ui_left", "ui_right"))
	else:
		_velocity_component.accelerate_in_horizontal_direction(0.0)
	
	
func deactivate_for(time: float) -> void:
	active = false
	get_tree().create_timer(time, false).timeout.connect(func(): active = true)
	
	
func set_active(p_active: bool) -> void:
	active = p_active
	
	
func set_lock_due_to_interaction(p_lock: bool) -> void:
	lock_due_to_interaction = p_lock
 
