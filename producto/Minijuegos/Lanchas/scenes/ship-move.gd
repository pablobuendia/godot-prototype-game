extends RigidBody2D

export (float) var speed_mult = 1
var vel_dir = Vector2(0,1)
export var horizontal = 0
export (float) var size = 1 
export (int) var persistent = 0

var in_screen = false

func _ready():
	$sprite.scale = $sprite.scale*size
	if ($col != null):
		$col.scale = $col.scale*size
	if ($AnimationPlayer != null):
		$AnimationPlayer.play("Swing")

func _process(delta):
	if (!horizontal):
		linear_velocity = Vector2(linear_velocity.x,speed_mult*100)
	else:
		linear_velocity = Vector2(speed_mult*100,linear_velocity.y)
	#if position.y > get_viewport_rect().size.y * 2:
	#	get_parent().remove_child(self)


func init(scale,pos,horiz):
	horizontal = horiz
	position = pos
	mass = mass*scale
	$sprite.scale = $sprite.scale*scale
	if ($col!=null):
		$col.scale = $col.scale*scale
	speed_mult = (4/scale)

func _on_VisibilityNotifier2D_screen_entered():
	in_screen = true

func _on_VisibilityNotifier2D_screen_exited():
	if (in_screen):
		in_screen = false
		if (!persistent):
			queue_free()

func set_speed(s):
	speed_mult = s;
