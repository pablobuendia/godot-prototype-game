class_name Enemigo_Lobo
extends RigidBody2D

func _ready():
	$AnimatedSprite.playing = true
	var fish_types = $AnimatedSprite.frames.get_animation_names()
	#Es para seleccionar la animacion de manera correcta 
	if(position.x<=0):
		$AnimatedSprite.animation = fish_types[1] #Si esta en el lado izquierdo, el pescado tendra que nadar hacia el lado der
	else:
		$AnimatedSprite.animation = fish_types[0] #Si esta en el lado derecho, el pescado tendra que nadar hacia el lado izq

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
