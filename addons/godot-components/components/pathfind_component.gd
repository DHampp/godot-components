@tool
class_name PathfindComponent
extends Node2D

## Description
@onready var navigation_agent:NavigationAgent2D = $NavigationAgent2D
## Description
@export var velocity_component:VelocityComponent = null : set=set_velocity_component, get=get_velocity_component
func set_velocity_component(component:VelocityComponent) -> void:
	velocity_component = component
	pass
func get_velocity_component() -> VelocityComponent:
	return velocity_component
## Description
@export var debug_draw:bool = false


func set_target_position(target_pos:Vector2) -> void:
	navigation_agent.set_target_position(target_pos)
	pass
func follow_path() -> void:
	if navigation_agent.is_navigation_finished():
		velocity_component.decelerate()
		return
	
	var direction:Vector2 = (navigation_agent.get_next_path_position() - global_position).normalized()
	velocity_component.accelerate_in_direction(direction)
	navigation_agent.set_velocity(velocity_component.velocity)
	pass

func on_velocity_computed(velocity:Vector2) -> void:
	var new_direction = velocity.normalized()
	var current_direction = velocity_component.velocity.normalized()
	var halfway = new_direction.lerp(current_direction, 1)
	velocity_component.velocity = halfway * velocity_component.velocity.length()
	pass


func _ready() -> void:
	navigation_agent.connect("velocity_computed", on_velocity_computed)
	pass
func _get_configuration_warnings() -> PackedStringArray:
	var warnings := []
	
	var has_nav_agent:bool = false
	for child in get_children():
		if child is NavigationAgent2D:
			has_nav_agent = true
	
	if velocity_component == null:
		warnings.append("%s is missing a VelocityComponent. \n Consider setting one in the inspector." % name)
	
	
	return warnings
