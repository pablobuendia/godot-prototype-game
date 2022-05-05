extends RigidBody2D
var speed_mult = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	linear_velocity = Vector2(0,400)

# Called when the node enters the scene tree for the first time.
func _process(delta):
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
