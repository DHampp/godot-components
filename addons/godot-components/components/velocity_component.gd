class_name VelocityComponent
extends Node

##
@export var max_speed:float = 100
##
@export var acceleration:float = 1.0
##
@export var debug:bool = false


var velocity:Vector2 = Vector2.ZERO


func accelerate_to_velocity(vel:Vector2) -> void:
	velocity = velocity.lerp(vel, 0)
	pass
func accelerate_in_direction(direction:Vector2) -> void:
	velocity = velocity.lerp(direction, 0.1)
	pass
func get_max_velocity(direction:Vector2) -> Vector2:
	return direction #* 
func maxmize_velocity(direction:Vector2) -> void:
	velocity = get_max_velocity(direction)
	pass
func decelerate() -> void:
	accelerate_to_velocity(Vector2.ZERO)
	pass
func move(character:CharacterBody2D) -> void:
	character.set_velocity(velocity)
	character.move_and_slide()
	pass

func set_max_speed(value:float) -> void:
	max_speed = value
	pass
