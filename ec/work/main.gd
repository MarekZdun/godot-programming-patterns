extends Node

var _bullet_start_pos: Vector2
var _bullet_start_rot: float

@onready var actor := $Actor
@onready var danger_zone = $DangerZone
@onready var health_display = $HealthDisplay
@onready var floor = $Floor
@onready var bullet: Bullet = $Bullet


func _ready():
	health_display.target = actor
	actor.health_component.health_changed.connect(func(health_update: HealthUpdate): health_display.label_text = "%s" % health_update.current_health)
	_bullet_start_pos = bullet.global_position
	_bullet_start_rot = bullet.global_rotation
	
	
func _unhandled_input(event):
	if event is InputEventKey and !event.is_echo():
		if event.is_pressed() and event.keycode == KEY_F:
			bullet.fire(_bullet_start_pos, _bullet_start_rot)
