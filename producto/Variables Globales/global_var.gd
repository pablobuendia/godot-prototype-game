extends Node

const SAVE_PATH = "user://saves.sav"

var PRECIO_ANZUELO = 3
var NOMBRES_PECES = ["Besugo", "Besugo Rojo", "Bonito", "Caballa", "Limon", "Mero"]
var PRECIOS_PECES = [20, 30, 40, 45, 50, 60]
var LOBO_NIVEL = 0 #0 facil,1 medio y 2 dificil, es para sumarle una cierta cantidad de monedas
var LOBO_FACIL = 10
var LOBO_MEDIO = 20
var LOBO_DIFICIL = 30
var PRECIO_COLECCIONABLE_LOBO_AZUL = 980
var PRECIO_COLECCIONABLE_LOBO_ROSA = 980
var PRECIO_COLECCIONABLE_BARCO = 1500
var PRECIO_COLECCIONABLE_VELERO = 2000
var SALUD_BASE_BOTE = 200.0
var PRECIO_MEJORA_BARCO_1 = 300


var player = {
	"username":"",
	"monedas":0,
	"coleccionable_lobo_azul":false,
	"coleccionable_lobo_rosa":false,
	"coleccionable_barco":false,
	"coleccionable_velero":false,
	"cantidad_peces":[0,0,0,0,0,0],
	"anzuelos":50,
	"banderaInicio":false,
	"lancha":false,
	"pesca":false,
	"lobo":false,
	"musica":true,
	"pinturas" : [0,0,0,0],
	"mejora_barco_1":false
}

func save_game():
	var save_game = File.new()
	save_game.open(SAVE_PATH, File.WRITE)
	save_game.store_line(to_json(player))
	save_game.close()
	

func load_game():
	var save_game = File.new()
	if not save_game.file_exists(SAVE_PATH):
		return null# Error! No hay archivo que guardar
	save_game.open(SAVE_PATH, File.READ)
	player = parse_json(save_game.get_line())
	save_game.close()
	return 1

func config(): #configuracion inicial
	player = {
		"username":"",
		"monedas":0,
		"coleccionable_lobo_azul":false,
		"coleccionable_lobo_rosa":false,
		"coleccionable_barco":false,
		"coleccionable_velero":false,
		"cantidad_peces":[0,0,0,0,0,0],
		"anzuelos":50,
		"banderaInicio":false,
		"lancha":false,
		"pesca":false,
		"lobo":false,
		"musica":true,
		"pinturas" : [0,0,0,0],
		"mejora_barco_1":false
	}

