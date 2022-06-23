extends Node2D

export(PackedScene) var SHIP
export(PackedScene) var LOBO
onready var boat = get_parent().get_node("Boat")
#const SHIP = preload("res://assets/Ship.tscn")
#const LOBO = preload("res://Minijuegos/Lanchas/scenes/entities/LoboMarino.tscn")

var time = 0
var time_to_next = 2
var max_time = 5
var min_time = 2
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.

func _process(delta):
	time += delta
	if time > time_to_next && get_parent().mar_abierto:
		time  = 0
		time_to_next = rng.randf_range(min_time, max_time)
		
		var ship = SHIP.instance()
		var lobo = LOBO.instance()
		
		var scale = rng.randf_range(0.1,2.8)
		var pos = Vector2(boat.position.x-1200,boat.position.y)
		
		
		lobo.init(1,Vector2(0,get_viewport_rect().size.x/2),1)
		ship.init(scale,pos,1)
		
		add_child(lobo)
		add_child(ship)
		
		if max_time > 2.2:
			max_time-=0.2
		else:
			if min_time > 0.8:
				min_time-=0.2
		#print(Vector2(min_time,max_time))
