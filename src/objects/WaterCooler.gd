extends Interactable
class_name WaterCooler


export var water_left := 100


func _process(delta: float) -> void:
	if player_in_range and player != null and player.interact:
		print("player interacting with watercooler")
		player.interact = false
