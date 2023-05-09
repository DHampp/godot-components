@tool
class_name HurtboxComponent
extends Area2D

## Emitted when the hitbox enters this hurtbox.
signal hit_by_hitbox(hitbox:HitboxComponent)


## Description
@export var health_component:HealthComponent = null : set=set_health_component, get=get_health_component
func set_health_component(component:HealthComponent) -> void:
	health_component = component
	pass
func get_health_component() -> HealthComponent:
	return health_component


## Description
func deal_damage(damage:float) -> void:
	health_component.damage(damage)
	pass
## Description
func on_area_entered(area:Area2D) -> void:
	if not area is HitboxComponent:
		return
	
	deal_damage(area.damage)
	emit_signal('hit_by_hitbox', area as HitboxComponent)
	pass


func _ready() -> void:
	if Engine.is_editor_hint():
		monitorable = false
		input_pickable = false
	
	connect("area_entered", on_area_entered)
	pass
func _get_configuration_warnings() -> PackedStringArray:
	var warnings := []
	
	if health_component == null:
		warnings.append("%s is missing a HealthComponent. \n Consider setting one in the inspector." % name)
	
	return warnings
