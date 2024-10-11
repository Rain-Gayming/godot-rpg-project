extends Node

@export var speed: float
@export var damage: float

func hit(area:Area2D) -> void:
	area.health_manager.change_health(damage, true)
