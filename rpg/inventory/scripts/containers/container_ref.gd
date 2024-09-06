extends Node

@export var container : ItemContainer

@export var is_being_looked_at : bool

func _process(_delta: float) -> void:
	if is_being_looked_at: 
		if Input.is_action_just_pressed("player_interact"):
			SignalManager.emit_open_container_signal(container)
			is_being_looked_at = false
			return