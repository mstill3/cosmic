extends Interactable
class_name Computer


export var minigame: PackedScene

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
#	if is_on:
	print(is_on)
