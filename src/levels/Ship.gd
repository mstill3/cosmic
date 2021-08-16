extends Node2D


func _ready() -> void:
	pass # Replace with function body.


func _on_Computer_boot_pc() -> void:
	get_tree().paused = true
	$Terminal.visible = true


func _on_Terminal_disconnect() -> void:
	get_tree().paused = false
	$Terminal.visible = false
	$YSort/Computer.turn_off()


func _on_Terminal_fire_laser() -> void:
	get_tree().paused = true
	$WinLoseScreen/WinLose.text = "Congratulations!\nYou win"
	$Countdown/Timer.paused = true
	$WinLoseScreen.visible = true


func _on_Countdown_move_meteor() -> void:
	$Window/MeteorSprite.position.x += 1
	print($Window/MeteorSprite.position.x)


func _on_Countdown_times_up() -> void:
	get_tree().paused = true
	$WinLoseScreen/WinLose.text = "You lose"
	$WinLoseScreen.visible = true
	
