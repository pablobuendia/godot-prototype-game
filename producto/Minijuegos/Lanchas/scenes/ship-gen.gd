extends Node2D

export(PackedScene) var SHIP
export(PackedScene) var LOBO
export(PackedScene) var HOOK
export(PackedScene) var CLOUD

onready var boat = get_parent().get_node("Boat")
#const SHIP = preload("res://assets/Ship.tscn")
#const LOBO = preload("res://Minijuegos/Lanchas/scenes/entities/LoboMarino.tscn")

var time1 = 0
var time2 = 0
var time3 = 6
var time_to_next = 2
var time_to_hook = 7
var time_to_cloud = 12
var max_time = 5
var min_time = 2
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.

func _process(delta):
	var camera = get_parent().get_node("Camera2D")
	var port = get_viewport().get_visible_rect().size
	time1 += delta
	time2 += delta
	time3 += delta
	if time1 > time_to_next && get_parent().mar_abierto:
		time1  = 0
		time_to_next = rng.randf_range(min_time, max_time)
		
		var ship = SHIP.instance()
		var lobo = LOBO.instance()
		
		
		var scale = rng.randf_range(0.8,1.8)
		var pos = Vector2(boat.position.x-1200,boat.position.y)
		
		
		lobo.init(2,camera.position+Vector2(rng.randf_range(-port.x/2,port.x/2),-port.y),0)
		ship.init(scale,pos,1)
		

		add_child(lobo)
		add_child(ship)
		
		if max_time > 2.2:
			max_time-=0.2
		else:
			if min_time > 0.8:
				min_time-=0.2
	if time2 > time_to_hook && get_parent().mar_abierto:
		time2 = 0
		var hook = HOOK.instance()
		hook.init(1,camera.position+Vector2(-port.x,rng.randf_range(-port.y/2,port.y/2)),1)
		hook.set_speed(2.5)
		add_child(hook)
	if time3 > time_to_cloud && get_parent().mar_abierto:
		time3 = 0
		var cloud = CLOUD.instance()
		cloud.init(2,camera.position+Vector2(rng.randf_range(-port.x/2,port.x/2),-port.y),0)
		cloud.set_speed(1)
		add_child(cloud)
