class_name VelocityComponent
extends Node

##
@export var max_speed:float = 100
##
@export_range(0, 1) var acceleration:float = 1.0
##
@export_range(0, 1) var deceleration:float = 1.0


var velocity:Vector2 = Vector2.ZERO


func accelerate_to_velocity(vel:Vector2, weight:float=acceleration) -> void:
	velocity = velocity.lerp(vel, weight)
	pass
func accelerate_in_direction(direction:Vector2, weight:float=acceleration) -> void:
	accelerate_to_velocity(direction * max_speed)
	pass
func get_max_velocity(direction:Vector2) -> Vector2:
	return direction * max_speed 
func maximize_velocity(direction:Vector2) -> void:
	velocity = get_max_velocity(direction)
	pass
func decelerate(weight:float=deceleration) -> void:
	accelerate_to_velocity(Vector2.ZERO, weight)
	pass
func move(character:CharacterBody2D) -> void:
	character.set_velocity(velocity)
	character.move_and_slide()
	pass

func set_max_speed(value:float) -> void:
	max_speed = value
	pass

