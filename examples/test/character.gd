extends CharacterBody2D

@onready var state_machine:StateMachine = StateMachine.new()
@onready var velocity_component:VelocityComponent = $VelocityComponent
@onready var health_component:HealthComponent = $HealthComponent


func _ready() -> void:
	state_machine.add_state('idle', on_idle_entered, on_idle_update, on_idle_exited)
	state_machine.add_state('move', on_move_entered, on_move_update, on_move_exited)
	state_machine.start('idle')
	pass
func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		health_component.damage(1)
func _physics_process(_delta):
	state_machine._update(_delta)
	#pathfind_component.set_target_position(get_global_mouse_position())
	#pathfind_component.follow_path()
	#velocity_component.move(self)

func get_input() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

func on_idle_entered() -> void:
	pass
func on_idle_update(_delta) -> String:
	velocity_component.decelerate()
	velocity_component.move(self)
	
	if get_input() != Vector2.ZERO:
		return "move"
	return 'idle'
func on_idle_exited() -> void:
	pass

func on_move_entered() -> void:
	pass
func on_move_update(_delta) -> String:
	velocity_component.accelerate_in_direction(get_input())
	velocity_component.move(self)
	
	if get_input() == Vector2.ZERO:
		return "idle"
	return "move"
func on_move_exited() -> void:
	pass


func _on_health_component_died():
	print("died")
	pass
func _on_health_component_health_changed(health):
	print("new health ", health)
	pass
