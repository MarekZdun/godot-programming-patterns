class_name InteractableArea2dComponent
extends Area2D

signal interacted(interactor_component)
signal registered_interaction(interactor_component)
signal unregistered_interaction(interactor_component)

@export var agent: Node2D
@export var focusable_component: FocusableComponent
@export var interaction_text: String = "[E] TO INTERACT"


func interact(interactor_component: InteractorArea2dComponent) -> void:
	interacted.emit(interactor_component)
	
	
func register_interaction(interactor_component: InteractorArea2dComponent) -> void:
	if focusable_component:
		focusable_component.focus(interactor_component, self)
	
	registered_interaction.emit(interactor_component)
	
	
func unregister_interaction(interactor_component: InteractorArea2dComponent) -> void:
	if focusable_component:
		focusable_component.unfocus(interactor_component, self)
		
	unregistered_interaction.emit(interactor_component)
