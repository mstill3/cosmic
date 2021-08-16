extends Interactable
class_name WaterCooler


export var water_anim := 1


func _process(delta: float) -> void:
	if player_in_range and player != null and player.interact:
#		print("player interacting with watercooler")
		water_anim = clamp(water_anim + 1, 0, 10)
		$AnimatedSprite.animation = "tank_" + str(water_anim)
		player.interact = false
