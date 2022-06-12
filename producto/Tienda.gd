extends Control

func redraw_cantidades():
	$"Comprar Anzuelos x10/Precio Anzuelo".text = str("$", GlobalVar.PRECIO_ANZUELO, ", Restantes: ", GlobalVar.ANZUELOS)
	$"Comprar Coleccionable1/Precio Coleccionable".text = str("$", GlobalVar.PRECIO_COLECCIONABLE_1)
	$"Comprar Coleccionable2/Precio Coleccionable".text = str("$", GlobalVar.PRECIO_COLECCIONABLE_2)
	
	$Monedas.text = str("Monedas: ", GlobalVar.MONEDAS)

# Called when the node enters the scene tree for the first time.
func _ready():
	redraw_cantidades()
	
func _on_Control_tree_entered():
	redraw_cantidades()

func _on_Comprar_Anzuelos_x10_pressed():
	if GlobalVar.MONEDAS > GlobalVar.PRECIO_ANZUELO:
		GlobalVar.ANZUELOS += 10
		GlobalVar.MONEDAS -= GlobalVar.PRECIO_ANZUELO
		$Monedas.text = str("Monedas: ", GlobalVar.MONEDAS)
		$"Comprar Anzuelos x10/Precio Anzuelo".text = str("$", GlobalVar.PRECIO_ANZUELO, ", Restantes: ", GlobalVar.ANZUELOS)
		$Comprar.play()

func _on_Volver_pressed():
	get_tree().change_scene("res://Mapa.tscn")


func _on_Comprar_Coleccionable1_pressed():
	if GlobalVar.MONEDAS > GlobalVar.PRECIO_COLECCIONABLE_1 && GlobalVar.COLECCIONABLE_1 == false:
		GlobalVar.COLECCIONABLE_1 = true
		GlobalVar.MONEDAS -= GlobalVar.PRECIO_COLECCIONABLE_1
		$Monedas.text = str("Monedas: ", GlobalVar.MONEDAS)
		$Comprar.play()


func _on_Comprar_Coleccionable2_pressed():
	if GlobalVar.MONEDAS > GlobalVar.PRECIO_COLECCIONABLE_2 && GlobalVar.COLECCIONABLE_2 == false:
		GlobalVar.COLECCIONABLE_2 = true
		GlobalVar.MONEDAS -= GlobalVar.PRECIO_COLECCIONABLE_2
		$Monedas.text = str("Monedas: ", GlobalVar.MONEDAS)
		$Comprar.play()
