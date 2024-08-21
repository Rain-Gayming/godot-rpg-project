extends Node3D

#region references
@export_group("references")
@export var player_body : CharacterBody3D
@export var neck : Node3D
@export var camera : Node3D
#endregion

#region stamina
@export_group("stamina")
@export var stamina_manager : float_change
@export var stamina_regen_rate : float = 0.5
@export var stamina_decrease_rate : float = 1
#endregion

#region speed

@export_group("speeds")
@export var current_move_type : GlobalEnums.movement_type
@export var current_speed : float
@export var speed_multiplier : float = 1
@export var walk_speed : float = 3
@export var run_speed : float = 5
@export var sprint_speed : float = 7
#endregion

#region jumping

@export_group("jumping")
@export var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var jump_height : float
@export var jump_multiplier : float = 1
#endregion


#region funcs godot
func _ready() -> void:
	#sets the default speed
	current_speed = run_speed
	set_move_type(GlobalEnums.movement_type.run)

func _physics_process(delta: float) -> void:
	jump(delta)
	move(delta)
	set_move_type_input()
	
	player_body.move_and_slide()
#endregion

#region funcs movement

func jump(delta: float) -> void:
	
	#gravity
	if not player_body.is_on_floor():
		player_body.velocity.y -= gravity * delta
	
	#jumping
	if Input.is_action_just_pressed("move_jump") and player_body.is_on_floor():
		player_body.velocity.y = jump_height * jump_multiplier

func move(delta: float) -> void:
	
	if stamina_manager.currentValue <= stamina_manager.minValue:
		set_move_type(GlobalEnums.movement_type.run)
	
	#movement inputs
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#moving
	if direction:
		player_body.velocity.x = direction.x * current_speed * speed_multiplier
		player_body.velocity.z = direction.z * current_speed * speed_multiplier
		
		#if the player is sprinting remove stamina
		if current_move_type == GlobalEnums.movement_type.sprint:
			stamina_manager.change_value(stamina_decrease_rate * delta, true)
	else:
		#decelerates the player when they stop moving
		player_body.velocity.x = move_toward(player_body.velocity.x, 0, current_speed)
		player_body.velocity.z = move_toward(player_body.velocity.z, 0, current_speed)
		
		#when the player stops moving increase stamina
		stamina_manager.change_value(stamina_regen_rate * delta, false)
	
#endregion

#region funcs move type inputs

func set_move_type_input():
	#if youre walking and press the walk toggle key start running
	if Input.is_action_just_pressed("move_walk_toggle") and current_move_type == GlobalEnums.movement_type.walk:
		set_move_type(GlobalEnums.movement_type.run)
		
	#if youre running and press the walk toggle key start walking
	elif Input.is_action_just_pressed("move_walk_toggle"):
		set_move_type(GlobalEnums.movement_type.walk)
	
	#if you press the sprint key while not sprinting, sprint
	if Input.is_action_just_pressed("move_sprint") and current_move_type != GlobalEnums.movement_type.sprint:
		set_move_type(GlobalEnums.movement_type.sprint)
	#if you press the sprint key while not running, run
	elif Input.is_action_just_pressed("move_sprint"):
		set_move_type(GlobalEnums.movement_type.run)

func set_move_type(type : GlobalEnums.movement_type) -> void:
	current_move_type = type
	print(type)
	
	#sets the speed based off the current move type
	if type == GlobalEnums.movement_type.walk:
		current_speed = walk_speed
	elif type == GlobalEnums.movement_type.run:
		current_speed = run_speed
	elif type == GlobalEnums.movement_type.sprint:
		current_speed = sprint_speed
#endregion
