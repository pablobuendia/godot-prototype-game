extends Node2D

var index = 0

func _ready():
	$Anzuelos.text = str(GlobalVar.player.anzuelos) 
	$Monedas.text = str(GlobalVar.player.monedas)
	$NamePlayer.text = GlobalVar.player.username
	if(GlobalVar.player.banderaInicio == false): #Ya jugó antes?
		$Intro.show()
		$Intro/AnimationPlayer.play("AnchorIdle")
	if(GlobalVar.player.lancha==true):
		$Tap/AnimationTap.play("pesca")

func _on_Lancha_pressed():
	get_tree().change_scene("res://Minijuegos/Lanchas/scenes/main.tscn")
	GlobalVar.player.lancha = true
	$Tap.hide()
	
func _on_Lobo_pressed():
	get_tree().change_scene("res://Minijuegos/Lobo/Main_Lobo.tscn")

func _on_Pesca_pressed():
	get_tree().change_scene("res://Minijuegos/Pesca/Pesca-Main.tscn")
	GlobalVar.player.pesca = true
	$Tap.hide()
	
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
		$Tap/AnimationTap.play("play")


func _on_VolverMenu_pressed():
	get_tree().change_scene("res://Main-Menu.tscn")
