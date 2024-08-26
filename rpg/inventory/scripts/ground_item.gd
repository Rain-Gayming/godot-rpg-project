extends Node

@export var item : Inventory_Item
@export var is_being_looked_at : bool

func _process(delta: float) -> void:
	if is_being_looked_at: 
		if Input.is_action_just_pressed("player_interact"):
			add_to_inventory()

func add_to_inventory():
	print("adding")
	SignalManager.emit_add_to_player_signal(item)
	
	#destroy the node
	get_parent().queue_free()
