extends Node

@export var item : Inventory_Item

func add_to_inventory():
	print("adding")
	SignalManager.emit_add_to_player_signal(item)
	
	#destroy the node
	queue_free()
