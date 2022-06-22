extends Node2D


export(PackedScene) var pez_scene
export(PackedScene) var red_scene
var score = 0
var vida = 3
var index = 0

func _ready():
	OS.center_window()
	if (GlobalVar.player.musica):
		$Musica_fondo.play();
	if(GlobalVar.player.lobo == false):
		$Intro/AnimationPlayer.play("AnchorIdle")
	randomize()

func game_over():
	set_deferred("monitoring",false)
	set_deferred("monitorable",false)
	$Control.visible = false
	$Player.hide()
	$FishTimer_Left.stop()
	$FishTimer_Right.stop()
	$RedTimer.stop()
	$ContenedorMonedas/TiempoDeGeneracion.stop()
	$ContenedorSalud/TiempoDeGeneracion.stop()
	$AreaLineaFinish/TiempoDeFinalizacion.stop()
	$HUD.show_game_over(score)
	GlobalVar.player.monedas = GlobalVar.player.monedas + score
	GlobalVar.save_game()

func new_game():
	score = 0
	vida = 3
	$Control.visible = true
	$Player.start($StartPosition.position)
	$Player.monitoring = true
	$Player.monitorable = true
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.update_vida(vida)
	$ContenedorMonedas/TiempoDeGeneracion.start()
	$ContenedorSalud/TiempoDeGeneracion.start()
	$AreaLineaFinish/TiempoDeFinalizacion.start()
	
func _on_StartTimer_timeout():
	$FishTimer_Left.start()
	$FishTimer_Right.start()
	$RedTimer.start()
	
func _on_FishTimer_Left_timeout(): 
	spawn_pez("FishPath_Left/FishSpawnLocation", true,"left") #lado izq

func _on_FishTimer_Right_timeout(): 
	spawn_pez("FishPath_Right/FishSpawnLocation", false,"right")	#lado der
	
func spawn_pez(spawnLocation, flip_h,side):
	var pez = pez_scene.instance()
	var pezTipo = randi() % 6
	var scaleMultiplier = ((randi() % 7) + 3) / 100.0

	pez.get_child(pezTipo).visible = true
	pez.get_child(pezTipo).flip_h = flip_h
	pez.get_child(pezTipo).scale = Vector2(scaleMultiplier, scaleMultiplier)
	pez.get_child(4).scale = Vector2(scaleMultiplier, scaleMultiplier)
	pez.scale = Vector2(scaleMultiplier, scaleMultiplier)
	var pez_spawn_location = get_node(spawnLocation)
	pez_spawn_location.offset = randi()
	
	var direction = (pez_spawn_location.rotation + PI / 2) * -1
	
	pez.position = pez_spawn_location.position
	if side == "right":
		var velocity = Vector2(rand_range(400, 600), 0.0)
		pez.linear_velocity = velocity.rotated(direction)
	else:
		var velocity = Vector2(rand_range(250,400), 0.0)
		pez.linear_velocity = velocity.rotated(direction)
	
	add_child(pez)
	
func _on_Player_update_score():
	score +=1
	$HUD.update_score(score)


func _on_RedTimer_timeout():
	var red = red_scene.instance()
	var redTipo = randi() % 4

	red.get_child(redTipo).visible = true
	var red_spawn_location = get_node("RedPath/RedSpawnLocation")
	red_spawn_location.offset = randi()
	
	var direction = (red_spawn_location.rotation + PI / 2) * -1
	
	red.position = red_spawn_location.position
	
	var velocity = Vector2(0.0,rand_range(0, 100))
	red.linear_velocity = velocity.rotated(direction)
	add_child(red)

func _on_Player_miss_vida():
	vida -=1
	Input.vibrate_handheld(500)
	if vida<=0:
		set_deferred("monitoring",false)
		set_deferred("monitorable",false)
		game_over()
	$HUD.update_vida(vida)


func _on_Player_win_vida():
	vida +=1
	$HUD.update_vida(vida)

func _game_win():
	set_deferred("monitoring",false)
	set_deferred("monitorable",false)
	$Control.hide()
	$Player.hide()
	$FishTimer_Left.stop()
	$FishTimer_Right.stop()
	$RedTimer.stop()
	$ContenedorMonedas/TiempoDeGeneracion.stop()
	$ContenedorSalud/TiempoDeGeneracion.stop()
	$AreaLineaFinish/TiempoDeFinalizacion.stop()
	if (GlobalVar.LOBO_NIVEL == 0):
		score +=GlobalVar.LOBO_FACIL #Por haber llegado al fin
	else:
		if(GlobalVar.LOBO_NIVEL == 1):
			score +=GlobalVar.LOBO_MEDIO
		else:
			score +=GlobalVar.LOBO_DIFICIL
	$HUD.show_game_win(score)
	GlobalVar.player.monedas = GlobalVar.player.monedas + score
	GlobalVar.save_game()
	
func _on_HUD_start_gameDificil():
	$ContenedorMonedas/TiempoDeGeneracion.wait_time = 3
	$ContenedorSalud/TiempoDeGeneracion.wait_time = 40
	$AreaLineaFinish/TiempoDeFinalizacion.wait_time = 100
	$FishTimer_Left.wait_time = 2
	$FishTimer_Right.wait_time = 9
	$RedTimer.wait_time = 3
	GlobalVar.LOBO_NIVEL = 2
	new_game()


func _on_HUD_start_gameMedio():
	$ContenedorMonedas/TiempoDeGeneracion.wait_time = 2
	$ContenedorSalud/TiempoDeGeneracion.wait_time = 35
	$AreaLineaFinish/TiempoDeFinalizacion.wait_time = 80
	$FishTimer_Left.wait_time = 2
	$FishTimer_Right.wait_time = 8
	$RedTimer.wait_time = 4
	GlobalVar.LOBO_NIVEL = 1
	new_game()


func _on_HUD_start_gameFacil():
	$ContenedorMonedas/TiempoDeGeneracion.wait_time = 1
	$ContenedorSalud/TiempoDeGeneracion.wait_time = 30
	$AreaLineaFinish/TiempoDeFinalizacion.wait_time = 60
	$FishTimer_Left.wait_time = 5
	$FishTimer_Right.wait_time = 10
	$RedTimer.wait_time = 5
	GlobalVar.LOBO_NIVEL = 0
	new_game()


var frases = ["Te explico cómo se juega!","Tenes que equivar todo tipo de red",
"Cuidado con caerte al suelo! Podes perder una vida si te caes al suelo",
"Además, tenes que recoger la mayor cantidad de monedas!",
"Habrá una ayuda para darte una vida más!","Listo " + GlobalVar.player.username + " para jugar? ",
"¡Mucha suerte!"]

func _on_Panel_pressed():
	if (index < frases.size()):
		$Intro/Panel/RichTextLabel.text = frases[index]
		index+=1
	else:
		$Intro.hide()
		GlobalVar.player.lobo = true
		$HUD/StartButton.show()
