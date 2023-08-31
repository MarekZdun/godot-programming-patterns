extends CharacterBody2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var controller_component: ControllerComponent = $ControllerComponent


func _ready():
	hurtbox_component.hit_by_bullet.connect(_on_hit_by_bullet)
	hurtbox_component.hit_by_hitbox.connect(_on_hit_by_hitbox)


func _physics_process(delta):
	if controller_component:
		controller_component.scan_input()
		
	if velocity_component:
		velocity_component.move(self, delta)
		
		
func _on_hit_by_bullet(hit_context: BulletHitContext) -> void:
	if velocity_component:
		velocity_component.knockback_request(hit_context.attack_update)

	if controller_component:
		controller_component.deactivate_for(hit_context.attack_update.stun_time)
		
		
func _on_hit_by_hitbox(hit_context: HitboxHitContext) -> void:
	if velocity_component:
		velocity_component.knockback_request(hit_context.attack_update)

	if controller_component:
		controller_component.deactivate_for(hit_context.attack_update.stun_time)
