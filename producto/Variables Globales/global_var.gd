extends Node


var MONEDAS = 0
var PRECIO_ANZUELO = 3
var NOMBRES_PECES = ["Besugo", "Besugo Rojo", "Bonito", "Caballa", "Limon", "Mero"]
var COLECCIONABLE_1 = false
var PRECIO_COLECCIONABLE_1 = 3000
var COLECCIONABLE_2 = false 
var PRECIO_COLECCIONABLE_2 = 10000
var CANTIDAD_PECES = [0,0,0,0,0,0]
var PRECIOS_PECES = [20, 30, 40, 45, 50, 60]
var ANZUELOS = 50


const SAVE_PATH = "user://saves.sav"

var player = {
	"username":"",
	"score":0,
	"moneda":0
}

func save_game():
	var save_game = File.new()
	save_game.open(SAVE_PATH, File.WRITE)
	save_game.store_line(to_json(player))
	save_game.close()
	

func load_game():
	var save_game = File.new()
	if not save_game.file_exists(SAVE_PATH):
		return # Error! No hay archivo que guardar
	save_game.open(SAVE_PATH, File.READ)
	player = parse_json(save_game.get_line())
	save_game.close()
