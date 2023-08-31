extends Node2D

@onready var label = $Label

var target: Node2D
var label_text: String:
	set(value):
		label_text = value
		label.text = label_text
		

func _process(delta):
	if target:
		global_position = target.global_position + Vector2(0, -76)
