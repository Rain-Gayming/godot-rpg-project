extends Node

@export_group("references")
@export var character_body: CharacterBody2D

@export_group("speed")
@export var speed: float
@export var speed_mult: float


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

func _physics_process(delta: float):
	character_body.move_and_slide()
	get_input()
	jump(delta)	


func get_input():
	var horizontal = Input.get_axis("move_left", "move_right");
	character_body.velocity.x = horizontal * speed



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
		print("can jump due to koyote time")
	elif grounded_timer > grounded_time or is_jumping:
		can_jump = false

	#jumping
	if Input.is_action_just_pressed("move_jump") and can_jump:
		character_body.velocity.y = -jump_height * jump_multiplier	
		is_jumping = true
		can_jump = false
		print(character_body.velocity.y)
