extends CanvasLayer


signal ok_pressed
signal back_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func hide():
	$PopupDeath.hide()
	$PopupSuccess.hide()
	$BackShadow.hide()

func show_death(score):
	$BackShadow.show()
	$PopupDeath.popup_exclusive = true
	$PopupDeath.popup_centered($PopupDeath/ColorRect.get_rect().size)
	$PopupDeath/Label2.text = "Final Score: "+str(score)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show_sucess(title, message, score):
	$BackShadow.show()
	$PopupSuccess.popup_exclusive = true
	$PopupSuccess.popup_centered($PopupSuccess/ColorRect.get_rect().size)
	$PopupSuccess/Title.text = title; 
	$PopupSuccess/Label2.text = message+str(score)


func _on_ButtonOK_pressed():
	hide()
	$Button_click.play()
	emit_signal("ok_pressed")



func _on_Popup_focus_exited():
	$Popup.grab_focus()


func _on_ButtonOK2_pressed():
	$Button_click.play()
	emit_signal("back_menu")
	
