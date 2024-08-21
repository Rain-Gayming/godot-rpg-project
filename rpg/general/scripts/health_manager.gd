class_name health_manager
extends Node

@export var health : float_change

func change_health(change : float, is_negative : bool):
	health.change_value(change, is_negative)
	
	if health.current_value <= 0:
		die()

func die():
	print("entity has died")
