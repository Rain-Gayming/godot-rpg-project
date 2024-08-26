extends Node

@export var is_paused : bool
@export var is_paused_menu : bool
@export var menu : Control
@export var container : ItemContainer
@export var filter : TextEdit

func _ready() -> void:
	SignalManager.pause_signal.connect(pause)
	toggle_inventory_value(false)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu_inventory"):
		if not is_paused_menu:
			toggle_inventory()


func pause():
	is_paused = !is_paused
	
	toggle_inventory_value(false)

func toggle_inventory():
	menu.visible = !menu.visible
	GameManager.stop_game()
	
func toggle_inventory_value(is_on : bool):
	menu.visible = is_on


func item_filter_text_changed() -> void:
	#loop through all items in the container
	#check if the items names match
	for item in container.item_res:
		#gets the location of the item
		var item_location = container.item_res.find(item) 
		
		for char in item.item_name:
			if filter.text.contains(char):
				if container.existing_slots[item_location].can_be_searched:
					container.existing_slots[item_location].visible = true
			else:
				if container.existing_slots[item_location].can_be_searched:
					container.existing_slots[item_location].visible = false
	
	if filter.text == "":
		for slot in container.existing_slots:
			slot.visible = true
