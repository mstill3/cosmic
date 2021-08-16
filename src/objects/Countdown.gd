extends StaticBody2D
class_name Countdown


export var max_time = 10 * 60
signal move_meteor
signal times_up
var last_time = -1


func _ready() -> void:
	$Label.text = "00:00"
	$Timer.start(max_time)

func _process(delta: float) -> void:
	$Label.text = str(int($Timer.time_left / 60)).pad_zeros(2) + ":" + str(int(int($Timer.time_left) % 60)).pad_zeros(2)
	if int($Timer.time_left) % 5 == 0 and int($Timer.time_left) != last_time:
		print("aa")
		last_time = int($Timer.time_left)
		emit_signal("move_meteor")

func _on_Timer_timeout() -> void:
	print("You lost")
	emit_signal("times_up")
