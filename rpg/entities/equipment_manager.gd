class_name EquipmentManager
extends Node

@export_group("equipment items")
@export var left_weapon : Inventory_Item
@export var shield : Inventory_Item
@export var helmet : Inventory_Item
@export var chestplate : Inventory_Item
@export var left_shoulder : Inventory_Item
@export var right_shoulder : Inventory_Item
@export var left_glove : Inventory_Item
@export var right_glove : Inventory_Item
@export var legs : Inventory_Item
@export var boots : Inventory_Item

func equip_item(item_to_equip : Inventory_Item, slot : GlobalEnums.equip_type, is_two_handed : bool):
	var equipment_item = item_to_equip.item
	
	print("equipping " + equipment_item.item_name)
	
	if slot == equipment_item.equip_slot:
		match equipment_item.equip_slot:
			GlobalEnums.equip_type.weapon:
				if is_two_handed:
					#set two handed 
					pass
				else:
					left_weapon = item_to_equip
			GlobalEnums.equip_type.shield:
				shield = item_to_equip
			GlobalEnums.equip_type.helmet:
				helmet = item_to_equip
			GlobalEnums.equip_type.chestplate:
				chestplate = item_to_equip
			GlobalEnums.equip_type.left_shoulder:
				left_shoulder = item_to_equip
			GlobalEnums.equip_type.right_shoulder:
				right_shoulder = item_to_equip
			GlobalEnums.equip_type.left_glove:
				left_glove = item_to_equip
			GlobalEnums.equip_type.right_glove:
				right_glove = item_to_equip
			GlobalEnums.equip_type.legs:
				legs = item_to_equip
			GlobalEnums.equip_type.boots:
				boots = item_to_equip
	else:
		print("slot does not match item")
