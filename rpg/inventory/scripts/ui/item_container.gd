class_name ItemContainer
extends Node

@export_group("save")
@export var save_path : String
@export var save_items : Array[ItemSave]
@export var save_dictionary : Dictionary

@export_group("inventory")
@export var is_player : bool
@export var items : Array[Inventory_Item]
@export var item_res : Array[Item]
@export var debug_item : Inventory_Item

@export_group("ui")
@export var item_location : GridContainer
@export var item_slot : PackedScene
@export var inventory_ui : InventoryUI
@export var existing_slots : Array[Control]

func _ready() -> void:
	#if the container is the player's save to the inventory
	#otherwise save to a containers path
	if not is_player:
		DirAccess.make_dir_absolute("user://containers")
		save_path = "user://containers/container_" + inventory_ui.get_parent().name
	else:
		DirAccess.make_dir_absolute("user://player")
		save_path = "user://player/player_inventory"
		SignalManager.add_item_to_player_signal.connect(add_item)
	
	
	load_inventory()

func add_item(item_to_add : Inventory_Item):
	#print("adding item")
	if item_res.has(item_to_add.item):
		add_existing_item(item_to_add)
	else:
		add_new_item(item_to_add)
	
	save_container()
	

func add_new_item(item_to_add : Inventory_Item):
	
	var new_amount = item_to_add.amount
	var new_item_ref = item_to_add.item
	var new_item = Inventory_Item.new()
	
	print(new_amount)
	
	new_item.amount = new_amount
	new_item.item = new_item_ref
	
	#spawn the new slot
	var new_slot = item_slot.instantiate()
	#attach it to the grid
	item_location.add_child(new_slot)
	#set its item
	new_slot.item_in_slot = new_item
	#set the parent container
	new_slot.parent_container = self
	#update its display
	new_slot.update_slot()
	
	#add the items to their lists
	items.append(new_item)
	item_res.append(new_item.item)
	existing_slots.append(new_slot)
	
	#print("adding item" + item_to_add.item.item_name + " at " + str(item_location) + " of amount " + str(item_to_add.amount))
	
 
func add_existing_item(item_to_add : Inventory_Item):
	var items_location = items.find(item_to_add)
	
	var new_amount =  item_to_add.amount
	
	items[items_location].amount += new_amount
	existing_slots[items_location].item_in_slot = items[items_location]
	existing_slots[items_location].update_slot()

func remove_item(item_to_remove : Inventory_Item):
	var items_location = items.find(item_to_remove)
		
	#print("removing item " + item_to_remove.item.item_name + " at " + str(item_location) + " of amount " + str(item_to_remove.amount) + " on container " + str(self))
	
	items[items_location].amount -= item_to_remove.amount
	if items[items_location].amount > 0:
		existing_slots[items_location].item_in_slot = items[items_location]
		existing_slots[items_location].update_slot()
	else:
		existing_slots[items_location].queue_free()
		existing_slots.remove_at(items_location)
		item_res.remove_at(items_location)
		items.remove_at(items_location)


func save_container():
	#resets the array
	save_dictionary.clear()
	
	#loops through all the players items
	for item in items:
		save_dictionary[item.item.item_name] = item.amount
	
	#send the array to a string
	var json_string = JSON.stringify(save_dictionary, "\t")
	
	# open the file
	var file_access = FileAccess.open(save_path, FileAccess.WRITE)
	
	#if an error happens stop
	if not file_access:
		print("An error happened while saving data: ", FileAccess.get_open_error())
		return
	#otherwise continue
	file_access.store_line(json_string)
	file_access.close()
	
	#clear again to save memory
	save_dictionary.clear()

func load_inventory():
	save_dictionary = get_inventory_data()
	
	for item in ItemsList.items:
		if save_dictionary.has(item.item_name):
			
			var new_item = Inventory_Item.new()
			new_item.item = item
			
			print(item.item_name)
			new_item.amount = save_dictionary[item.item_name]
			add_item(new_item)
	#clear again to save memory
	save_dictionary.clear()


func get_inventory_data():
	var file_access = FileAccess.get_file_as_string(save_path)
	var json_data = JSON.parse_string(file_access)
	
	
	
	if json_data is Dictionary:
		return json_data
