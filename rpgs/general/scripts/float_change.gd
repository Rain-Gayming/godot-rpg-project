class_name float_change
extends Node

@export var current_value : float
@export var max_value : float
@export var min_value : float = 0

func change_value(change_amount : float, is_subtractive : bool):
	if is_subtractive:
		current_value -= change_amount
	else:
		current_value += change_amount
	
	current_value = clampf(current_value, min_value, max_value)
