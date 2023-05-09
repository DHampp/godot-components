@tool
class_name HitboxComponent
extends Area2D

## Description
@export var damage:float = 0.0
func set_damage(value:float) -> void:
	damage = value
	pass
func get_damage() -> float:
	return damage


func _ready() -> void:
	if not Engine.is_editor_hint():
		return
	
	monitoring = false
	input_pickable = false
	pass
func _get_configuration_warnings() -> PackedStringArray:
	var warnings := []
	
	return warnings
