extends CharacterBody2D
class_name Player

@onready var urm_2d: URM2D = $URM2D
var input_direction: Vector2

@onready var state_machine: StateMachine = $StateMachine
var states: PlayerStates = PlayerStates.new()

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var animations: PlayerAnimations = PlayerAnimations.new()

@export var current_animation: String = animations.idle_none

var directions: PlayerDirections = PlayerDirections.new()
@export var current_direction: PlayerDirection = directions.none

func _ready() -> void:
	# Inicializar la animación inicial
	current_animation = 'idle_down'
	animation_player.play(current_animation)

func set_input_direction():
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func input_axis_direction():
	input_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

func _physics_process(_delta: float) -> void:
	move()

func move():
	set_input_direction()
	urm_2d.direction_2d = input_direction
	urm_2d.move()

func move_2():
	set_input_direction()
	urm_2d.direction_2d = input_direction
	var velocity = urm_2d.get_velocity()
	move_and_slide()
	print(velocity)

func _on_timer_timeout() -> void:
	urm_2d.stop_movement()
