extends Node2D


export(PackedScene) var pez_scene
export(PackedScene) var red_scene
var score = 0
var vida = 3

func _ready():
	randomize()

func game_over():
	get_tree().paused = true
	$Player.monitoring = false
	$Player.monitorable= false
	$Player.hide()
	$FishTimer_Left.stop()
	$FishTimer_Right.stop()
	$RedTimer.stop()
	$HUD.show_game_over()
	$ContenedorMonedas/TiempoDeGeneracion.stop()

func new_game():
	get_tree().paused = false
	score = 0
	vida = 3
	$Player.start($StartPosition.position)
	$Player.monitoring = true
	$Player.monitorable = true
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.update_vida(vida)
	$ContenedorMonedas/TiempoDeGeneracion.start()
	
func _on_Player_update_vida():
	vida -=1
	$HUD.update_vida(vida)
	
func _on_StartTimer_timeout():
	$FishTimer_Left.start()
	$FishTimer_Right.start()
	$RedTimer.start()
	
func _on_FishTimer_Left_timeout(): 
	spawn_pez("FishPath_Left/FishSpawnLocation", true)

func _on_FishTimer_Right_timeout(): 
	spawn_pez("FishPath_Right/FishSpawnLocation", false)	
	
func spawn_pez(spawnLocation, flip_h):
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
	
	var velocity = Vector2(rand_range(250, 350), 0.0)
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

func _on_Player_red(): #Desaparece la red cuando toca al lobo
	$Red.queue_free()
