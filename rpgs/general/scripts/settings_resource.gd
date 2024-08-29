class_name SettingsSave
extends Resource

@export_group("display")
@export var resolution : int
@export var window : int
@export var fps_cap : int

@export_group("quality")
@export var anti_aliasing : int
@export var texture_quality : int

@export_group("audio")
@export var master : float
@export var music : float 
@export var voice : float
@export var effects : float
