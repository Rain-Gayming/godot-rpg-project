extends Node3D

@export_group("references")
@export var neck : Node3D
@export var is_paused : bool
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	SignalManager.pause_signal.connect(pause)
	
func pause():
	is_paused = !is_paused

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and !is_paused:
		neck.rotate_y(-event.relative.x * SettingsManager.mouse_sensitivity_y)
		self.rotate_x(-event.relative.y * SettingsManager.mouse_sensitivity_x)
		self.rotation.x = clamp(self.rotation.x, deg_to_rad(-85), deg_to_rad(85))
