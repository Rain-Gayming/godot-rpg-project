extends Control

@export var icon : TextureRect

@export var slot_selected : ItemSlot

func _process(delta: float) -> void:
	position = get_global_mouse_position()

func pick_slot(item_slot : ItemSlot):
	if not slot_selected:
		icon.visible = true
		icon.texture = item_slot.item_in_slot.item.item_icon
		slot_selected = item_slot
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
		#adds it to the target container
		container.add_item(new_item(slot_selected.item_in_slot))
		#removes the item from the container
		slot_selected.parent_container.remove_item(slot_selected.item_in_slot)
		
		#reset values
		slot_selected = null
		icon.visible = false
		

func use_item(to_use_on : ContainerEntityArea):
	if slot_selected != null:
		#use the item
		print(to_use_on.entity)
		slot_selected.item_in_slot.item.use(to_use_on.entity, to_use_on.parent_container)
		
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
