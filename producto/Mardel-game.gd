extends Node2D
# TODO: Separar escena Bote del nodo Main
# TODO: Generar diferentes escalas de pez
# TODO: Encontrar forma de reusar misma escena pez pero con diferentes sprites
# TODO: Spawnear obstaculos que no sumen puntos
# TODO: Crear disparador de red y de caña de pescar
# TODO: Generar acumulador de puntaje
# TODO: Agregar pantalla de inicio y de fin de juego
# TODO: Investigar Modo twin
# TODO: Parametrizar modos de juego (más/menos peces, más menos obstáculos, etc)

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
	$StartTimer.start()

func _on_StartTimer_timeout():
	$PezTimerIzq.start()
	$PezTimerDer.start()

func _on_PezTimerIzq_timeout():
	var pez = pez_scene.instance()
	
	var pez_spawn_location = get_node("PezPathIzq/PezSpawnLocation")
	pez_spawn_location.offset = randi()
	
	var direction = (pez_spawn_location.rotation + PI / 2) * -1
	
	pez.position = pez_spawn_location.position
	
	var velocity = Vector2(rand_range(150, 250), 0.0)
	pez.linear_velocity = velocity.rotated(direction)
	
	pez.scale = Vector2(-1.0, 1.0)
	
	add_child(pez)

func _on_PezTimerDer_timeout():
	var pez = pez_scene.instance()
	
	var pez_spawn_location = get_node("PezPathDer/PezSpawnLocation")
	pez_spawn_location.offset = randi()
	
	var direction = pez_spawn_location.rotation + PI / 2
	
	pez.position = pez_spawn_location.position
	
	var velocity = Vector2(rand_range(150, 250), 0.0)
	pez.linear_velocity = velocity.rotated(direction)
	
	add_child(pez)
