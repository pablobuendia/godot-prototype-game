extends Node2D
# TODO(X): Separar escena Bote del nodo Main
# TODO(X): Generar diferentes escalas de pez
# TODO(X): Encontrar forma de reusar misma escena pez pero con diferentes sprites
# TODO: Spawnear obstaculos que no sumen puntos (o que resten)
# TODO(X): Crear disparador de red y de caña de pescar
# TODO(X): Generar acumulador de puntaje
# TODO: Agregar pantalla de inicio de juego
# TODO(X): Agregar pantalla de fin de juego
# TODO(X): Investigar Modo twin
# TODO(X): Parametrizar modos de juego (más/menos peces, más menos obstáculos, etc)
# TODO(X): Control para touch screen: derecha, izquierda, caña
# TODO(X): Agregar musica
# TODO: Agregar efectos de sonido a los golpes
# TODO(X): Agregar modo y musica de victoria
# TODO: Parametrizar velocidades, spawn times, poderes del bote
# TODO: Agregar al menos tres modos de dificultad
# TODO(X): Animar movimiento de peces y de pesca
# TODO(X): Ajustar colisiones entre anzuelos y peces
# TODO: Limpiar y organizar codigo, extraer constantes y renombrar variables
# TODO: Agregar modo de pausa y de guardado de partida (aclarar una forma en comun)
# TODO: Redefinir controles touchscreen
# TODO: Limitar numero de ganchos spawneables (ahora son tantos como el jugador genere)
# TODO: Definir al menos otro poder (super anzuelo con poderes o lluvia de anzuelos)

export(PackedScene) var pez_scene
export var puntaje = 0
export var PUNTAJE_VICTORIA = 100
var VICTORIA = 0
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Comienza el juego...")
	randomize()
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_puntaje():
	return puntaje
	
func set_puntaje(nuevo_puntaje):
	if VICTORIA == 0:
		puntaje = nuevo_puntaje
		$Puntaje_valor.text = String(puntaje)
		if puntaje >= PUNTAJE_VICTORIA:
			VICTORIA = 1
			$Label_victoria.visible = true
			$Musica_victoria.play()

func _on_Musica_victoria_finished():
	get_tree().paused = true

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
	# Seleccionar sprite y hacerlo visible
	var pezSprite = randi() % 6 + 3
	var escalaPez = ((randi() % 7) + 3) / 100.0
	
	var pez = pez_scene.instance()
	pez.start(pezSprite, escalaPez, flip_h)
	
	var pez_spawn_location = get_node(spawnLocation)
	pez_spawn_location.offset = randi()
	pez.position = pez_spawn_location.position
	var velocidadPez = Vector2(rand_range(150, 250), 0.0)
	var direccionPez = (pez_spawn_location.rotation + PI / 2) * -1
	pez.linear_velocity = velocidadPez.rotated(direccionPez)
	
	add_child(pez)
