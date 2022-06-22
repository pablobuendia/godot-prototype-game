extends Control

func redraw_cantidades():
	$"Comprar Anzuelos x10/Precio Anzuelo".text = str("$", GlobalVar.PRECIO_ANZUELO, ", Restantes: ", GlobalVar.player.anzuelos)
	$"Comprar Coleccionable1/Precio Coleccionable".text = str("$", GlobalVar.PRECIO_COLECCIONABLE_1)
	$"Comprar Coleccionable2/Precio Coleccionable".text = str("$", GlobalVar.PRECIO_COLECCIONABLE_2)
	$"Comprar Coleccionable3/Precio Coleccionable".text = str("$", GlobalVar.PRECIO_MEJORA_BARCO_1)
	$Monedas.text = str("Monedas: ", GlobalVar.player.monedas)

# Called when the node enters the scene tree for the first time.
func _ready():
	redraw_cantidades()
	
func _on_Control_tree_entered():
	redraw_cantidades()

func _on_Comprar_Anzuelos_x10_pressed():
	if GlobalVar.player.monedas > GlobalVar.PRECIO_ANZUELO:
		GlobalVar.player.anzuelos += 10
		GlobalVar.player.monedas -= GlobalVar.PRECIO_ANZUELO
		$Monedas.text = str("Monedas: ", GlobalVar.player.monedas)
		$"Comprar Anzuelos x10/Precio Anzuelo".text = str("$", GlobalVar.PRECIO_ANZUELO, ", Restantes: ", GlobalVar.player.anzuelos)
		$Comprar.play()

func _on_Volver_pressed():
	get_tree().change_scene("res://Mapa.tscn")


func _on_Comprar_Coleccionable1_pressed():
	if GlobalVar.player.monedas > GlobalVar.PRECIO_COLECCIONABLE_1 && GlobalVar.player.coleccionable_1 == false:
		GlobalVar.player.coleccionable_1 = true
		GlobalVar.player.monedas -= GlobalVar.PRECIO_COLECCIONABLE_1
		$Monedas.text = str("Monedas: ", GlobalVar.player.monedas)
		$Comprar.play()


func _on_Comprar_Coleccionable2_pressed():
	if GlobalVar.player.monedas > GlobalVar.PRECIO_COLECCIONABLE_2 && GlobalVar.player.coleccionable_2 == false:
		GlobalVar.player.coleccionable_2 = true
		GlobalVar.player.monedas -= GlobalVar.PRECIO_COLECCIONABLE_2
		$Monedas.text = str("Monedas: ", GlobalVar.player.monedas)
		$Comprar.play()


func _on_Comprar_Coleccionable3_pressed():
	if GlobalVar.player.monedas > GlobalVar.PRECIO_MEJORA_BARCO_1 && GlobalVar.player.mejora_barco_1 == false:
		GlobalVar.player.mejora_barco_1 = true
		GlobalVar.player.monedas -= GlobalVar.PRECIO_MEJORA_BARCO_1
		GlobalVar.SALUD_BASE_BOTE += 100
		$Monedas.text = str("Monedas: ", GlobalVar.player.monedas)
		$Comprar.play()
