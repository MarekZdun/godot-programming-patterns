extends Node2D

@onready var focusable_anchor: Marker2D = $FocusableAnchor
@onready var interactable_2d_component = $Interactable2dComponent
@onready var focusable_component = $FocusableComponent
@onready var shop_ui = $ShopUI


func _ready():
	shop_ui.visible = false
	interactable_2d_component.interacted.connect(_on_interactable_2d_component_interacted)
	interactable_2d_component.unregistered_interaction.connect(_on_interactable_2d_component_unregistered)


func show_shop_ui() -> void:	
	shop_ui.visible = true
	shop_ui.get_node("GridContainer/Button").grab_focus()
	
	
func hide_shop_ui() -> void:	
	shop_ui.visible = false
	
	
func lock_interactor_agent_controller(interactor_component: InteractorArea2dComponent) -> void:
	var interactor_agent: Node = interactor_component.agent
	if not interactor_agent:
		return
		
	var interactor_agent_controller_component: Node = interactor_agent.controller_component
	if not interactor_agent_controller_component:
		return
	
	interactor_agent_controller_component.set_lock_due_to_interaction(true)
	
	
func unlock_interactor_agent_controller(interactor_component: InteractorArea2dComponent) -> void:
	var interactor_agent: Node = interactor_component.agent
	if not interactor_agent:
		return
		
	var interactor_agent_controller_component: Node = interactor_agent.controller_component
	if not interactor_agent_controller_component:
		return
	
	interactor_agent_controller_component.set_lock_due_to_interaction(false)


func _on_interactable_2d_component_interacted(interactor_component: InteractorArea2dComponent):
	if not shop_ui.visible:
		show_shop_ui()
		lock_interactor_agent_controller(interactor_component)
		focusable_component.remove_focusable()
	else:
		hide_shop_ui()
		unlock_interactor_agent_controller(interactor_component)
		if interactor_component.is_interactable_component_selected(interactable_2d_component):
			focusable_component.focus(interactor_component, interactable_2d_component)
	
	
func _on_interactable_2d_component_unregistered(interactor_component: InteractorArea2dComponent) -> void:
	if shop_ui.visible:
		hide_shop_ui()
		
	unlock_interactor_agent_controller(interactor_component)
