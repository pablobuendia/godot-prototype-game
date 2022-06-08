extends CanvasLayer

signal start_game

func show_game_over(score):
	_desapareceComponentes()
	$Juego_Perdido.show()
	$JugarDeNuevo.show()
	$Juego_Perdido/ScoreFinish.text = str(score)
	
func update_score(score):
	$ScoreLabel.text = str(score)

func update_vida(vida):
	$VidaLabel.text = str(vida)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func _pause_pressed():
	if get_tree().paused == false:
		get_tree().paused = true
	else:
		get_tree().paused = false

func show_game_win(score):
	_desapareceComponentes()
	$Juego_Ganado.show()
	$Juego_Ganado/ScoreFinish.text = str(score)
	$JugarDeNuevo.show()


func _on_JugarDeNuevo_pressed():
	$JugarDeNuevo.hide()
	if $Juego_Ganado.visible == true:
		$Juego_Ganado.hide()
	else:
		$Juego_Perdido.hide()
	$ScoreLabel.show()
	$VidaLabel.show()
	$TextureButton.show()
	emit_signal("start_game")

func _desapareceComponentes():
	$ScoreLabel.hide()
	$VidaLabel.hide()
	$TextureButton.hide()
	
func _on_Facil_pressed():
	pass # Replace with function body.


func _on_Medio_pressed():
	pass # Replace with function body.


func _on_Dificil_pressed():
	pass # Replace with function body.
