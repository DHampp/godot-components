class_name HealthComponent
extends Node

## DESCRIPTION
signal health_changed(health)
## DESCRIPTION
signal died()

## DESCRIPTION
@export var max_health:float = 0.0 : set=set_max_health, get=get_max_health

var current_health:float = 0.0 : set=set_current_health, get=get_current_health
var has_died : bool = false


func set_max_health(value:float) -> void:
	max_health = value
	if (current_health > max_health):
		current_health = max_health
	pass
func get_max_health() -> float:
	return max_health
func set_current_health(value:float) -> void:
	current_health = clamp(value, 0, max_health)
	emit_signal("health_changed", current_health)
	
	if not has_health_remaining() and not has_died:
		has_died = true
		emit_signal("died")
	pass
func get_current_health() -> float:
	return current_health

func get_current_health_percent() -> float:
	return current_health / max_health if max_health > 0 else 0.0

func has_health_remaining() -> bool:
	return not is_equal_approx(current_health, 0)
func is_damaged() -> bool:
	return current_health < max_health

func _ready() -> void:
	_initialize_health()
	pass
func _initialize_health() -> void:
	set_current_health(max_health)
	pass
func damage(damage:float) -> void:
	pass
func heal(heal:float) -> void:
	set_current_health(current_health+heal)
	pass
