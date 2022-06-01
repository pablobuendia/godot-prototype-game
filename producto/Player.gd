extends RigidBody2D

func _ready():
	gravity_scale = 5
func _process(delta):
	if Input.is_action_pressed("move_up"):
		linear_velocity = Vector2(0,-100)
	if Input.is_action_pressed("move_right"):
		linear_velocity = Vector2(100,0)
	if Input.is_action_pressed("move_down"):
		linear_velocity = Vector2(0,100)
	if Input.is_action_pressed("move_left"):
		linear_velocity = Vector2(-100,0)
	
	if linear_velocity.length() > 0:
		$Animacion.play()
	else:
		$Animacion.stop()
