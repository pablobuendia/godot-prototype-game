extends Node2D

var index = 0

func _ready():
	$ButtonLarge/Anzuelos.text = str(GlobalVar.ANZUELOS) #No sabemos si va así
	$ButtonLarge/Monedas.text = str(GlobalVar.MONEDAS)
	#como activar una sola vez? no, cada vez que entre al mapa
	$Intro.show()
	$Intro/AnimationPlayer.play("AnchorIdle")

func _on_Lancha_pressed():
	get_tree().change_scene("res://Minijuegos/Lanchas/scenes/main.tscn")


func _on_Lobo_pressed():
	get_tree().change_scene("res://Minijuegos/Lobo/Main_Lobo.tscn")


func _on_Pesca_pressed():
	get_tree().change_scene("res://Minijuegos/Pesca/Pesca-Main.tscn")


func _on_Tienda_pressed():
	get_tree().change_scene("res://Tienda.tscn")
	

func _on_Restaurante_pressed():
	get_tree().change_scene("res://Restaurante.tscn")
	
var frases = ["¿Cómo ganar monedas?",
"¡Andá a pescar para que los vendas al restaurante!",
"Pero primero!!! Tenés que recorrer en el barco para pescar!",
"¡Mucha suerte!"]

func _on_Panel_pressed():
	if (index < frases.size()):
		$Intro/Panel/RichTextLabel.text = frases[index]
		index+=1
	else:
		$Intro.hide()
