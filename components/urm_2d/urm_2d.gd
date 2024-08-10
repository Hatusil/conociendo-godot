extends Node
# Uniform Rectilinear Motion 2D
## Versión 1.1
class_name URM2D

@export var speed: float = 100 # Rapidez del movimiento
@export var direction_2d: Vector2 = Vector2.ZERO # Dirección del movimiento
@export var normalized: bool = true # Si se debe normalizar la dirección
@export var character: CharacterBody2D # Nodo del personaje que se moverá
@export var can_move: bool = true # Indica si el personaje puede moverse

func _ready():
	if character == null:
		push_error("La variable 'character' no está asignada en URM2D. Por favor, asígnala en el Inspector.")

func get_velocity() -> Vector2:
	"""
	Calcula la velocidad basada en la dirección y rapidez.
	"""
	var dir = direction_2d
	if normalized and direction_2d != Vector2.ZERO:
		dir = direction_2d.normalized()
	return dir * speed

func move():
	"""
	Aplica el movimiento al personaje si 'can_move' es verdadero.
	"""
	if character == null:
		push_error("La variable 'character' no está asignada en URM2D.")
		return
	if can_move:
		character.velocity = get_velocity()
		character.move_and_slide()
	else:
		character.velocity = Vector2.ZERO

func stop_movement():
	"""
	Detiene el movimiento del personaje.
	"""
	can_move = false
	if character != null:
		character.velocity = Vector2.ZERO

func start_movement():
	"""
	Permite el movimiento del personaje.
	"""
	can_move = true

func _physics_process(delta: float) -> void:
	move()
