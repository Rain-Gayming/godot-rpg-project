extends Node

@export_group("references")
@export var character_body: CharacterBody2D

@export_group("speed")
@export var speed: float
@export var speed_mult: float
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity") 
@export var jump_height: float
@export var jump_multiplier: float
@export var can_double_jump: bool

func _ready():
	character_body = get_parent().get_parent()

func _physics_process(delta: float):
	character_body.move_and_slide()
	get_input()
	jump(delta)

	if not character_body.is_on_floor():
		character_body.velocity.y += gravity * delta

	


func get_input():
	var horizontal = Input.get_axis("move_left", "move_right");
	character_body.velocity.x = horizontal * speed
	#				character_body.velocity.y = jump_height	



func jump(delta: float) -> void:	
	
	#gravity
	if not character_body.is_on_floor():
		character_body.velocity.y += gravity * delta

	#jumping
	if Input.is_action_just_pressed("move_jump") and character_body.is_on_floor():
		character_body.velocity.y -= jump_height	
		print(character_body.velocity.y)
