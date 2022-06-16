extends KinematicBody2D

export var speed = 10

export var mar_abierto = false
export var base_health = 200
export (float) var health = base_health
export var base_inv_time = 1.5

onready var camera = $Camera2D

var touch_direction = Vector2.ZERO
var dragging=false
var offset

var health_bar
var health_bar_length

var inv_time = -1

var colliding = false

var pos = Vector2()
func _ready():
	health_bar = get_parent().get_node("UI/HealthBar")
	health_bar_length = health_bar.get_rect().size.x

func _process(delta):
	pos = Vector2.ZERO
	if Input.is_action_pressed("ui_up") :
		pos.y = -1
	else:
		if Input.is_action_pressed("ui_down"):
			pos.y = 1
	if Input.is_action_pressed("ui_right") :
		pos.x = 1
	else:
		if Input.is_action_pressed("ui_left"):
			pos.x = -1
	if (!mar_abierto):
		position = Vector2(position.x-1.5,position.y)

func _input(event):
	if event is InputEventScreenTouch:
		if (event.is_pressed()):
			offset = event.position-position
		else:
			offset = Vector2.ZERO
	else:
		if event is InputEventScreenDrag:
			if (event.position != null and offset != null and position != null):
				var res = (event.position-offset-position)*speed*1
				if (mar_abierto):
					move_and_slide(res)
				else:
					move_and_slide(Vector2(0,res.y))


func _physics_process(delta):
		
	var mult = 1
	if (pos.y > 0):
		mult = 0.5
	move_and_slide(Vector2(pos.x*0.7,pos.y*mult)*speed*1000*delta,Vector2.UP)
	if inv_time > 0:
		inv_time-=delta
	else:
		if colliding:
			collide()

func collide():
	health-= 40
	if health > 0:
		health_bar.set_size(Vector2((health*1.0 / base_health)*health_bar_length,health_bar.get_rect().size.y))
		inv_time = base_inv_time
	else:
		print("Hit! You lose!")
		get_parent().get_node("UI/Score").hide()
		get_parent().get_node("UI/HealthBar").hide()
		get_parent().get_node("UI/HealthBarBG").hide()
		get_tree().paused = true
		get_parent().get_node("GameOverUI").show_death(-1)


func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy") || body.is_in_group("scenary"):
		colliding = true


func _on_AreaMarAbierto_body_entered(body):
	if (!body.is_in_group("scenary") && !mar_abierto):
		mar_abierto = true
		remove_child(camera)
		get_parent().add_child(camera)
		camera.position = position
		camera.rotation_degrees = 270
		


func _on_Area2D_body_exited(body):
	colliding = false
