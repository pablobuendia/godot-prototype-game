extends Node2D
const fish_scene = preload("res://Fish.tscn")
var fishes = [null,null,null,null]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_meat_pressed():
	$Control.animate(1)
	create_meat()
	
func create_meat():
	for i in range(4):
		if fishes[i] == null :
			var fish = fish_scene.instance()
			fish.set_position(i + 1)
			self.add_child(fish)
			fishes[i] = fish
			return
