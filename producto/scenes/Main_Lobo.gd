extends Node2D


export(PackedScene) var fish_scene
var score
var vida

func _ready():
	randomize()
	
func game_over():
	$ScoreTimer.stop()
	$FishTimer_Left.stop()
	$FishTimer_Right.stop()
	$HUD.show_game_over()

func new_game():
	score = 0
	vida = 3
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.update_vida(vida)
	
func _on_ScoreTimer_timeout():
	score += 1
	

func _on_Player_update_vida():
	vida -= 1
	$HUD.update_vida(vida)
	
func _on_StartTimer_timeout():
	$FishTimer_Left.start()
	$FishTimer_Right.start()
	$ScoreTimer.start()
	
func _on_FishTimer_Left_timeout(): #Anda bien
	# Create a new instance of the Fish scene.
	var fish = fish_scene.instance()

	# Choose a random location on Path2D.
	var fish_spawn_location = get_node("FishPath_Left/FishSpawnLocation")
	fish_spawn_location.offset = randi()
	
	var direction = fish_spawn_location.rotation + PI/2
	# Set the fish's position to a random location.
	fish.position = fish_spawn_location.position
	
	# Choose the velocity for the fish.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	fish.linear_velocity = velocity.rotated(direction)
	#fish.scale = Vector2(1.5, -1.5)
	# Spawn the fish by adding it to the Main scene.
	add_child(fish)


func _on_FishTimer_Right_timeout(): #Anda bien
	# Create a new instance of the Fish scene.
	var fish = fish_scene.instance()
	# Choose a random location on Path2D.
	var fish_spawn_location = get_node("FishPath_Right/FishSpawnLocation")
	fish_spawn_location.offset = randi()
	# Set the fish's direction perpendicular to the path direction.
	var direction = fish_spawn_location.rotation  + PI/2
	# Set the fish's position to a random location.
	fish.position = fish_spawn_location.position
	# Choose the velocity for the fish.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	fish.linear_velocity = velocity.rotated(direction)
	# Spawn the fish by adding it to the Main scene.
	add_child(fish)

func _on_Player_update_score():
	score +=1
	$HUD.update_score(score)
