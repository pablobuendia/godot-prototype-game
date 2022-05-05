extends KinematicBody2D

export var speed = 10

var initial_pos
var touch_direction = Vector2.ZERO
var dragging=false
var offset

var pos = Vector2()
func _ready():
	pass

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

func _input(event):
	if event is InputEventScreenTouch:
		if (event.is_pressed()):
			offset = event.position-position
		else:
			offset = Vector2.ZERO
	else:
		if event is InputEventScreenDrag:
			if (event.position != null and offset != null and position != null):
				move_and_slide((event.position-offset-position)*speed*1,Vector2.UP)
				#rotate((event.position-offset).angle_to(position))
				


func _physics_process(delta):
		
	var mult = 1
	if (pos.y > 0):
		mult = 0.5
	move_and_slide(Vector2(pos.x*0.7,pos.y*mult)*speed*1000*delta,Vector2.UP)


func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		print("Hit! You lose!")
		print("Your Score: "+str(get_parent().score))
		get_tree().paused = true
		get_parent().get_node("GameOverUI").show(get_parent().score)
