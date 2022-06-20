extends Node2D
# TODO(X): Agregar pantalla de inicio de juego
# TODO(X): Complejizar calculo de puntaje
# TODO(X): Agregar efectos de sonido a los golpes
# TODO(X): Parametrizar velocidades, spawn times, poderes del bote
# TODO(X): Agregar al menos tres modos de dificultad
# TODO(X): Limpiar y organizar codigo, extraer constantes y renombrar variables
# TODO(X): Agregar modo de pausa y de guardado de partida (aclarar una forma en comun)
# TODO(X): Redefinir controles touchscreen
# TODO(X): Redefinir controles touchscreen
# TODO(X): Limitar numero de ganchos spawneables (ahora son tantos como el jugador genere)
# TODO(X): Separar escena Bote del nodo Main
# TODO(X): Generar diferentes escalas de pez
# TODO(X): Encontrar forma de reusar misma escena pez pero con diferentes sprites
# TODO(X): Crear disparador de red y de caña de pescar
# TODO(X): Generar acumulador de puntaje
# TODO(X): Agregar pantalla de fin de juego
# TODO(X): Investigar Modo twin
# TODO(X): Parametrizar modos de juego (más/menos peces, más menos obstáculos, etc)
# TODO(X): Control para touch screen: derecha, izquierda, caña
# TODO(X): Agregar musica
# TODO(X): Agregar modo y musica de victoria
# TODO(X): Animar movimiento de peces y de pesca
# TODO(X): Ajustar colisiones entre anzuelos y peces

export(PackedScene) var pez_scene
export var DIFICULTAD = 1

# Constantes
const SPRITE_PEZ_MENU = Vector2(0.06, 0.06)

var FIN_JUEGO = false
var VOLVER = false
var PAUSAR = false
var VIDAS = 0

var peces_atrapados = [0, 0, 0, 0, 0, 0]

var tipo_pez_objetivo_1 = 3
var tipo_pez_objetivo_2 = 3
var cantidad_objetivo_1 = 0
var cantidad_objetivo_2 = 0
var cantidad_actual_1 = 0
var cantidad_actual_2 = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()

func new_game():
	cantidad_objetivo_1 = elegirCantidad()
	cantidad_objetivo_2 = elegirCantidad()
	
	tipo_pez_objetivo_1 = elegirSprite()
	tipo_pez_objetivo_2 = elegirSprite()
	while tipo_pez_objetivo_1 == tipo_pez_objetivo_2:
		tipo_pez_objetivo_2 = elegirSprite()

	var sprite1 = $Panel/Pez_objetivo1.get_child(tipo_pez_objetivo_1)
	var sprite2 = $Panel/Pez_objetivo2.get_child(tipo_pez_objetivo_2)
	sprite1.visible = true
	sprite2.visible = true
	sprite1.flip_h = true
	sprite2.flip_h = true
	sprite1.scale = SPRITE_PEZ_MENU
	sprite2.scale = SPRITE_PEZ_MENU
	
	$Panel/cantidad_label1.text = str("= ", cantidad_actual_1, " / ", cantidad_objetivo_1)
	$Panel/cantidad_label2.text = str("= ", cantidad_actual_2, " / ", cantidad_objetivo_2)
	
	VIDAS = elegirVidas()
	
	redraw_vidas()
	
	$Jugador.start($Jugador/PosicionComienzo.position)
	$StartTimer.start()
	$FondoMar.play()

func _process(delta):
	if (Input.is_action_just_pressed("move_up")):
		set_puntaje(tipo_pez_objetivo_1-3);
		set_puntaje(tipo_pez_objetivo_2-3);
	
func set_puntaje(tipo_pez_atrapado):
	$AtraparPez.play()
	if FIN_JUEGO == false:
		peces_atrapados[tipo_pez_atrapado] += 1
		
		# Actualizar cantidades de peces atrapados
		if tipo_pez_atrapado == (tipo_pez_objetivo_1 - 3):
			print("atrapo pez")
			cantidad_actual_1 += 1
			$Panel/cantidad_label1.text = str("= ", cantidad_actual_1, " / ", cantidad_objetivo_1)
		elif tipo_pez_atrapado == (tipo_pez_objetivo_2 - 3):
			cantidad_actual_2 += 1
			$Panel/cantidad_label2.text = str("= ", cantidad_actual_2, " / ", cantidad_objetivo_2)
		# Informar especie de pez atrapado
		$Info_panel/info_label.text = str("¡", GlobalVar.NOMBRES_PECES[tipo_pez_atrapado], " capturado!")
		
		# Condicion de victoria
		if cantidad_actual_1 >= cantidad_objetivo_1 && cantidad_actual_2 >= cantidad_objetivo_2:
			agregar_peces_atrapados()
			FIN_JUEGO = true
			#$info_victoria.visible = true
			$GameOverUI.show_sucess("Has ganado!"," Todos los peces atrapados!","");
			$Musica_fondo.stop()
			$Musica_victoria.play()

func agregar_peces_atrapados():
	GlobalVar.player.cantidad_peces[tipo_pez_objetivo_1 - 3] += peces_atrapados[tipo_pez_objetivo_1 - 3]
	GlobalVar.player.cantidad_peces[tipo_pez_objetivo_2 - 3] += peces_atrapados[tipo_pez_objetivo_2 - 3]
	
func redraw_vidas():
	$Info_vidas/Vidas_label.text = str("Anzuelos = ", GlobalVar.player.anzuelos)

func _on_Musica_victoria_finished():
	get_tree().paused = true
	VOLVER = true

func _on_Musica_derrota_finished():
	get_tree().paused = true
	VOLVER = true

func _on_StartTimer_timeout():
	$PezPathDer/PezSpawnTimerDer.start()
	$PezPathIzq/PezSpawnTimerIzq.start()

func _on_PezSpawnTimerIzq_timeout():
	spawn_pez("PezPathIzq/PezSpawnLocation", true)

func _on_PezSpawnTimerDer_timeout():
	spawn_pez("PezPathDer/PezSpawnLocation", false)
	
func spawn_pez(spawnLocation, flip_h):
	var nuevo_pez = pez_scene.instance()
	
	var pez_spawn_location = get_node(spawnLocation)
	pez_spawn_location.offset = randi()
	
	var tipo_elegido = elegirSprite()
	var escala_elegida = elegirEscala()
	if (tipo_elegido == tipo_pez_objetivo_1 || tipo_elegido == tipo_pez_objetivo_2):
		escala_elegida = elegirEscalaEspecial()

	nuevo_pez.start(tipo_elegido, escala_elegida, flip_h, pez_spawn_location.position, elegirVelocidad(pez_spawn_location, tipo_elegido))	
	add_child(nuevo_pez)

func elegirCantidad():
	if DIFICULTAD == 1:
		return randi() % 3 + 2
	elif DIFICULTAD == 2:
		return randi() % 3 + 5
	else:
		return randi() % 5 + 7
	
func elegirVidas():
	if DIFICULTAD == 1:
		return 7
	elif DIFICULTAD == 2:
		return 5
	else:
		return 3

func elegirSprite():
	return (randi() % 6) + 3
	
func elegirEscala():
	return ((randi() % 4) + 6) / 100.0

func elegirEscalaEspecial():
	return ((randi() % 2) + 4) / 100.0

func elegirVelocidad(pez_spawn_location, tipo_elegido):
	var velocidadPez = Vector2(rand_range(150, 250), 0.0)
	if (tipo_elegido == tipo_pez_objetivo_1 || tipo_elegido == tipo_pez_objetivo_2):
		 velocidadPez = Vector2(rand_range(250, 350), 0.0)
		
	var direccionPez = (pez_spawn_location.rotation + PI / 2) * -1
	return velocidadPez.rotated(direccionPez)

func _on_Pausar_pressed():
	if PAUSAR == false && FIN_JUEGO == false:
		get_tree().paused = true
		$Pausar.text = "Renaudar"
		PAUSAR = true
	elif PAUSAR == true && FIN_JUEGO == false:
		print("renaudar")
		PAUSAR = false
		get_tree().paused = false
		$Pausar.text = "Pausar"

func _on_Volver_pressed():
	print("volver")
	if VOLVER == true:
		print("true")
		peces_atrapados[0] = 0
		peces_atrapados[1] = 0
		peces_atrapados[2] = 0
		peces_atrapados[3] = 0
		peces_atrapados[4] = 0
		peces_atrapados[5] = 0
		get_tree().change_scene("res://Mapa.tscn")
		get_tree().paused = false
	if VOLVER == false:
		print("false")
		VOLVER = true
		$Volver.text = "¿Seguro?"


func _on_Jugador_decrement_anzuelo():
	redraw_vidas()


func _on_GameOverUI_back_menu():
	GlobalVar.player.pesca = true;
	GlobalVar.save_game();
	get_tree().paused = false;
	get_tree().change_scene("res://Mapa.tscn");
