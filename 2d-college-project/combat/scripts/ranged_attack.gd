extends Node

@export_group("attack info")
@export var projectile: PackedScene
@export var attack_speed: float
@export var attack_timer: float
@export var damage: float
@export var projectile_speed: float
@export var sound: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("combat_attack"):
		var new_projectile = projectile.instantiate()
		new_projectile.speed = projectile_speed
		new_projectile.damage = damage
		