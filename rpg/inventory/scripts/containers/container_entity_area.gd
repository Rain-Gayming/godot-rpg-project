class_name ContainerEntityArea
extends Node

@export var is_hovered : bool
@export var entity : EntityManager
@export var parent_container : ItemContainer

func _process(delta: float) -> void:
	if is_hovered:
		if Input.is_action_just_pressed("mouse_left_click"):
			ItemDrag.use_item(self, GlobalEnums.equip_type.boots, false)

func _on_mouse_entered() -> void:
	is_hovered = true

func _on_mouse_exited() -> void:
	is_hovered = false 
