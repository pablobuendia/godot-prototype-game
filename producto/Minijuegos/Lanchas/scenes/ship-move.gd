extends RigidBody2D

export var speed_mult = 1
var vel_dir = Vector2(0,1)
export var horizontal = 0
export var size = 1 

var in_screen = false

func _ready():
	$sprite.scale = $sprite.scale*size
	$col.scale = $col.scale*size

func _process(delta):
	if (!horizontal):
		linear_velocity = Vector2(linear_velocity.x,speed_mult*100)
	else:
		linear_velocity = Vector2(speed_mult*100,linear_velocity.y)
		
	if position.y > get_viewport_rect().size.y * 2:
		get_parent().remove_child(self)


func init(scale,pos,horiz):
	horizontal = horiz
	position = pos
	mass = mass*scale
	$sprite.scale = $sprite.scale*scale
	$col.scale = $col.scale*scale
	speed_mult = (4/scale)


func _on_VisibilityNotifier2D_screen_entered():
	in_screen = true




func _on_VisibilityNotifier2D_screen_exited():
	if (in_screen):
		in_screen = false
		queue_free()
