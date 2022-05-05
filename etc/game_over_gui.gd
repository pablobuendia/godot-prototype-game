extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal ok_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func hide():
	$Popup.hide()
	$BackShadow.hide()

func show(score):
	$BackShadow.show()
	$Popup.popup_exclusive = true
	$Popup.popup_centered($Popup/ColorRect.get_rect().size)
	$Popup/Label2.text = "Final Score: "+str(score)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ButtonOK_pressed():
	hide()
	emit_signal("ok_pressed")



func _on_Popup_focus_exited():
	$Popup.grab_focus()
