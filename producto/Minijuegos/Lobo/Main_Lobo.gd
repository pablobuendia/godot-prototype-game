extends Node2D


export(PackedScene) var pez_scene
export(PackedScene) var red_scene
var score = 0
var vida = 3

func _ready():
	randomize()

func game_over():
	$Player.monitoring = false
	$Player.monitorable= false
	$Control.visible = false
	$Player.hide()
	$FishTimer_Left.stop()
	$FishTimer_Right.stop()
	$RedTimer.stop()
	$ContenedorMonedas/TiempoDeGeneracion.stop()
	$ContenedorSalud/TiempoDeGeneracion.stop()
	$AreaLineaFinish/TiempoDeFinalizacion.stop()
	$HUD.show_game_over(score)

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
	if vida<=0:
		game_over()
	$HUD.update_vida(vida)


func _on_Player_win_vida():
	vida +=1
	$HUD.update_vida(vida)

func _game_win():
	$Player.monitoring = false
	$Player.monitorable= false
	$Control.visible = false
	$Player.hide()
	$FishTimer_Left.stop()
	$FishTimer_Right.stop()
	$RedTimer.stop()
	$ContenedorMonedas/TiempoDeGeneracion.stop()
	$ContenedorSalud/TiempoDeGeneracion.stop()
	$AreaLineaFinish/TiempoDeFinalizacion.stop()
	score +=100 #Por haber llegado al fin
	$HUD.show_game_win(score)
