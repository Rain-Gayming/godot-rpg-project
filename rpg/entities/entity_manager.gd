class_name EntityManager
extends Node

@export var equipment_manager : EquipmentManager

@export var inventory_ui : InventoryUI

func _ready() -> void:
	if inventory_ui.entity_area.entity == null:
		inventory_ui.entity_area.entity = self
		print("setting entity manager to " + str(self))
