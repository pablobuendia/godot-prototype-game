extends Node2D
# TODO(X): Separar escena Bote del nodo Main
# TODO(X): Generar diferentes escalas de pez
# TODO(X): Encontrar forma de reusar misma escena pez pero con diferentes sprites
# TODO: Spawnear obstaculos que no sumen puntos
# TODO(X): Crear disparador de red y de caña de pescar
# TODO: Generar acumulador de puntaje
# TODO: Agregar pantalla de inicio y de fin de juego
# TODO: Investigar Modo twin
# TODO(X): Parametrizar modos de juego (más/menos peces, más menos obstáculos, etc)
# TODO(X): Control para touch screen: derecha, izquierda, caña
# TODO(X): Agregar musica
# TODO: Agregar efectos de sonido a los golpes
# TODO: Agregar modo de victoria
# TODO: Parametrizar velocidades, spawn times, poderes del bote

export(PackedScene) var pez_scene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Comienza el juego...")
	randomize()
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_game():
	score = 0
	$Jugador.start($PosicionComienzo.position)
	$StartTimer.start()

func _on_StartTimer_timeout():
	$PezSpawnTimerDer.start()
	$PezSpawnTimerIzq.start()

func _on_PezSpawnTimerIzq_timeout():
	spawn_pez("PezPathIzq/PezSpawnLocation", true)

func _on_PezSpawnTimerDer_timeout():
	spawn_pez("PezPathDer/PezSpawnLocation", false)
	
func spawn_pez(spawnLocation, flip_h):
	var pez = pez_scene.instance()
	var pezTipo = randi() % 6
	var scaleMultiplier = ((randi() % 7) + 3) / 100.0
	print(scaleMultiplier)
	print("------")
	print(pezTipo)
	
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


func _on_Button_left_pressed():
	print("p")
