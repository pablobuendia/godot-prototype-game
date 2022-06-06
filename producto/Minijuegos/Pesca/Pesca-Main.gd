extends Control

var index = 0
signal dialog_terminated

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("AnchorIdle")
	pass # Replace with function body.


var frases = ["¡Hola, ayudame a pescar la orden para el restaurante!",
"Movete y usá tus anzuelos para capturar a todos los peces de la lista",
"¡Cuidado! Si atrapás a un pez que no corresponde o a una roca, tenés una penalización",
"¡También tenés una penalización si capturás por encima de lo que te piden!",
"Si tenés demasiadas penalizaciones ¡Perdés el nivel!",
"¡Mucha suerte!"]

func _on_Panel_pressed():
	if (index < frases.size()):
		$Panel/RichTextLabel.text = frases[index]
		index+=1
	else:
		get_tree().change_scene("res://Minijuegos/Pesca/Pesca-Nivel.tscn")
