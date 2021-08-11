extends StaticBody2D
class_name Computer


var player: Player = null
var player_in_range: bool = false


func _process(delta: float) -> void:
	if player_in_range and player != null and player.interact:
		print("player interacting with computer")
		player.interact = false
 

func _on_PlayerDetector_body_entered(p: Player) -> void:
	player_in_range = true
	player = p


func _on_PlayerDetector_body_exited(p: Player) -> void:
	player_in_range = false
