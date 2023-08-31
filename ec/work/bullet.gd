class_name Bullet
extends Node2D

var _run: bool
@export var _speed: float = 10

@onready var timer: Timer = $Timer


func _ready():
	timer.timeout.connect(_on_Timer_timeout)
	
	
func _process(delta):
	if _run:
		transform = transform.translated_local(Vector2(delta * _speed, 0))


func fire(pos: Vector2, rot: float) -> void:
	global_position = pos
	global_rotation = rot
	
	timer.start()
	_run = true
	
	
func _on_Timer_timeout() -> void:
	_run = false
