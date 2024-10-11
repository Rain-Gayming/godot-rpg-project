extends Node

@export_group("references")
@export var edge_check: EdgeCheck
@export var character_body: CharacterBody2D

@export_group("speed")
@export var move_speed: float
@export var moving_left: bool

func _process(_delta):
	if not moving_left:
		character_body.velocity.x = move_speed
	else:
		character_body.velocity.x = -move_speed

	if edge_check.is_near_edge:
		edge_check.ground_ray.position.x = -edge_check.ground_ray.position.x
		moving_left = !moving_left
		edge_check.start_timer()
		

	character_body.move_and_slide()
