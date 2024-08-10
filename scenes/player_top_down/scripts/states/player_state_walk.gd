extends PlayerState

func enter():
	if player.current_direction:
		print("State Walk | Direction: " + player.current_direction._name)
	else:
		print("State Walk | No Direction Set")

func physics_process(_delta):
	if Input.is_action_pressed('ui_accept'):
		state_machine.change_to(player.states._idle)
	else:
		move_8_directions()
	
func set_action_direction():
	if Input.is_action_pressed('ui_left'):
		set_current_direction(player.directions.left)
		set_current_animation(player.animations.walk_left)
	elif Input.is_action_pressed('ui_right'):
		set_current_direction(player.directions.right)
		set_current_animation(player.animations.walk_right)
	elif Input.is_action_pressed('ui_up'):
		set_current_direction(player.directions.up)
		set_current_animation(player.animations.walk_up)
	elif Input.is_action_pressed('ui_down'):
		set_current_direction(player.directions.down)
		set_current_animation(player.animations.walk_down)
	else:
		# Cambiar el estado a inactivo solo si no hay entrada
		state_machine.change_to(player.states._idle)

func move_4_directions():
	set_action_direction()
	player.urm_2d.direction_2d = player.current_direction._vector_2d
	player.urm_2d.move()

func move_8_directions():
	var input_direction: Vector2 = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')

	# No es necesario normalizar aquí si ya se maneja en URM2D
	player.urm_2d.direction_2d = input_direction
	player.urm_2d.move()

