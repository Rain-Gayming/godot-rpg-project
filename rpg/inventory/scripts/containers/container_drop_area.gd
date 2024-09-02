extends Node

@export var is_hovered : bool
@export var parent_container : ItemContainer
@export var inventory_ui : InventoryUI

func _ready() -> void:
	parent_container = inventory_ui.item_container

func _process(delta: float) -> void:
	if is_hovered:
		if Input.is_action_just_pressed("mouse_left_click"):
			ItemDrag.swap_to_container(parent_container)

func _on_mouse_entered() -> void:
	is_hovered = true


func _on_mouse_exited() -> void:
	is_hovered = false
