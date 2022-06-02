class_name Player_Lobo
extends Area2D

signal hit #señal para el juego perdido
signal miss_vida #señal para que se actualice el valor de vida en el main
signal win_vida
signal update_score #señal para la moneda
signal win #señal para el juego ganado

export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var vida = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	vida = 3
	screen_size = get_viewport_rect().size
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
	emit_signal("miss_vida")
	if body.is_in_group("red"): 
		emit_signal("red")
		body._desaparecer()
	if vida==0:
		emit_signal("hit")
		hide()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func _on_Player_area_entered(area):
	if area.is_in_group("salud"):
		vida += 1
		emit_signal("win_vida")
	else:
		emit_signal("update_score")
	if area.is_in_group("linea"):
		emit_signal("win")
		hide()
	area._desaparecer()
