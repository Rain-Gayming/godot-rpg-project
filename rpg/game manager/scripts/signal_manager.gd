extends Node

signal pause_signal()
signal stop_game()
signal add_item_to_player_signal(item)

signal open_container_signal(container)

func emit_pause_signal():
	pause_signal.emit()

func emit_stop_game_signal():
	stop_game.emit()

func emit_add_to_player_signal(item : Inventory_Item):
	add_item_to_player_signal.emit(item)

func emit_open_container_signal(container : ItemContainer):
	open_container_signal.emit(container)
	