class_name ControllerComponent
extends Node

@export var _velocity_component: VelocityComponent

var active: bool = true


func scan_input() -> void:
	if _velocity_component == null or not active:
		return
	
	if Input.is_action_just_pressed("ui_accept"):
		_velocity_component.jump_request()
		
	_velocity_component.accelerate_in_horizontal_direction(Input.get_axis("ui_left", "ui_right"))
	
	
func deactivate_for(time: float) -> void:
	active = false
	get_tree().create_timer(time, false).timeout.connect(func(): active = true)
