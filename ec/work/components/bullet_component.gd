class_name BulletComponent
extends Area2D

@export var gun_stats: GunStats


func _ready():
	area_entered.connect(_on_area_entered)


func get_attack() -> AttackUpdate:
	var attack := AttackUpdate.new()
	attack.attack_damage = gun_stats.damage_per_bullet
	attack.knockback_force = gun_stats.knockback_force
	attack.attack_position = (owner as Node2D).global_position	# owner???
	attack.stun_time = gun_stats.stun_time
	return attack
	
	
func _on_area_entered(other_area: Area2D) -> void:
	var hurtbox_component := other_area as HurtboxComponent
	if hurtbox_component:
		hurtbox_component.handle_bullet_collision(self)
