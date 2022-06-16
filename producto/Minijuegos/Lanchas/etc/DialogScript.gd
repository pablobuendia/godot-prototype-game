extends Control

var index = 1
signal dialog_terminated

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("AnchorIdle")
	$Panel/RichTextLabel.text = frases[0]


var frases = ["Bienvenido al puerto de Mar del Plata","Hoy zarparemos a mar abierto","Va a ser un viaje muy divertido!, pero hay que ser cuidadosos para salir del puerto."]



func _on_Panel_pressed():
	if (index < frases.size()):
		$Panel/RichTextLabel.text = frases[index]
		index+=1
	else:
		emit_signal("dialog_terminated")
