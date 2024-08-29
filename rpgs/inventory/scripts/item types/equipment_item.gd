class_name EquipmentItem
extends Item

@export_group("equipment item")
@export var equip_slot : GlobalEnums.equip_type

func _init() -> void:
	is_equipable = true
