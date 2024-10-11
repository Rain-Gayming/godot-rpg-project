extends Node
class_name EdgeCheck

@export_group("references")
@export var ground_ray: RayCast2D

@export_group("edges")
@export var is_near_edge: bool
@export var check_timer: float
@export var check_time: float

func _process(delta):
	if check_timer <= 0:
		if ground_ray.is_colliding():
			is_near_edge = false
		else:
			is_near_edge = true
	else:
		check_timer -= delta
		
func start_timer():
	if check_timer <= 0:
		check_timer = check_time
		is_near_edge = false