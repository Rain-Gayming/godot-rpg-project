class_name WeaponItem
extends Item

@export_group("weapon info")
@export var attack_speed : float
@export_file("*.tscn") var weapon_scene 

func use(entity : EntityManager, container : ItemContainer):
	var equipment_item = Inventory_Item.new()
	equipment_item.amount = 1
	equipment_item.item = self
	
	entity.equipment_manager.left_weapon = equipment_item
