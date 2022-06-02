extends Node2D


var time = 0
export var completion_time=30
onready var player = $Boat
onready var bound_box = $CollisionShape2D
onready var progress_bar = $UI/ProgressBar
onready var progress_bar2 = $UI/ProgressBarBG
onready var label_progress = $UI/Score2
onready var progress_bar_base_length = progress_bar.get_rect().size.x

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	OS.center_window()
	progress_bar.hide()
	progress_bar2.hide()
	label_progress.hide()

func _process(delta):
	if ($Boat.mar_abierto):
		time += delta
		progress_bar.show()
		progress_bar2.show()
		label_progress.show()
		if (time < completion_time):
			progress_bar.set_size(Vector2((time*1.0/completion_time)*progress_bar_base_length,progress_bar.get_rect().size.y))
		else:
			get_node("UI/Score").hide()
			get_node("UI/HealthBar").hide()
			get_node("UI/HealthBarBG").hide()
			get_tree().paused = true
			get_node("GameOverUI").show_sucess(($Boat.health*1.0/$Boat.base_health)*500)


func _on_GameOverUI_ok_pressed():
	get_tree().reload_current_scene()


func _on_Control_dialog_terminated():
	get_tree().paused = false
	$UI/Control.hide()
