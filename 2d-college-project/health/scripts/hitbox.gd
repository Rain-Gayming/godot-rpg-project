extends Node

@export var is_player: bool
@export var health_manager: HealthManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func hit(area:Area2D) -> void:
	#for the player hitting into enemies
	if is_player:
		health_manager.change_health(1, true)
