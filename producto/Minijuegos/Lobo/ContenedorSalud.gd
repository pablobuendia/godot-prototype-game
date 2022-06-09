extends Node2D

var salud = load("res://Minijuegos/Lobo/Salud.tscn")


func crear_salud():
	var nueva_salud = salud.instance()
	nueva_salud.global_position = Vector2(1000,rand_range(-300,180))
	add_child(nueva_salud)		



func _on_TiempoDeGeneracion_timeout():
	crear_salud()

