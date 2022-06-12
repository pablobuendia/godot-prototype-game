extends Control

func redraw_cantidades():
	$"Vender Besugo/Precio Besugo".text = str("$", GlobalVar.PRECIOS_PECES[0], ", Restantes: ", GlobalVar.CANTIDAD_PECES[0])
	$"Vender Besugo Rojo/Precio Besugo Rojo".text = str("$", GlobalVar.PRECIOS_PECES[1], ", Restantes: ", GlobalVar.CANTIDAD_PECES[1])
	$"Vender Bonito/Precio Bonito".text = str("$", GlobalVar.PRECIOS_PECES[2], ", Restantes: ", GlobalVar.CANTIDAD_PECES[2])
	$"Vender Caballa/Precio Caballa".text = str("$", GlobalVar.PRECIOS_PECES[3], ", Restantes: ", GlobalVar.CANTIDAD_PECES[3])
	$"Vender Limon/Precio Limon".text = str("$", GlobalVar.PRECIOS_PECES[4], ", Restantes: ", GlobalVar.CANTIDAD_PECES[4])
	$"Vender Mero/Precio Mero".text = str("$", GlobalVar.PRECIOS_PECES[5], ", Restantes: ", GlobalVar.CANTIDAD_PECES[5])
	
	$Monedas.text = str("Monedas: ", GlobalVar.MONEDAS)


func _ready():
	redraw_cantidades()
	
func _on_Control_tree_entered():
	redraw_cantidades()

func comprar_pez(tipoPez, boton):
	if GlobalVar.CANTIDAD_PECES[tipoPez] >= 1:
		GlobalVar.CANTIDAD_PECES[tipoPez] -= 1
		GlobalVar.MONEDAS += GlobalVar.PRECIOS_PECES[tipoPez]
		$Monedas.text = str("Monedas: ", GlobalVar.MONEDAS)
		boton.text = str("$", GlobalVar.PRECIOS_PECES[tipoPez], ", Restantes: ", GlobalVar.CANTIDAD_PECES[tipoPez])


func _on_Vender_Besugo_pressed():
	comprar_pez(0, $"Vender Besugo/Precio Besugo")
	$Vender.play()

func _on_Vender_Besugo_Rojo_pressed():
	comprar_pez(1, $"Vender Besugo Rojo/Precio Besugo Rojo")
	$Vender.play()
	
func _on_Vender_Bonito_pressed():
	comprar_pez(2, $"Vender Bonito/Precio Bonito")
	$Vender.play()

func _on_Vender_Caballa_pressed():
	comprar_pez(3, $"Vender Caballa/Precio Caballa")
	$Vender.play()

func _on_Vender_Limon_pressed():
	comprar_pez(4, $"Vender Limon/Precio Limon")
	$Vender.play()

func _on_Vender_Mero_pressed():
	comprar_pez(5, $"Vender Mero/Precio Mero")
	$Vender.play()

func _on_Volver_pressed():
	get_tree().change_scene("res://Mapa.tscn")
	$Vender.play()
