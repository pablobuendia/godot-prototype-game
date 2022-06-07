class_name Player_Lobo
extends RigidBody2D

signal miss_vida #señal para que se actualice el valor de vida en el main
signal win_vida
signal update_score #señal para la moneda
signal win #señal para el juego ganado

export var speed = 600 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var vida = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	vida = 3
	gravity_scale = 20
	screen_size = get_viewport_rect().size
	hide()
	
func _process(delta):
	linear_velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		linear_velocity = Vector2(0,-100)
	if Input.is_action_pressed("move_right"):
		linear_velocity = Vector2(100,0)
	if Input.is_action_pressed("move_down"):
		linear_velocity = Vector2(0,100)
	if Input.is_action_pressed("move_left"):
		linear_velocity = Vector2(-100,0)
	
	if linear_velocity.length() > 0:
		linear_velocity = linear_velocity.normalized() * speed
		$Animacion.play()
	else:
		$Animacion.stop()
		
	position += linear_velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_Player_body_entered(body):
	if body.is_in_group("red") or body.is_in_group("suelo"):
		vida -=1
		emit_signal("miss_vida") 
	if body.is_in_group("red"):
		emit_signal("red")
		body._desaparecer()
	if body.is_in_group("salud"):
		vida += 1
		emit_signal("win_vida")
		body._desaparecer()
	if body.is_in_group("moneda"):
		emit_signal("update_score")
		body._desaparecer()
	if body.is_in_group("linea"):
		emit_signal("win")
		hide()
		body._desaparecer()
		
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	

