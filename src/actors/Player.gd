extends Actor
class_name Player

var interact: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interact = true
	if event.is_action_released("interact"):
		interact = false
		

# parents physics_process called before
func _physics_process(delta: float) -> void:
	var direction := get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	$AnimatedSprite.flip_h = _velocity.x < 0
	_velocity = move_and_slide(_velocity)


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)


# pure fn -> doesnt modify vars just takes in vars and returns new var
func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	) -> Vector2:
	var out := linear_velocity
	out.x = speed.x * direction.x
	out.y = speed.y * direction.y
	return out
	

func die() -> void:
	PlayerData.deaths += 1
	queue_free()