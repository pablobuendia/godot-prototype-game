extends Node2D
#puntajes
var R=0
var I=0
#tamaños
onready var screen_size = get_viewport_rect().size
onready var pad_size = get_node("Bar_Der").texture.get_size()*get_node("Bar_Der").scale
#posiciones
onready var left_pos = $Bar_Izq.position
onready var right_pos = $Bar_Der.position
onready var ball_pos = $Pelota.position
onready var bote_pos = $Bote.position
#velocidades
const INITIAL_BALL_SPEED = 300
var ball_speed = INITIAL_BALL_SPEED
const PAD_SPEED = 400
#direccion
var direction = Vector2(1.0, 0.0)
#rectangulos
var left_rect 
var right_rect
#EXTRA: Camara
onready var camera = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	left_pos.x = 15
	right_pos.x = screen_size.x -15
	left_rect = Rect2(left_pos-pad_size*0.5, pad_size)
	right_rect = Rect2(right_pos-pad_size*0.5, pad_size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Genero los rectangulos de ese frame
	left_rect = Rect2(left_pos-pad_size*0.5, pad_size)
	right_rect = Rect2(right_pos-pad_size*0.5, pad_size)
	#muevo la pelota en un frame
	ball_pos += direction *ball_speed*delta
	#verifico si toco piso o techo
	if((ball_pos.y < 0 and direction.y <0)or (ball_pos.y > screen_size.y and direction.y >0)):
		direction.y = -direction.y
	#verifico si toco algun pad. cambio la direccion y aumento la velocidad
	if ((left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0)):
		direction.x = -direction.x
		direction.y = randf()*2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.1
	# Verifico si se terminó el punto
	if (ball_pos.x < 0):
		R+=1
		$Puntaje_Der.text = str(R)
		reinicio()
	if (ball_pos.x > screen_size.x):
		I+=1
		$Puntaje_Izq.text = str(I)
		reinicio()
	get_node("Pelota").position=ball_pos

# Muevo pad izquierdo
	if (Input.is_action_pressed("Left_up")):
		bote_pos.y += -PAD_SPEED * delta
	if (Input.is_action_pressed("Left_down")):
		bote_pos.y += PAD_SPEED * delta
	if (Input.is_action_pressed("Left_left")):
		bote_pos.x += -PAD_SPEED * delta
		$Bote/Bote_Der.visible = false
		$Bote/Bote_Izq.visible = true
	if (Input.is_action_pressed("Left_right")):
		bote_pos.x += PAD_SPEED * delta		
		$Bote/Bote_Izq.visible = false
		$Bote/Bote_Der.visible = true
	$Bote.position =bote_pos

# Muevo pad derecho
	if (right_pos.y > 0 and Input.is_action_pressed("Right_up")):
		right_pos.y += -PAD_SPEED * delta
	if (right_pos.y < screen_size.y and Input.is_action_pressed("Right_down")):
		right_pos.y += PAD_SPEED * delta
	$Bar_Der.position = right_pos
	if (camera.current == true):
		move_camera()

func reinicio():
	ball_pos = screen_size*0.5
	ball_speed = INITIAL_BALL_SPEED
	direction = Vector2(-1, 0)
	
func move_camera():#Extra. Mover Camara
	camera.position = ball_pos
	if ball_pos.x < screen_size.x/2:
		camera.zoom.x = 1 - ball_pos.distance_to($Bar_Izq.position)/screen_size.x
	else:
		camera.zoom.x = 1 - ball_pos.distance_to($Bar_Der.position)/screen_size.x
	camera.zoom.y = camera.zoom.x
