extends Node2D

var implements = Interface.Focusable

signal unfocused

var focus_start_offset: Vector2 = Vector2(0, -250)
var focus_end_offset: Vector2 = Vector2(0, -100)
var focus_duration: float = 0.5
var unfocus_duration: float = 0.5

var _tween: Tween
var _tween_2: Tween
var _distance_between_offsets: float


func _ready():
	_distance_between_offsets = focus_start_offset.distance_to(focus_end_offset)
	position = focus_start_offset
	visible = true


func focus(interactor_component: Node, interactable_component: Node) -> void:
	if !interactor_component or !interactable_component:
		return
		
	if _tween and _tween.is_valid():
		_tween.kill()
		
	if _tween_2 and _tween_2.is_valid():
		_tween_2.kill()
	
	var scaled_distance_to_target: float = position.distance_to(focus_end_offset) * focus_duration
	var duration := scaled_distance_to_target / _distance_between_offsets
	
	_tween_2 = self.create_tween()
	_tween_2.tween_property(self, "modulate:a", 1.0, duration / 2)
	_tween_2.stop()
	
	_tween = self.create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	_tween.tween_property(self, "position", focus_end_offset, duration)
	_tween.set_parallel().tween_interval(duration / 2).finished.connect(_tween_2.play)
	
	
func unfocus(interactor_component: Node, interactable_component: Node) -> void:
	if !interactor_component or !interactable_component:
		return
		
	if _tween and _tween.is_valid():
		_tween.kill()
		
	if _tween_2 and _tween_2.is_valid():
		_tween_2.kill()

	var scaled_distance_to_target: float = position.distance_to(focus_start_offset) * unfocus_duration
	var duration := scaled_distance_to_target / _distance_between_offsets
		
	_tween_2 = self.create_tween()
	_tween_2.tween_property(self, "modulate:a", 0.0, duration / 2)
	_tween_2.stop()
	
	_tween = self.create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	_tween.tween_property(self, "position", focus_start_offset, duration).finished.connect(emit_signal.bind(unfocused.get_name()))
	_tween.set_parallel().tween_interval(duration / 2).finished.connect(_tween_2.play)
	
	
func get_intended_parent() -> Node:
	return null
