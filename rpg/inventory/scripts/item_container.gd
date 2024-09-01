class_name ItemContainer
extends Node

@export_group("save")
@export var save_path : String
@export var save_items : Array[ItemSave]
@export var save_dictionary : Dictionary

@export_group("inventory")
@export var container : UIItemContainer
@export var inventory_ui : InventoryUI
@export var is_player : bool
@export var items : Array[Inventory_Item]
@export var item_res : Array[Item]
@export var debug_item : Inventory_Item


func _ready() -> void:
	container = inventory_ui.container
	inventory_ui.item_container = self
	#if the container is the player's save to the inventory
	#otherwise save to a containers path
	if not is_player:
		DirAccess.make_dir_absolute("user://containers")
		save_path = "user://containers/container_" + name
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
	
	container.add_new_item(new_item)
	
	#add the items to their lists
	items.append(new_item)
	item_res.append(new_item.item)
	
	#print("adding item" + item_to_add.item.item_name + " at " + str(item_location) + " of amount " + str(item_to_add.amount))
	
 
func add_existing_item(item_to_add : Inventory_Item):
	var items_location = items.find(item_to_add)
	
	var new_amount =  item_to_add.amount

	items[items_location] = container.add_existing_item(new_amount, items_location, items[items_location])

func remove_item(item_to_remove : Inventory_Item):
	var items_location = items.find(item_to_remove)
		
	#print("removing item " + item_to_remove.item.item_name + " at " + str(item_location) + " of amount " + str(item_to_remove.amount) + " on container " + str(self))
	
	items[items_location].amount -= item_to_remove.amount
	container.remove_item(item_to_remove.amount, items_location, items[items_location])
	if items[items_location].amount > 0:
		pass
	else:
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
			#create the item
			var new_item = Inventory_Item.new()
			new_item.item = item
			
			#add the item
			new_item.amount = save_dictionary[item.item_name]
			add_item(new_item)
	#clear again to save memory
	save_dictionary.clear()


func get_inventory_data():
	#load the save file
	var file_access = FileAccess.get_file_as_string(save_path)
	var json_data = JSON.parse_string(file_access)	
	
	if json_data is Dictionary:
		return json_data
