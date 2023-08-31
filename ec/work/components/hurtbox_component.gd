class_name HurtboxComponent
extends Area2D

signal hit_by_hitbox(hit_context)
signal hit_by_bullet(hit_context)

@export var _health_component: HealthComponent
@export var _status_receiver_component: StatusReceiverComponent


func _ready():
	area_entered.connect(_on_area_entered)
	
	
func deal_damage(attack_update: AttackUpdate) -> void:
	if _status_receiver_component:
		_status_receiver_component.apply_attack_transformation(attack_update)
	
	if _health_component:
		_health_component.damage(attack_update)
		
		
func handle_bullet_collision(bullet_component: BulletComponent) -> void:
	var attack_update := bullet_component.get_attack() as AttackUpdate
	deal_damage(attack_update)
	# to do; create impact scene or send signal to manager to create impact scene
	var hit_context := BulletHitContext.new()
	hit_context.bullet_component = bullet_component
	hit_context.attack_update = attack_update
	hit_by_bullet.emit(hit_context)
	
	
func _on_area_entered(other_area: Area2D) -> void:
	var hitbox_component := other_area as HitboxComponent
	if hitbox_component:
		var attack_update := hitbox_component.get_attack() as AttackUpdate
		deal_damage(attack_update)
		# to do; create impact scene or send signal to manager to create impact scene
		var hit_context := HitboxHitContext.new()
		hit_context.hitbox_component = hitbox_component
		hit_context.attack_update = attack_update
		hit_by_hitbox.emit(hit_context)
