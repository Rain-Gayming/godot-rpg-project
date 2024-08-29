class_name InventoryUI
extends Node

@export_group("equipment slots")
@export var left_weapon_slot : EquipmentSlot

@export_group("ui")
@export var container : ItemContainer
@export var filter : TextEdit
@export var menu : Control

@export_group("references for children")
@export var entity : EntityManager
@export var entity_area : ContainerEntityArea


func toggle_inventory():
	menu.visible = !menu.visible
	GameManager.stop_game()
	
func toggle_inventory_value(is_on : bool):
	menu.visible = is_on


func item_filter_text_changed() -> void:
	#loop through all items in the container
	#check if the items names match
	for item in container.item_res:
		#gets the location of the item
		var item_location = container.item_res.find(item) 
		
		for char in item.item_name:
			if filter.text.contains(char):
				if container.existing_slots[item_location].can_be_searched:
					container.existing_slots[item_location].visible = true
			else:
				if container.existing_slots[item_location].can_be_searched:
					container.existing_slots[item_location].visible = false
	
	if filter.text == "":
		for slot in container.existing_slots:
			slot.visible = true
