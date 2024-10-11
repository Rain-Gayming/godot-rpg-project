extends Node
class_name AbilityManager

@export_group("current abilities")
@export var has_double_jump: bool
@export var has_dash: bool
@export_range(1, 5) var total_dashes: int