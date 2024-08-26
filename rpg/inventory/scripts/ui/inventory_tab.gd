extends Node

@export var container : ItemContainer
@export var item_type : GlobalEnums.item_type
@export var is_all : bool

func swap_tab():
	if not is_all:
		#loop through all items
		for item in container.item_res:
			#find items location
			var item_location = container.item_res.find(item)
			
			#if its type matches the tab show it 
			#otherwise dont
			if item.item_type != item_type: 
				container.existing_slots[item_location].visible = false
				container.existing_slots[item_location].can_be_searched = false
			else:
				container.existing_slots[item_location].visible = true
				container.existing_slots[item_location].can_be_searched = true
	else:
		for slot in container.existing_slots:
			slot.visible = true
			slot.can_be_searched = true
