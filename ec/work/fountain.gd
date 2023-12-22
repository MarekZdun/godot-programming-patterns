extends Node2D

@onready var interactable_2d_component: InteractableArea2dComponent = $Interactable2dComponent as InteractableArea2dComponent
@onready var focusable_anchor: Marker2D = $FocusableAnchor

@export var is_on: bool = true:
	set(value):
		if is_on == value:
			return
		is_on = value
		_update_particle_emit(is_on)

@onready var gpu_particles_2d = $GPUParticles2D


func _ready():
	interactable_2d_component.interacted.connect(_on_interactable_2d_component_interacted)
	_update_particle_emit(is_on)


func _update_particle_emit(on: bool) -> void:
	if gpu_particles_2d:
		gpu_particles_2d.emitting = on


func _on_interactable_2d_component_interacted(interactor_component):
	is_on = not is_on
