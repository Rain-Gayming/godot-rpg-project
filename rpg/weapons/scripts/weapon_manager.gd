class_name WeaponManager
extends Node

@export_group("references")
@export var animation_player : AnimationPlayer
@export var hitbox : Area3D
@export var stats : WeaponItem

@export_group("attacking")
@export var attack_time : float
@export var times_attacked : int 


func _ready() -> void:
	times_attacked = 1

func _process(delta: float) -> void:
	if attack_time > 0:
		attack_time -= delta

func attack():
	if attack_time <= 0:
		
		#enable the hitbox
		hitbox.monitoring = true
		print(hitbox.monitoring)
		
		#sets the animation name
		var attack_name = "attack_" + str(times_attacked)
		
		#play the animation
		animation_player.play(attack_name)
		#set attack time and times attacked
		attack_time = stats.attack_speed
		times_attacked += 1
				
		#reset times attacked to 0
		if times_attacked > 3:
			times_attacked = 1

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_1" or anim_name == "attack_2" or anim_name == "attack_3":
		animation_player.play("idle")
		hitbox.monitoring = false
		print(hitbox.monitoring)


func _on_a_hitbox_area_entered(area: Area3D) -> void:
	if area. is_in_group("hitable"):
		print("hitting for " + str(stats.damage))
		area.get_node("health_manager").change_health(stats.damage, true)
	else:
		print(area.get_parent().name + " is not hitable")
