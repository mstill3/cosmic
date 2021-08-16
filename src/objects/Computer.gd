extends Interactable
class_name Computer


#export (String, FILE) var next_scene_path := ""
signal boot_pc

onready var anim_sprite: AnimatedSprite = $AnimatedSprite

var is_on: bool = false


func _process(delta: float) -> void:
	if player_in_range and player != null and player.interact:
#		print("player interacting with computer")
		is_on = not is_on
		if is_on:
			anim_sprite.animation = "boot_up"
			anim_sprite.playing = true
		else:
			anim_sprite.animation = "shut_down"
			anim_sprite.playing = true
		player.interact = false


func _on_AnimatedSprite_animation_finished() -> void:
	if is_on:
		emit_signal("boot_pc")

func turn_off() -> void:
	is_on = false
	anim_sprite.animation = "shut_down"
	anim_sprite.playing = true
			

#func _get_configuration_warning() -> String:
#	if not next_scene_path:
#		return "Need to set next scene path"
#	else:
##		return ""
#
#
#func _on_Terminal_disconnect() -> void:
#	is_on = false
#	anim_sprite.animation = "shut_down"
#	anim_sprite.playing = true
