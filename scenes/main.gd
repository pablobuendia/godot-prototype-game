extends Node2D


var time = 0
var score = 0
onready var player = $Boat
onready var bound_box = $CollisionShape2D
onready var score_label = $Control/Score

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	OS.center_window()
	bound_box.get_node("bottom").position = Vector2(bound_box.get_node("bottom").position.x,get_viewport_rect().size.y+100)
	player.position = Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y-200)
	score_label.set_position(Vector2(score_label.rect_global_position.x,get_viewport_rect().size.y-100))

func _process(delta):
	time += delta
	if (time > score):
		score+=1
		score_label.text = "Score: " + str(score)


func _on_GameOverUI_ok_pressed():
	get_tree().reload_current_scene()
