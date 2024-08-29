extends Node

func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("item"):
		area.is_being_looked_at = true
 
