extends Control

@export var icon : TextureRect

@export var slot_selected : ItemSlot

func _process(delta: float) -> void:
	position = get_global_mouse_position()

func pick_slot(item_slot : ItemSlot):
	if not slot_selected:
		if item_slot.item_in_slot:
			icon.visible = true
			icon.texture = item_slot.item_in_slot.item.item_icon
			slot_selected = item_slot
		else:
			return
	else:
		#gets the container of the slot
		var container_hovered = item_slot.parent_container
		
		#removes the item from the container
		slot_selected.parent_container.remove_item(slot_selected.item_in_slot)
		
		#adds it to the target container
		container_hovered.add_item(new_item(item_slot.item_in_slot))
		
		#reset values
		slot_selected = null
		icon.visible = false
		

func swap_to_container(container : ItemContainer):
	if slot_selected != null:
		if slot_selected.parent_container != container:
			#adds it to the target container
			container.add_item(new_item(slot_selected.item_in_slot))
			#removes the item from the container
			if not slot_selected.is_equipment_slot:
				if slot_selected.parent_container.item_res.has(slot_selected.item_in_slot.item):
					slot_selected.parent_container.remove_item(slot_selected.item_in_slot)
			else:
				#this should only run if the slot is an equipment slot
				#unequip item
				unequip(container)
		else:
			if slot_selected.item_in_slot.item.is_equipable:
				unequip(container)

		#reset values
		slot_selected = null
		icon.visible = false
		

func unequip(container : ItemContainer):
	if container.inventory_ui.entity != null and container.inventory_ui.entity.equipment_manager != null:
		print("unequipping from container")
		#unequip from container
		container.inventory_ui.entity.equipment_manager.unequip(slot_selected.item_in_slot.item.equip_slot, container)
	else:
		print("unequipping from non container")
		#unequip from entity
		slot_selected.parent_container.inventory_ui.entity.equipment_manager.unequip(slot_selected.item_in_slot.item.equip_slot, slot_selected.parent_container)

func use_item(to_use_on : ContainerEntityArea, slot_type : GlobalEnums.equip_type, is_two_handed : bool):
	if slot_selected != null:
		if !slot_selected.item_in_slot.item.is_equipable:
			#use the item 
			print(to_use_on.entity)
			slot_selected.item_in_slot.item.use(to_use_on.entity, to_use_on.parent_container)
		else:
			to_use_on.entity.equipment_manager.equip_item(slot_selected.item_in_slot, slot_type, is_two_handed, slot_selected.parent_container)
		#reset values
		slot_selected = null
		icon.visible = false
	else:
		#reset values
		slot_selected = null
		icon.visible = false

func new_item(item_to_rip : Inventory_Item):
	var new_item = Inventory_Item.new()
	new_item.item = item_to_rip.item
	new_item.amount = item_to_rip.amount
	
	return new_item
