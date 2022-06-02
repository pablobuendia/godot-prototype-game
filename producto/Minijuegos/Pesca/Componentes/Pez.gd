extends RigidBody2D

export var CURRENT_TEXTURE = 3

const posicionNodoCollisionShape = 0
onready var counter = 0
onready var current_rotation = 0
const animation_event_frame_1 = 5
const animation_event_frame_2 = animation_event_frame_1 * 2
const animation_event_frame_3 = animation_event_frame_1 * 3
const animation_event_frame_4 = animation_event_frame_1 * 4
const animation_event_frame_5 = animation_event_frame_1 * 5

func _ready():
	pass 

func start(texture, escalaPez, flip_h):
	CURRENT_TEXTURE = texture
	self.get_child(CURRENT_TEXTURE).visible = true
	self.get_child(CURRENT_TEXTURE).flip_h = flip_h
	self.get_child(CURRENT_TEXTURE).scale = Vector2(escalaPez, escalaPez)
	self.get_child(posicionNodoCollisionShape).scale = Vector2(escalaPez * 10, escalaPez * 10)
	self.scale = Vector2(escalaPez, escalaPez)
	show()

func _process(delta):
	# Animacion de nado
	counter += 1
	if counter == animation_event_frame_1:
		var current_sprite = get_child(CURRENT_TEXTURE)
		current_rotation = (randi() % 5) * -1
		current_sprite.rotation_degrees = current_rotation * 2 - 6
	if counter == animation_event_frame_2:
		var current_sprite = get_child(CURRENT_TEXTURE)
		current_sprite.rotation_degrees = current_rotation * 2 - 6
	if counter == animation_event_frame_3:
		var current_sprite = get_child(CURRENT_TEXTURE)
		current_sprite.rotation_degrees = current_rotation
	if counter == animation_event_frame_4:
		var current_sprite = get_child(CURRENT_TEXTURE)
		current_sprite.rotation_degrees = (current_rotation * -1)
	if counter == animation_event_frame_5:
		var current_sprite = get_child(CURRENT_TEXTURE)
		current_sprite.rotation_degrees = (current_rotation * 2)
		counter = 0

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Pez_body_entered(body):
	$CollisionShape2D.disabled = true
	self.set_collision_layer_bit(1, false)
	self.set_collision_mask_bit(0, false)
	
	# Animacion al ser atrapado
	var current_sprite = get_child(CURRENT_TEXTURE)
	var current_scale = current_sprite.scale
	$Tween.interpolate_property(current_sprite, "scale", current_scale, Vector2(0, 0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	
	var nodo_padre = get_parent()
	nodo_padre.set_puntaje(nodo_padre.get_puntaje() + 100)

func _on_Tween_tween_completed(object, key):
	queue_free()
