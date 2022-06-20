extends Control

func redraw_cantidades():
	$"Vender Besugo/Precio Besugo".text = str("$", GlobalVar.PRECIOS_PECES[0], ", Restantes: ", GlobalVar.player.cantidad_peces[0])
	$"Vender Besugo Rojo/Precio Besugo Rojo".text = str("$", GlobalVar.PRECIOS_PECES[1], ", Restantes: ", GlobalVar.player.cantidad_peces[1])
	$"Vender Bonito/Precio Bonito".text = str("$", GlobalVar.PRECIOS_PECES[2], ", Restantes: ", GlobalVar.player.cantidad_peces[2])
	$"Vender Caballa/Precio Caballa".text = str("$", GlobalVar.PRECIOS_PECES[3], ", Restantes: ", GlobalVar.player.cantidad_peces[3])
	$"Vender Limon/Precio Limon".text = str("$", GlobalVar.PRECIOS_PECES[4], ", Restantes: ", GlobalVar.player.cantidad_peces[4])
	$"Vender Mero/Precio Mero".text = str("$", GlobalVar.PRECIOS_PECES[5], ", Restantes: ", GlobalVar.player.cantidad_peces[5])
	
	$Monedas.text = str("Monedas: ", GlobalVar.player.monedas)


func _ready():
	redraw_cantidades()
	
func _on_Control_tree_entered():
	redraw_cantidades()

func comprar_pez(tipoPez, boton):
	if GlobalVar.player.cantidad_peces[tipoPez] >= 1:
		GlobalVar.player.cantidad_peces[tipoPez] -= 1
		GlobalVar.player.monedas += GlobalVar.PRECIOS_PECES[tipoPez]
		$Monedas.text = str("Monedas: ", GlobalVar.player.monedas)
		boton.text = str("$", GlobalVar.PRECIOS_PECES[tipoPez], ", Restantes: ", GlobalVar.player.cantidad_peces[tipoPez])


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
