extends Node2D

#Camara
onready var camera = $Camera2D
onready var bote_pos = $Bote.position
onready var BOTE_SPEED = 100
onready var BOTE_WOBBLING = 0
onready var FRAME_COUNTER = 0
onready var BOTE_WOBBLING_DIRECTION = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
# Muevo pad izquierdo
	var change = 1 * BOTE_WOBBLING_DIRECTION
	FRAME_COUNTER += 1
	if (Input.is_action_pressed("Boat_left")):
		bote_pos.x += -BOTE_SPEED * delta
		if (FRAME_COUNTER % 2 == 0):
			if (randi() % 10 > 1):
				bote_pos.y += change
				BOTE_WOBBLING += change
			else:
				bote_pos.y -= change
				BOTE_WOBBLING -= change
		$Bote/Bote_Der.visible = false
		$Bote/Bote_Izq.visible = true
	if (Input.is_action_pressed("Boat_right")):
		bote_pos.x += BOTE_SPEED * delta		
		if (FRAME_COUNTER % 2 == 0):
			if (randi() % 10 > 1):
				bote_pos.y += change
				BOTE_WOBBLING += change
			else:
				bote_pos.y -= change
				BOTE_WOBBLING -= change
		$Bote/Bote_Izq.visible = false
		$Bote/Bote_Der.visible = true
	if (BOTE_WOBBLING > 5):
		BOTE_WOBBLING_DIRECTION = -1
	elif (BOTE_WOBBLING < -5):
		BOTE_WOBBLING_DIRECTION = 1
	if (FRAME_COUNTER == 1000):
		FRAME_COUNTER = 0
	$Bote.position=bote_pos
