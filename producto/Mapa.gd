extends Node2D

var index = 0

func _ready():
	$Anzuelos.text = str(GlobalVar.player.anzuelos) 
	$Monedas.text = str(GlobalVar.player.monedas)
	$NamePlayer.text = GlobalVar.player.username
	if(GlobalVar.player.banderaInicio == false): #Ya jugó antes?
		frases = frases_intro;
		load_frases();
		$Tap/AnimationTap.play("Lanchas")
		$Intro.show()
		$Intro/AnimationPlayer.play("AnchorIdle")
	if(GlobalVar.player.lancha==true):
		if (GlobalVar.player.pesca==false):
			frases = frases_post_lancha;
			$Intro.show()
			$Intro/AnimationPlayer.play("AnchorIdle")
			$Tap/AnimationTap.play("pesca")
		else:
			if(GlobalVar.player.lobo==false):
				frases = frases_post_pesca;
				$Intro.show()
				$Intro/AnimationPlayer.play("AnchorIdle")
				$Tap/AnimationTap.play("Lobos")
		load_frases();
	if(GlobalVar.player.monedas >= 500):
		frases = frases_colecciones;
		$Intro.show()
		$Intro/AnimationPlayer.play("AnchorIdle")
		#Iria la animationPlayer de tienda
		load_frases();
	if(GlobalVar.player.monedas <= 50 && GlobalVar.player.banderaInicio == true && GlobalVar.player.lobo == true):
		frases = frases_lobo_monedas
		$Intro.show()
		$Intro/AnimationPlayer.play("AnchorIdle")
		$Tap/AnimationTap.play("Lobos")
		load_frases();
	if(GlobalVar.player.anzuelos == 0):
		frases = frases_lobo_anzuelos
		$Intro.show()
		$Intro/AnimationPlayer.play("AnchorIdle")
		#Iria la animationPlayer de tienda
		load_frases();
func _on_Lancha_pressed():
	$Tap.hide()
	get_tree().change_scene("res://Minijuegos/Lanchas/scenes/main.tscn")
	GlobalVar.player.banderaInicio = true
	#GlobalVar.player.lancha = true
	
func _on_Lobo_pressed():
	if (GlobalVar.player.lancha && GlobalVar.player.pesca):
		GlobalVar.player.lobo = true
		get_tree().change_scene("res://Minijuegos/Lobo/Main_Lobo.tscn")

func _on_Pesca_pressed():
	if (GlobalVar.player.lancha):
		$Tap.hide()
		get_tree().change_scene("res://Minijuegos/Pesca/Pesca-Main.tscn")
	#GlobalVar.player.pesca = true
	
func _on_Tienda_pressed():
	get_tree().change_scene("res://Tienda.tscn")
	
func _on_Restaurante_pressed():
	get_tree().change_scene("res://Restaurante.tscn")
	
var frases = [];

var frases_intro = ["¡Bienvenido " + GlobalVar.player.username + " al Puerto de Mar del Plata!",
"¿Querés hacer un negocio GENIAL?","¡Genial! Te explico cómo es!", 
"¿Cómo ganar monedas?", "¡Andá a pescar para que los vendas al restaurante!",
"Pero primero!!! Tenés que recorrer en el barco para pescar!",
"¡Mucha suerte!"];

var frases_post_lancha = ["Estupendo! has logrado llegar a mar profundo en el barco.",
"Ahora es tu turno de pescar"];

var frases_post_pesca = ["Esa es una buena cantidad de pescado!",
"Puedes venderlos en el restaurante",
"Recuerda tambien comprar anzuelos en la tienda!", 
"OH NO!!","Un lobo marino se ha ido demasiado lejos del puerto!",
"Puedes ayudarlo a volver?"];

var frases_lobo_anzuelos = ["¿Te quedaste sin anzuelos?",
"Puedes comprar mas en la tienda!!!"];

var frases_lobo_monedas = ["¿Te quedaste con pocas monedas o casi nada?",
"Puedes ayudar al lobito marino a escapar!!", 
"Obviamente, a cambio de unas monedas!!!","Mucha suerte!!"];

var frases_colecciones = ["WOW!! Parece que te va muy bien!!!",
"Puedes comprar recuerdos del Puerto de Mar del Plata en la tienda!!!", 
"Que los disfrutes!"];

func _on_Panel_pressed():
	if (index < frases.size()):
		$Intro/Panel/RichTextLabel.text = frases[index]
		index+=1
	else:
		$Intro.hide()

func _on_Volver_pressed():
	get_tree().change_scene("res://Main-Menu.tscn");

func load_frases():
	if (frases.size()>0):
		$Intro/Panel/RichTextLabel.text = frases[0];
