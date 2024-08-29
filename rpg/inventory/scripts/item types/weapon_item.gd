class_name WeaponItem
extends EquipmentItem

@export_group("weapon info")
@export var attack_speed : float
@export var damage : int
@export_file("*.tscn") var weapon_scene 
@export var is_two_handed : bool
