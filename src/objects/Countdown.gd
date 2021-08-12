extends StaticBody2D
class_name Countdown


export var max_time = 15 * 60


func _ready() -> void:
	$Label.text = "00:00"
	$Timer.start(max_time)

func _process(delta: float) -> void:
	$Label.text = str(int($Timer.time_left / 60)).pad_zeros(2) + ":" + str(int(int($Timer.time_left) % 60)).pad_zeros(2)
