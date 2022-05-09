extends RigidBody2D

func _ready():
	$AnimatedSprite.playing = true
	var fish_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = fish_types[randi() % fish_types.size()]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
