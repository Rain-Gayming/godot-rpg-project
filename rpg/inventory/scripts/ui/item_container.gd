class_name ItemContainer
extends Node

@export var is_player : bool
@export var items : Array[Inventory_Item]
@export var item_res : Array[Item]
@export var debug_item : Inventory_Item

@export_group("ui")
@export var item_location : GridContainer
@export var item_slot : PackedScene
@export var existing_slots : Array[Control]

func _ready() -> void:
	if is_player:
		SignalManager.add_item_to_player_signal.connect(add_item)

func add_item(item_to_add : Inventory_Item):
	print("adding item")
	if item_res.has(item_to_add.item):
		add_existing_item(item_to_add)
	else:
		add_new_item(item_to_add)

func add_new_item(item_to_add : Inventory_Item):
	
	#spawn the new slot
	var new_slot = item_slot.instantiate()
	#attach it to the grid
	item_location.add_child(new_slot)
	#set its item
	new_slot.item_in_slot = item_to_add
	#update its display
	new_slot.update_slot()
	
	#add the items to their lists
	items.append(item_to_add)
	item_res.append(item_to_add.item)
	existing_slots.append(new_slot)
 
func add_existing_item(item_to_add : Inventory_Item):
	var items_location = items.find(item_to_add)
	
	items[items_location].amount += item_to_add.amount
	existing_slots[items_location].item_in_slot = items[items_location]
	existing_slots[items_location].update_slot()
	
