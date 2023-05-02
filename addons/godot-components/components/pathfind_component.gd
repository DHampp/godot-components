class_name PathfindComponent
extends Node2D

@onready var navigation_agent:NavigationAgent2D = NavigationAgent2D.new()

## TOOLTIP
@export var velocity_component:VelocityComponent = null
## TOOLTIP
@export var debug_draw:bool = false

func _ready() -> void:
	navigation_agent.connect("velocity_computed", on_velocity_computed)
	pass

func set_target(target) -> void:
	
	pass

func follow_path() -> void:
	if navigation_agent.is_navigation_finished():
		velocity_component.decelerate()
		return
	
	var direction := (navigation_agent.get_next_path_position() - global_position).normalized()
	velocity_component.accelerate_in_direction(direction)
	navigation_agent.set_velocity(velocity_component.velocity)
	pass

func on_velocity_computed() -> void:
	
	pass
