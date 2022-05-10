extends Node

var wait_time_welldone = 3
var wait_time_scorched = 12
var game_time = 60
var level = 0

var score = 0

func _ready():
	pass

func set_score(recive_score) :
	score = recive_score

func set_level(recive_level):
	level = recive_level

func get_score() :
	return score

func get_wait_time_welldone() :
	match level:
		0:
			return wait_time_welldone
		1:
			return wait_time_welldone

func get_wait_time_scorched() :
	match level:
		0:
			return wait_time_scorched
		1:
			return wait_time_scorched-5

func get_gmae_time() :
	return game_time+1

