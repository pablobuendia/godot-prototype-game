extends TouchScreenButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Jugador_boton_anzuelo_pressed():
	print("desactivando")
	self.action = "null"
	$AnzueloTimer.start()



func _on_AnzueloTimer_timeout():
	print("timeout")
	self.action = "Boat_rod"
	self.set_block_signals(false)

