class_name ItemSlot
extends Node

@export var item_in_slot : Inventory_Item
@export var is_hovered : bool
@export var parent_container : ItemContainer
@export var is_equipment_slot : bool

@export_group("ui")
@export var can_be_searched : bool = true 
@export var item_icon : TextureRect
@export var amount_text : Label

func _ready() -> void:
	pass
	#update_slot()

func _process(delta: float) -> void:
	if is_hovered:
		if Input.is_action_just_pressed("mouse_left_click"):
			slot_clicked()
		

func slot_clicked():
	ItemDrag.pick_slot(self)

func update_slot():
	if item_in_slot != null:
		item_icon.texture = item_in_slot.item.item_icon
		
		if item_in_slot.amount > 1:
			amount_text.visible = true
		else:
			amount_text.visible = false
		
		amount_text.text = str(item_in_slot.amount)
		print(item_in_slot.amount)
	else:
		amount_text.visible = false
		item_icon.texture = null


func _on_mouse_entered() -> void:
	is_hovered = true


func _on_mouse_exited() -> void:
	is_hovered = false
