extends CanvasLayer

signal start_gameFacil
signal start_gameMedio
signal start_gameDificil

onready var pause = load("res://assets/img/Iconos/pausa.png");
onready var play = load("res://assets/img/Iconos/play.png");

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
	$Niveles.show()

func _pause_pressed():
	if get_tree().paused == false:
		$TextureButton.texture_normal = play
		get_tree().paused = true
	else:
		$TextureButton.texture_normal = pause
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
	$volver.show()
	$Niveles.show()

func _desapareceComponentes():
	$ScoreLabel.hide()
	$VidaLabel.hide()
	$TextureButton.hide()

func _apareceComponentes():
	$ScoreLabel.show()
	$VidaLabel.show()
	$TextureButton.show()
	
func _on_Facil_pressed():
	emit_signal("start_gameFacil")
	$Niveles.hide()
	_apareceComponentes()


func _on_Medio_pressed():
	emit_signal("start_gameMedio")
	$Niveles.hide()
	_apareceComponentes()

func _on_Dificil_pressed():
	emit_signal("start_gameDificil")
	$Niveles.hide()
	_apareceComponentes()

func _on_volver_pressed(): 
		get_tree().change_scene("res://Mapa.tscn")
