extends Node2D

var moneda = load("res://Minijuegos/Lobo/Moneda_Lobo.tscn")


func _process(delta):
	if $TiempoDeGeneracion.is_stopped():
		crear_monedas()
		$TiempoDeGeneracion.start()

func crear_monedas():
	var nueva_moneda = moneda.instance()
	nueva_moneda.global_position = Vector2(1000,rand_range(88,400))
	add_child(nueva_moneda)		
