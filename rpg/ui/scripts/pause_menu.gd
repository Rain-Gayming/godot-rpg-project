extends Node

@export_group("references")
@export var menu : Control
@export var buttons : Control
@export var options_menu : Control

func _ready() -> void:
	menu.visible = false
	SignalManager.pause_signal.connect(pause)

func pause():
	menu.visible = !menu.visible
	buttons.visible = true
	options_menu.visible = false

func open_options():
	buttons.visible = false
	options_menu.visible = true
