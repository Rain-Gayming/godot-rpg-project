extends Node

@export_group("references")
@export var character_body: CharacterBody2D
@export var ability_manager: AbilityManager
@export var to_flip: Node2D

@export_group("speed")
@export var speed: float
@export var speed_mult: float

@export_group("dash")
@export var dash_speed: float
@export var times_dashed: int
@export var dash_regen_time: float
@export var dash_regen_timer: float


@export_group("jumping")
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity") 
@export var jump_height: float
@export var jump_multiplier: float
@export var can_double_jump: bool
@export var grounded_time: float
@export var grounded_timer: float
@export var can_jump: bool
@export var is_jumping: bool

func _ready():
	character_body = get_parent().get_parent()

func _process(delta):
	character_body.move_and_slide()
	get_input(delta)
	jump(delta)	


func get_input(delta: float):
	var horizontal = Input.get_axis("move_left", "move_right");
	character_body.velocity.x = horizontal * speed

	#flips the player
	if horizontal > 0:
		to_flip.transform.scaled(Vector2(-1, 1))
	else:
		to_flip.transform.scaled(Vector2(-1, 1))
		pass
	#dash the player
	if Input.is_action_just_pressed("ability_dash"):
		dash(horizontal, delta)
	else:
		if times_dashed < 5 and times_dashed > 1:
			dash_regen_timer += delta
			if dash_regen_timer >= dash_regen_time:
				times_dashed -= 1
				dash_regen_timer = 0



func dash(horizontal: float, delta : float):
	if ability_manager.has_dash and times_dashed < ability_manager.total_dashes:
		character_body.velocity.x = horizontal * dash_speed * delta
		times_dashed += 1

func jump(delta: float) -> void:	
	
	#gravity	
	if not character_body.is_on_floor():
		character_body.velocity.y += gravity * delta
		if not is_jumping:
			grounded_timer += delta
	else:
		can_jump = true;
		is_jumping = false
		grounded_timer = 0

	#checks if the player was recently grounded
	#if so it allows them to still jump
	if grounded_timer < grounded_time and not is_jumping and !character_body.is_on_floor():
		can_jump = true
	elif grounded_timer > grounded_time or is_jumping:
		can_jump = false

	#jumping
	if Input.is_action_just_pressed("move_jump") and (can_jump or can_double_jump):
		character_body.velocity.y = -jump_height * jump_multiplier
		is_jumping = true
		can_jump = false
		
		if ability_manager.has_double_jump:
			if can_double_jump:
				can_double_jump = false
			else: 
				can_double_jump = true
