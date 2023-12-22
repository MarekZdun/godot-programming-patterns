class_name InteractorArea2dComponent
extends Area2D

@export var agent: Node2D
@export var interaction_action: String = "interact"

var selected_interactable_component: InteractableArea2dComponent
var active_interactable_components: Array[InteractableArea2dComponent]


func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func _input(event: InputEvent):
	if event.is_action_pressed(interaction_action):
		if selected_interactable_component:
			selected_interactable_component.interact(self)
			
			
func is_interactable_component_selected(interactable_component: InteractableArea2dComponent) -> bool:
	return interactable_component == selected_interactable_component


func _on_area_entered(area: Area2D):
	if area is InteractableArea2dComponent:
		active_interactable_components.push_back(area)
		
		if selected_interactable_component == null:
			selected_interactable_component = active_interactable_components.front()
			selected_interactable_component.register_interaction(self)


func _on_area_exited(area: Area2D):
	if area is InteractableArea2dComponent:
		active_interactable_components.erase(area)
		
		if selected_interactable_component == area and !active_interactable_components.is_empty():
			area.unregister_interaction(self)
			selected_interactable_component = active_interactable_components.front()
			selected_interactable_component.register_interaction(self)
			
		if active_interactable_components.is_empty():
			area.unregister_interaction(self)
			selected_interactable_component = null
