extends Node2D

var moneda = load("res://Minijuegos/Lobo/Moneda_Lobo.tscn")




func crear_monedas():
	var nueva_moneda = moneda.instance()
	nueva_moneda.global_position = Vector2(1000,rand_range(88,400))
	add_child(nueva_moneda)		



func _on_TiempoDeGeneracion_timeout():
	crear_monedas()
