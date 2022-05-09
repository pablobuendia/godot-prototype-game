extends Node2D


export(PackedScene) var fish_scene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_hit():
	pass # Replace with function body.
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
func _on_ScoreTimer_timeout():
	score += 1

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	
func _on_FishTimer_timeout():
	# Create a new instance of the Fish scene.
	var fish = fish_scene.instance()

	# Choose a random location on Path2D.
	var fish_spawn_location = get_node("FishPath/FishSpawnLocation")
	fish_spawn_location.offset = randi()

	# Set the fish's direction perpendicular to the path direction.
	var direction = fish_spawn_location.rotation + PI / 2

	# Set the fish's position to a random location.
	fish.position = fish_spawn_location.position

	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	fish.rotation = direction

	# Choose the velocity for the fish.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	fish.linear_velocity = velocity.rotated(direction)

	# Spawn the fish by adding it to the Main scene.
	add_child(fish)
