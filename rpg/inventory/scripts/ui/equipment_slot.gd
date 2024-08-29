class_name EquipmentSlot
extends ItemSlot

@export_group("references")
@export var slot_type : GlobalEnums.equip_type
@export var parent_entity : ContainerEntityArea
@export var is_two_handed : bool

func _process(delta: float) -> void:
	if is_hovered:
		if Input.is_action_just_pressed("mouse_left_click"):
			if ItemDrag.slot_selected != null:
				ItemDrag.use_item(parent_entity, slot_type, is_two_handed)
			else:
				ItemDrag.pick_slot(self)

func _on_mouse_entered() -> void:
	is_hovered = true

func _on_mouse_exited() -> void:
	is_hovered = false 
