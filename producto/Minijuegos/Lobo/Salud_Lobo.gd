extends StaticBody2D

func _ready():
	add_to_group("salud")
	$Sprite.show()

func _process(delta):
	move_local_x(-300*delta)

func _desaparecer():
	queue_free()
