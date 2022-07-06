extends KinematicBody2D

export var speed = 10



export var base_inv_time = 1.5

onready var camera = $Camera2D

var base_health = GlobalVar.SALUD_BASE_BOTE
var health = base_health
var touch_direction = Vector2.ZERO
var dragging=false
var offset

var health_bar
var health_bar_length

var inv_time = -1

var colliding = false

var death = false

var pos = Vector2()
func _ready():
	death = false
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
	if (!get_parent().mar_abierto):
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
				if (get_parent().mar_abierto):
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
		get_parent().get_node("Hit_Sound").play()
		health_bar.value = (health*1.0 / base_health)*100
		inv_time = base_inv_time
	else:
		if (!death):
			print("Hit! You lose!")
			get_parent().get_node("Death_Sound").play()
			get_parent().get_node("UI/Score").hide()
			get_parent().get_node("UI/HealthBar").hide()
			get_parent().get_node("UI/HealthBarBG").hide()
			get_parent().get_node("UI/ProgressBar").hide()
			get_parent().get_node("UI/ProgressBarBG").hide()
			get_parent().get_node("UI/Score2").hide()
			get_tree().paused = true
			get_parent().get_node("GameOverUI").show_death(0)
			death = true


func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy") || (body.is_in_group("scenary") && !get_parent().mar_abierto):
		colliding = true
	if body.is_in_group("hook"):
		body.queue_free()
		GlobalVar.player.anzuelos +=3
		GlobalVar.save_game()
		get_parent().get_node("Popup").notify(body.position,"+3 Anzuelos")



func _on_Area2D_body_exited(body):
	colliding = false
