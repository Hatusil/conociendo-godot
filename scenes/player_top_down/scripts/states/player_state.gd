extends Node
class_name PlayerState

var state_machine: StateMachine
var node: Player:
	set(value):
		node = value
		player = value
	get:
		return node

var player: Player

func enter() -> void:
	# Método virtual: Sobrescribir en estados hijos
	pass

func play_animation(new_animation: String) -> void:
	player.current_animation = new_animation
	player.animation_player.play(new_animation)

func set_current_animation(animation: String) -> void:
	player.current_animation = animation

func set_current_direction(direction: PlayerDirection) -> void:
	player.current_direction = direction
