extends RigidBody2D

func _ready():
	add_to_group("red")

func _desaparecer():
	queue_free()
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

