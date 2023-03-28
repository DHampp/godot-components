extends Object
class_name StateMachine

var running : bool = false
var state : String = "" : set = set_state
var states : Dictionary = {}
func set_state(value: String) -> void:
	if not state == value:
		_exit_state()
		state = value
		_enter_state()
	pass

func _init() -> void:
	pass
func add_state(state_name: String, enter_method: Callable, update_method: Callable, exit_method: Callable) -> void:
	states[state_name] = { "enter": enter_method, "update": update_method, "exit": exit_method }
	pass

func start(state: String) -> void:
	running = true
	set_state(state)
	pass
func stop() -> void:
	running = false
	set_state("")
	pass

func _update(delta: float) -> void:
	if not states.has(state) or not running:
		return
	
	var method : Callable = states[state].update
	if method == null:
		return
	
	var transition : String = method.call(delta)
	if not transition.is_empty():
		set_state(transition)
	pass
func _exit_state() -> void:
	if not states.has(state) or not running:
		return
	
	var method : Callable = states[state].exit
	if not method == null:
		method.call()
	pass
func _enter_state() -> void:
	if not states.has(state) or not running:
		return
	
	var method : Callable = states[state].enter
	if not method == null:
		method.call()
	pass
