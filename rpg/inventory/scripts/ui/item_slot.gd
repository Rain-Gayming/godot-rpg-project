extends Node

@export var item_in_slot : Inventory_Item

@export_group("ui")
@export var can_be_searched : bool = true 
@export var item_icon : TextureRect
@export var amount_text : Label

func _ready() -> void:
	pass
	#update_slot()

func update_slot():
	item_icon.texture = item_in_slot.item.item_icon
	
	if item_in_slot.amount > 1:
		amount_text.visible = true
	else:
		amount_text.visible = false
	
	amount_text.text = str(item_in_slot.amount)
