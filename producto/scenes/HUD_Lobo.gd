extends CanvasLayer

signal start_game

func show_game_over():
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func update_vida(vida):
	$VidaLabel.text = str(vida)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
