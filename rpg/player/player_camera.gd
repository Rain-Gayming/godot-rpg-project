extends Node3D

@export_group("references")
@export var neck : Node3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		neck.rotate_y(-event.relative.x * SettingsManager.mouse_sensitivity_y)
		self.rotate_x(-event.relative.y * SettingsManager.mouse_sensitivity_x)
		self.rotation.x = clamp(self.rotation.x, deg_to_rad(-85), deg_to_rad(85))
		print("Getting Input")
