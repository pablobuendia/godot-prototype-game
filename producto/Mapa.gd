extends Node2D

func _ready():
	pass # Replace with function body.

func _on_Lancha_pressed():
	get_tree().change_scene("res://Minijuegos/Lanchas/scenes/main.tscn")


func _on_Lobo_pressed():
	get_tree().change_scene("res://Minijuegos/Lobo/Main_Lobo.tscn")


func _on_Pesca_pressed():
	get_tree().change_scene("res://Minijuegos/Pesca/Pesca-Main.tscn")


func _on_Tienda_pressed():
	get_tree().change_scene("res://Tienda.tscn")
	

func _on_Restaurante_pressed():
	get_tree().change_scene("res://Restaurante.tscn")
	
