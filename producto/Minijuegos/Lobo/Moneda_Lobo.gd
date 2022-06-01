
extends Area2D

func _ready():
	$AnimatedSprite.play()

func _process(delta):
	move_local_x(-300*delta)

func _desaparecer():
	queue_free()
