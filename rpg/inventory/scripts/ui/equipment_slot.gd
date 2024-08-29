class_name EquipmentSlot
extends Node

@export_group("references")
@export var item : Inventory_Item
@export var item_icon : TextureRect
@export var slot_type : GlobalEnums.equip_type
@export var parent_entity : ContainerEntityArea
@export var is_two_handed : bool

@export_group("ui stuff")
@export var is_hovered : bool

func _process(delta: float) -> void:
	if is_hovered:
		if Input.is_action_just_pressed("mouse_left_click"):
			ItemDrag.use_item(parent_entity, slot_type, is_two_handed)

func _on_mouse_entered() -> void:
	is_hovered = true

func _on_mouse_exited() -> void:
	is_hovered = false 

func update_slot():
	if item.item != null:
		item_icon.visible = true
		item_icon.texture = item.item.item_icon
	else:
		item_icon.visible = false
