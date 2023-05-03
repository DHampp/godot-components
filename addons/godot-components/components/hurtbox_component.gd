class_name HurtboxComponent
extends Area2D

## Emitted when the hitbox enters this hurtbox.
signal hit_by_hitbox(hitbox)

## TOOLTIP
@export var health_component:HealthComponent = null


func _ready() -> void:
	connect("area_entered", on_area_entered)
	pass

func deal_damage(damage:float) -> void:
	health_component.damage(damage)
	pass
func on_area_entered(area:Area2D) -> void:
	if not area is HitboxComponent:
		return
	
	#deal_damage(area.damage)
	emit_signal('hit_by_hitbox', area as HitboxComponent)
	pass
