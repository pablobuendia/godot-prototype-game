extends CanvasLayer

signal ok_pressed

var descriptions = ["Cabeza de Pescador, Autor: Cleto Ciocchini",
"Regreso de la Pesca, Autor: Cleto Ciocchini",
"Pescador de Mar del Plata, Autor: Cleto Ciocchini",
"Regreso de Pescadores, Autor: Cleto Ciocchini"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func hide():
	$PopUpSecret.hide()
	$BackShadow.hide()

func show_secret(message,pintura):
	$BackShadow.show()
	$PopUpSecret.popup_exclusive = true
	$PopUpSecret.popup_centered($PopUpSecret/ColorRect.get_rect().size)
	if (pintura >=1 && pintura <= 4):
		$PopUpSecret/Pintura.texture = load("res://assets/img/pintura"+str(pintura)+".jpg")
		$PopUpSecret/description.text = descriptions[pintura-1]
	else:
		$PopUpSecret/Pintura.texture = load("res://assets/img/coins.png")
		$PopUpSecret/description.text = "Ganas 1000 Monedas!"
	if (message != null):
		$PopUpSecret/Label2.text = message
	else:
		var pinturas = 0;
		for a in GlobalVar.player.pinturas:
			pinturas +=a
		$PopUpSecret/Label2.text = "Has encontrado una pintura secreta: "+str(pinturas)+"/4"

func _on_Popup_focus_exited():
	$Popup.grab_focus()

func _on_ButtonOK2_pressed():
	$Button_click.play()
	hide()
	emit_signal("ok_pressed")
