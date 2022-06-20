extends Node2D
signal boton_anzuelo_pressed
signal decrement_anzuelo

var screen_size
export(PackedScene) var anzuelo_scene
onready var bote_pos = Vector2(0, 0)
onready var BOTE_SPEED = 200
onready var BOTE_WOBBLING = 0
onready var FRAME_COUNTER = 0
onready var BOTE_WOBBLING_DIRECTION = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func start(pos):
	bote_pos = pos
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var change = BOTE_WOBBLING_DIRECTION
	FRAME_COUNTER += 1
	if (FRAME_COUNTER % 10 == 0):
		if (randi() % 10 > 1):
			bote_pos.y += change
			BOTE_WOBBLING += change
		else:
			bote_pos.y -= change
			BOTE_WOBBLING -= change
	if (FRAME_COUNTER % 10 == 0):
		if (randi() % 10 > 1):
			bote_pos.y += change
			BOTE_WOBBLING += change
		else:
			bote_pos.y -= change
			BOTE_WOBBLING -= change
	if BOTE_WOBBLING > 5:
		BOTE_WOBBLING_DIRECTION = -1
	elif BOTE_WOBBLING < -5:
		BOTE_WOBBLING_DIRECTION = 1
	if FRAME_COUNTER == 1000:
		FRAME_COUNTER = 0
	
	if Input.is_action_pressed("Boat_right"):
		bote_pos.x += BOTE_SPEED * delta
		$Bote_sprite.flip_h = false
	if Input.is_action_pressed("Boat_left"):
		bote_pos.x -= BOTE_SPEED * delta
		$Bote_sprite.flip_h = true
	position=bote_pos
	
	if Input.is_action_just_released("Boat_rod"):
		if (GlobalVar.player.anzuelos >= 1):
			var anzuelo = anzuelo_scene.instance()
			anzuelo.position = Vector2(0, 50)
			anzuelo.gravity_scale = 2
			anzuelo.get_child(1).visible = true
			GlobalVar.player.anzuelos -= 1
			add_child(anzuelo)
			emit_signal("boton_anzuelo_pressed")
			emit_signal("decrement_anzuelo")
