@tool
class_name HealthComponent
extends Node

## Emitted when the max_health changed.
signal max_health_changed(max_health:float)
## Emitted when the current_health changed.
signal health_changed(health:float)
## Emitted when the current_health reached 0.
signal died()


## Description
@export var max_health:float = 0.0 : set=set_max_health, get=get_max_health
func set_max_health(value:float) -> void:
	max_health = value
	emit_signal("max_health_changed", max_health)
	
	if (current_health > max_health):
		set_current_health(max_health)
	pass
func get_max_health() -> float:
	return max_health
## Description
@export var current_health:float = max_health : set=set_current_health, get=get_current_health
func set_current_health(value:float) -> void:
	current_health = clamp(value, 0, max_health)
	emit_signal("health_changed", current_health)
	
	if not has_health_remaining() and not dead:
		dead = true
		emit_signal("died")
	pass
func get_current_health() -> float:
	return current_health
## Description
var dead:bool = false : get=is_dead
func is_dead() -> bool:
	return dead


## Description
func is_damaged() -> bool:
	return current_health < max_health
## Description
func get_current_health_percent() -> float:
	return current_health / max_health if max_health > 0 else 0.0
## Description
func has_health_remaining() -> bool:
	return not is_equal_approx(current_health, 0)

## Description
func damage(damage:float) -> void:
	set_current_health(current_health-damage)
	pass
## Description
func heal(heal:float) -> void:
	set_current_health(current_health+heal)
	pass


func _ready() -> void:
	pass
func _get_configuration_warnings() -> PackedStringArray:
	var warnings := []
	
	return warnings
