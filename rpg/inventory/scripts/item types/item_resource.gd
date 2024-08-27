class_name Item
extends Resource

@export_group("basic information") 
@export var item_name : String
@export var item_icon : Texture2D
@export var can_stack : bool
@export var item_type : GlobalEnums.item_type

@export_group("usage info")
@export var can_be_used : bool
@export var destroy_on_use : bool

func use(entity : EntityManager, container : ItemContainer):
	if can_be_used:
		if destroy_on_use:
			var remove_item = Inventory_Item.new()
			remove_item.amount = 1
			remove_item.item = self
			
			container.remove_item(remove_item)
