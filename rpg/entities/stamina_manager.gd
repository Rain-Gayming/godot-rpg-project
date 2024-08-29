class_name stamina_manager
extends Node

@export var stamina : float_change
@export var bar : float_bar

func change_value(change : float, is_negative : bool):
	stamina.change_value(change, is_negative)
	
	bar.update_bar(stamina.current_value)
