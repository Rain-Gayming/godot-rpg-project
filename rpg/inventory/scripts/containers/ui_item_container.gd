class_name UIItemContainer
extends Node

@export_group("ui")
@export var item_location : GridContainer
@export var item_slot : PackedScene
@export var inventory_ui : InventoryUI 
@export var parent_ui : ItemContainer
@export var existing_slots : Array[Control]
var saved_items : Array[Inventory_Item]

func _ready() -> void:
	parent_ui = inventory_ui.item_container
	SignalManager.open_container_signal.connect(open_container)

func open_container(container : ItemContainer):
	open_container_ui(container)

func unload_container():

	for slot in existing_slots:
		slot.queue_free()
		existing_slots.remove_at(existing_slots.find(slot))

func open_container_ui(container : ItemContainer):
	unload_container()
	update_container_ui(container.items, container)


func update_container_ui(items : Array[Inventory_Item], container : ItemContainer):
	print("this is called")
	saved_items.clear()
	saved_items = items
	
	for item in saved_items:
		container.items.remove_at(container.items.find(item))
		container.add_new_item(item)
	

func add_new_item(new_item : Inventory_Item):
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

	existing_slots.append(new_slot)

func add_existing_item(new_amount : int, items_location : int, item : Inventory_Item):
	item.amount += new_amount
	existing_slots[items_location].item_in_slot = item
	existing_slots[items_location].update_slot()

	return item

func remove_item(amount_to_remove : int, items_location : int, item : Inventory_Item):
	if item.amount > 0:
		inventory_ui.container.existing_slots[items_location].item_in_slot = item
		inventory_ui.container.existing_slots[items_location].update_slot()
	else:
		inventory_ui.container.existing_slots[items_location].queue_free()
		inventory_ui.container.existing_slots.remove_at(items_location)
