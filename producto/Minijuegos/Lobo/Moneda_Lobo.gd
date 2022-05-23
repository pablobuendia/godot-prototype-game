
extends Area2D

func _ready():
	$AnimatedSprite.play()

func _process(delta):
	move_local_x(-300*delta)


func _on_Moneda_area_entered(area):
	print(area)
	queue_free()
