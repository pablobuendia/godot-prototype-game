extends Control

func redraw_cantidades():
	$"Comprar Anzuelos x10/Precio Anzuelo".text = str("$", GlobalVar.PRECIO_ANZUELO, ", Restantes: ", GlobalVar.player.anzuelos)
	$"Comprar Lobo Azul/Precio Coleccionable".text = str("$", GlobalVar.PRECIO_COLECCIONABLE_LOBO_AZUL)
	$"Comprar Lobo Rosa/Precio Coleccionable".text = str("$", GlobalVar.PRECIO_COLECCIONABLE_LOBO_ROSA)
	$"Comprar Barco/Precio Coleccionable".text = str("$", GlobalVar.PRECIO_COLECCIONABLE_BARCO)
	$"Comprar Velero/Precio Coleccionable".text = str("$", GlobalVar.PRECIO_COLECCIONABLE_VELERO)
	$"Comprar Mejora Barco 1/Precio Coleccionable".text = str("$", GlobalVar.PRECIO_MEJORA_BARCO_1)
	$Monedas.text = str(GlobalVar.player.monedas)

# Called when the node enters the scene tree for the first time.
func _ready():
	redraw_cantidades()
	
func _on_Control_tree_entered():
	redraw_cantidades()

func _on_Comprar_Anzuelos_x10_pressed():
	if GlobalVar.player.monedas > GlobalVar.PRECIO_ANZUELO:
		GlobalVar.player.anzuelos += 10
		GlobalVar.player.monedas -= GlobalVar.PRECIO_ANZUELO
		$Monedas.text = str(GlobalVar.player.monedas)
		$"Comprar Anzuelos x10/Precio Anzuelo".text = str("$", GlobalVar.PRECIO_ANZUELO, ", Restantes: ", GlobalVar.player.anzuelos)
		$Comprar.play()

func _on_Volver_pressed():
	get_tree().change_scene("res://Mapa.tscn")

func _on_Comprar_Mejora_Barco_1_pressed():
	if GlobalVar.player.monedas > GlobalVar.PRECIO_MEJORA_BARCO_1 && GlobalVar.player.mejora_barco_1 == false:
		GlobalVar.player.mejora_barco_1 = true
		GlobalVar.player.monedas -= GlobalVar.PRECIO_MEJORA_BARCO_1
		GlobalVar.SALUD_BASE_BOTE += 100
		$Monedas.text = str(GlobalVar.player.monedas)
		$Comprar.play()


func _on_Comprar_Lobo_Azul_pressed():
	if GlobalVar.player.monedas > GlobalVar.PRECIO_COLECCIONABLE_LOBO_AZUL && GlobalVar.player.coleccionable_lobo_azul == false:
		GlobalVar.player.coleccionable_lobo_azul = true
		GlobalVar.player.monedas -= GlobalVar.PRECIO_COLECCIONABLE_LOBO_AZUL
		$Monedas.text = str(GlobalVar.player.monedas)
		$Comprar.play()


func _on_Comprar_Velero_pressed():
	if GlobalVar.player.monedas > GlobalVar.PRECIO_COLECCIONABLE_VELERO && GlobalVar.player.coleccionable_velero == false:
		GlobalVar.player.coleccionable_velero = true
		GlobalVar.player.monedas -= GlobalVar.PRECIO_COLECCIONABLE_VELERO
		$Monedas.text = str(GlobalVar.player.monedas)
		$Comprar.play()



func _on_Comprar_Barco_pressed():
	if GlobalVar.player.monedas > GlobalVar.PRECIO_COLECCIONABLE_BARCO && GlobalVar.player.coleccionable_barco == false:
		GlobalVar.player.coleccionable_barco = true
		GlobalVar.player.monedas -= GlobalVar.PRECIO_COLECCIONABLE_BARCO
		$Monedas.text = str(GlobalVar.player.monedas)
		$Comprar.play()


func _on_Comprar_Lobo_Rosa_pressed():
	if GlobalVar.player.monedas > GlobalVar.PRECIO_COLECCIONABLE_LOBO_ROSA && GlobalVar.player.coleccionable_lobo_rosa == false:
		GlobalVar.player.coleccionable_lobo_rosa = true
		GlobalVar.player.monedas -= GlobalVar.PRECIO_COLECCIONABLE_LOBO_ROSA
		$Monedas.text = str(GlobalVar.player.monedas)
		$Comprar.play()
