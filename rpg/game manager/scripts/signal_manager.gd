extends Node

signal pause_signal

func emit_pause_signal():
	pause_signal.emit()
