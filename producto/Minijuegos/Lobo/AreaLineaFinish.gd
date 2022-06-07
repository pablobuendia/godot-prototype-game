extends Area2D

func _ready():
	add_to_group("linea")
	#visible = false 
	

func _desaparecer():
	#queue_free()
	$LineaFinish/AnimationPlayer.play_backwards("aparicion")
	


func _on_TiempoDeFinalizacion_timeout():
	#visible = true
	$LineaFinish/AnimationPlayer.play("aparicion")
