extends InventoryUI

@export var is_paused : bool
@export var is_paused_menu : bool

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
