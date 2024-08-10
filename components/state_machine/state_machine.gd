extends Node
## StateMachine Version 1.0
class_name StateMachine

@onready var node_to_control = self.owner
@export_node_path('Node') var initial_state
@onready var state: Node = get_node(initial_state)

##DEBUG
@export var DEBUG : bool = true
@export var ACTIVATE_HISTORY : bool = false
@export var PRINT_HISTORY : bool = false
var history: Array[String] = []

func _ready() -> void:
	if state == null:
		push_error("Initial state is not set or invalid!")
		return
	call_deferred("_enter_state")

func _enter_state():
	if DEBUG:
		print(owner.name, ": Entering state: ", state.name)
	state.node = node_to_control
	state.state_machine = self
	states_history()
	state.enter()

func change_to(name_of_new_state: String):
	history.append(state.name)
	state = get_node(name_of_new_state)
	_enter_state()

func states_history():
	if ACTIVATE_HISTORY or PRINT_HISTORY:
		history.append(state.name)
	if PRINT_HISTORY:
		print(history)

func _process(delta: float) -> void:
	if state.has_method("process"):
		state.process(delta)

func _physics_process(delta: float) -> void:
	if state.has_method("physics_process"):
		state.physics_process(delta)

func _input(event):
	if state.has_method("input"):
		state.input(event)

func _unhandled_input(event):
	if state.has_method("unhandled_input"):
		state.unhandled_input(event)

func _unhandled_key_input(event):
	if state.has_method("unhandled_key_input"):
		state.unhandled_key_input(event)
