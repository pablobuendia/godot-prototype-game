extends Node2D


var time = 0
export var completion_time=30
onready var player = $Boat
onready var bound_box = $CollisionShape2D
onready var progress_bar = $UI/ProgressBar
onready var progress_bar2 = $UI/ProgressBarBG
onready var label_progress = $UI/Score2
onready var collision_limits = $CollisionLimits
onready var progress_bar_base_length = progress_bar.get_rect().size.x

var cleaned = false
var score = 0

export var mar_abierto = false

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.center_window()
	if (GlobalVar.player.musica):
		$Musica_fondo.play()
	$Cloud.position = Vector2(878.952,-877.416)
	get_tree().paused = true
	progress_bar.hide()
	progress_bar2.hide()
	label_progress.hide()
	collision_limits.hide()
	load_pinturas()
	$UI/DialogUI.show()
	
func _process(delta):
	if (mar_abierto):
		
		if (!cleaned):
			progress_bar.show()
			progress_bar2.show()
			label_progress.show()
			collision_limits.position = player.position
			collision_limits.show()
			cleaned = true
		time += delta
		if (time < completion_time):
			progress_bar.value = (time*1.0/completion_time)*100
		else:
			get_node("UI/Score").hide()
			get_node("UI/HealthBar").hide()
			get_node("UI/HealthBarBG").hide()
			progress_bar.hide()
			progress_bar2.hide()
			label_progress.hide()
			get_tree().paused = true
			score = (player.health*1.0/player.base_health)*500
			GlobalVar.player.lancha = true
			get_node("GameOverUI").show_sucess("Llegaste al final!","Final Score: ", score)
	else:
		$Camera2D.position = $Boat.position

func _on_GameOverUI_ok_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_Control_dialog_terminated():
	get_tree().paused = false
	$UI/DialogUI.hide()


func _on_GameOverUI_back_menu():
	GlobalVar.player.monedas = GlobalVar.player.monedas + score / 10
	GlobalVar.save_game();
	get_tree().paused = false
	print(get_tree().paused)
	get_tree().change_scene("res://Mapa.tscn")


func _on_Painting1_body_entered(body):
	if (body.is_in_group("player")):
		$Boat.position = $InitialPosition.position
		$Painting1.queue_free()
		GlobalVar.player.pinturas[0] = 1
		GlobalVar.save_game()
		check_pinturas(1)
		get_tree().paused = true


func _on_SecretGUI_ok_pressed():
	get_tree().paused = false


func _on_Painting2_body_entered(body):
	#$Boat.position = $InitialPosition.position
	if (body.is_in_group("player")):
		$Painting2.queue_free()
		GlobalVar.player.pinturas[1] = 1
		GlobalVar.save_game()
		check_pinturas(2)
		get_tree().paused = true


func _on_Painting3_body_entered(body):
	#$Boat.position = $InitialPosition.position
	if (body.is_in_group("player")):
		$Painting3.queue_free()
		GlobalVar.player.pinturas[2] = 1
		GlobalVar.save_game()
		check_pinturas(3)
		get_tree().paused = true


func _on_Painting4_body_entered(body):
	#$Boat.position = $InitialPosition.position
	if (body.is_in_group("player")):
		$Painting4.queue_free()
		GlobalVar.player.pinturas[3] = 1
		GlobalVar.save_game()
		check_pinturas(4)
		get_tree().paused = true

func check_pinturas(pintura):
	var pinturas = 0
	for a in GlobalVar.player.pinturas:
		pinturas += a;
	if (pinturas >= 4):
		$SecretGUI.show_secret("Encontraste todas las pinturas!", 0)
		GlobalVar.player.monedas += 1000
	else:
		$SecretGUI.show_secret(null,pintura)
	GlobalVar.save_game()

func load_pinturas():
	if (GlobalVar.player.pinturas[0] == 0):
		$Painting1/AnimationPlayer.play("Idle")
		$Painting1.show()
	else:
		$Painting1.queue_free()
	if (GlobalVar.player.pinturas[1] == 0):
		$Painting2/AnimationPlayer.play("Idle")
		$Painting2.show()
	else:
		$Painting2.queue_free()
	if (GlobalVar.player.pinturas[2] == 0):
		$Painting3/AnimationPlayer.play("Idle")
		$Painting3.show()
	else:
		$Painting3.queue_free()
	if (GlobalVar.player.pinturas[3] == 0):
		$Painting4/AnimationPlayer.play("Idle")
		$Painting4.show()
	else:
		$Painting4.queue_free()


func _on_AreaMarAbierto_body_entered(body):
	if (!body.is_in_group("scenary") && !mar_abierto):
		mar_abierto = true
