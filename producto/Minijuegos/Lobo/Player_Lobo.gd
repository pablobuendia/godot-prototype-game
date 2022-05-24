class_name Player_Lobo
extends Area2D

signal hit #señal para terminar el juego
signal update_vida #señal para que se actualice el valor de vida en el main
signal update_score #señal para la moneda
signal red #señal para que la red desaparezca

export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var vida

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	vida =3
	hide()
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_Player_body_entered(body):
	vida -=1
	emit_signal("update_vida")
	emit_signal("red")
	if vida==0:
		emit_signal("hit")

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func _on_Player_area_entered(area):
	emit_signal("update_score")
