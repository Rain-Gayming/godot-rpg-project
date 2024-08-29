class_name EquipmentManager
extends Node

@export_group("references")
@export var combat_manager : CombatManager
@export var inventory_ui : InventoryUI
@export var left_hand_slot : Node3D
@export var left_hand_equip : Node3D

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

func equip_item(item_to_equip : Inventory_Item, slot : GlobalEnums.equip_type, is_two_handed : bool, container : ItemContainer):
	var equipment_item = item_to_equip.item
	
	print("equipping " + equipment_item.item_name)
	
	if slot == equipment_item.equip_slot:
		
		var new_amount = item_to_equip.amount
		var new_item_ref = item_to_equip.item
		var new_item = Inventory_Item.new()
		new_item.amount = new_amount
		new_item.item = new_item_ref
		
		match equipment_item.equip_slot:
			GlobalEnums.equip_type.weapon:
				if is_two_handed:
					#set two handed 
					pass
				else:
					left_weapon = new_item
					
					
					#if a weapon exists it destroys it
					if left_hand_equip != null:
						left_hand_equip.queue_free()
						#remove the item from the inventory
						inventory_ui.container.add_item(left_weapon)
					
					#spawn the weapon
					var weapon_scene = load(left_weapon.item.weapon_scene)
					var weapon = weapon_scene.instantiate()
					
					#set the weapons position to the hand
					left_hand_slot.add_child(weapon)
					left_hand_equip = weapon
					
					#set the current weapon on the combat manager
					combat_manager.current_weapon = weapon
					combat_manager.current_weapon.stats = item_to_equip.item
					
					#set slots information
					inventory_ui.left_weapon_slot.item_in_slot = item_to_equip
					inventory_ui.left_weapon_slot.update_slot() 
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
		
		#remove the item from the inventory
		if container == null:
			inventory_ui.container.remove_item(item_to_equip)
		else:
			container.remove_item(item_to_equip)
	else:
		print("slot does not match item")

func unequip(slot : GlobalEnums.equip_type, container : ItemContainer):
	print("unequipping")
	
	match slot:
		GlobalEnums.equip_type.weapon:
			#if a weapon exists it destroys it
			if left_hand_equip != null:
				var new_amount = left_weapon.amount
				var new_item_ref = left_weapon.item
				var new_item = Inventory_Item.new()
				
				print(new_amount)
				
				new_item.amount = new_amount
				new_item.item = new_item_ref
				
				container.add_item(new_item)
				#delete the item
				left_hand_equip.queue_free()
				
				#set the current weapon on the combat manager
				combat_manager.current_weapon = null
				
				#set slots information
				inventory_ui.left_weapon_slot.item_in_slot = null
				inventory_ui.left_weapon_slot.update_slot() 
