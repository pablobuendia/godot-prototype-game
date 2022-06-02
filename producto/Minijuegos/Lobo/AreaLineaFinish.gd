extends Area2D

func _ready():
	add_to_group("linea")
	visible = false 

func _desaparecer():
	queue_free()


func _on_TiempoDeFinalizacion_timeout():
	visible = true
