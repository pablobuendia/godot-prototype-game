extends Node

const SAVE_PATH = "user://saves.sav"

var PRECIO_ANZUELO = 3
var NOMBRES_PECES = ["Besugo", "Besugo Rojo", "Bonito", "Caballa", "Limon", "Mero"]
var PRECIOS_PECES = [20, 30, 40, 45, 50, 60]
var LOBO_NIVEL = 0 #0 facil,1 medio y 2 dificil, es para sumarle una cierta cantidad de monedas
var LOBO_FACIL = 100
var LOBO_MEDIO = 150
var LOBO_DIFICIL = 200
var PRECIO_COLECCIONABLE_1 = 3000
var PRECIO_COLECCIONABLE_2 = 10000

var player = {
	"username":"",
	"monedas":0,
	"coleccionable_1":false,
	"coleccionable_2":false,
	"cantidad_peces":[0,0,0,0,0,0],
	"anzuelos":50,
	"banderaInicio":false,
	"lancha":false,
	"pesca":false,
	"lobo":false
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
		"coleccionable_1":false,
		"precio_coleccionable_1":3000,
		"coleccionable_2":false,
		"precio_coleccionable_2":10000,
		"cantidad_peces":[0,0,0,0,0,0],
		"anzuelos":50,
		"banderaInicio":false,
		"lancha":false,
		"pesca":false,
		"lobo":false
	}

