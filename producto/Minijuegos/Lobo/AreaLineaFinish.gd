extends StaticBody2D

func _ready():
	add_to_group("linea")
	
func _desaparecer():
	$LineaFinish/AnimationPlayer.play_backwards("aparicion")
	
func _on_TiempoDeFinalizacion_timeout():
	$LineaFinish/AnimationPlayer.play("aparicion")
