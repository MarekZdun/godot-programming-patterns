class_name FocusableComponent
extends Node

@export var focusable_packed_scene: PackedScene
@export var focusable_parent: Node

var _focusable: Node


func _exit_tree():
	remove_focusable()


func focus(interactor_component: Node, interactable_component: Node) -> void:
	assert(focusable_packed_scene, "focusable packed scene not found!")
	if not is_instance_valid(_focusable) or _focusable.is_queued_for_deletion():
		_focusable = focusable_packed_scene.instantiate()
		
		var intended_parent: Node
		if focusable_parent:
			intended_parent = focusable_parent

		if not intended_parent:
			if Interface.node_implements_interface(_focusable, Interface.Focusable):
				intended_parent = _focusable.get_intended_parent()
			
		if not intended_parent:
			intended_parent = interactable_component.agent.get_node_or_null("FocusableAnchor")
		
		if not intended_parent:
				intended_parent = interactable_component.agent
			
		intended_parent.add_child(_focusable)
		_focusable.unfocused.connect(_on_focusable_unfocused)
		
	if Interface.node_implements_interface(_focusable, Interface.Focusable):
		_focusable.focus(interactor_component, interactable_component)
	
	
func unfocus(interactor_component: Node, interactable_component: Node) -> void:
	if is_instance_valid(_focusable) and Interface.node_implements_interface(_focusable, Interface.Focusable):
		_focusable.unfocus(interactor_component, interactable_component)


func remove_focusable() -> void:
	if is_instance_valid(_focusable):
		var focusable_parent := _focusable.get_parent()
		focusable_parent.remove_child(_focusable)
		_focusable.queue_free()


func _on_focusable_unfocused() -> void:
	remove_focusable()
