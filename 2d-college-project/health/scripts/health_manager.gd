extends Node
class_name HealthManager

@export_group("health")
@export var current_health: float
@export var max_health: float

func _ready():
	current_health = max_health

func change_health(change_amount: float, is_damage: bool):
	if is_damage:
		current_health -= change_amount
	else:
		current_health += change_amount
	
	if current_health <= 0:
		print("ded")