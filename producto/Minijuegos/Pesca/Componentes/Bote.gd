extends Node2D
signal hit

var screen_size
export(PackedScene) var anzuelo_scene
onready var bote_pos = Vector2(000, 000)
onready var BOTE_SPEED = 150
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
# Muevo pad izquierdo
	var change = 1 * BOTE_WOBBLING_DIRECTION
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
		var anzuelo = anzuelo_scene.instance()
		anzuelo.position = Vector2(0, 50)
		anzuelo.gravity_scale = 3
		anzuelo.get_child(1).visible = true
		add_child(anzuelo)


#func _on_Bote_body_entered(body):
#	hide() # Player disappears after being hit.
#	emit_signal("hit")
#	# Must be deferred as we can't change physics properties on a physics callback.
#	$CollisionShape2D.set_deferred("disabled", true)
