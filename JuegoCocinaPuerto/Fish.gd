extends Node2D


var fish_time = 0
var wait_time_welldone
var wait_time_scorched
var state = 0
var one_time_loop_state1 = 0
var one_time_loop_state2 = 0
var progress_welldone
var progress_scorched


func _init():
	position.x = -20
	position.y = -20
	
	wait_time_welldone = 3
	wait_time_scorched = 12
	progress_welldone = 100/wait_time_welldone
	progress_scorched = 100/wait_time_scorched

# Called when the node enters the scene tree for the first time.
func _process(delta):
	meat_state()

func set_position(posit):
	if posit == 1 :
		position.x = 346
		position.y = 693
	elif posit == 2 :
		position.x = 545
		position.y = 704
	elif posit == 3 :
		position.x = 446
		position.y = 569
	elif posit == 4 :
		position.x = 625
		position.y = 577

func now_state():
	return(state)

func meat_state():
	if (fish_time > wait_time_welldone + wait_time_scorched):
		if one_time_loop_state2 == 0 :
			$fish_scorched.show()
			$fish_welldone.hide()
			state = 2
			one_time_loop_state2 = 1
	elif (fish_time > wait_time_welldone):
		if one_time_loop_state1 == 0 :
			get_node("fish_welldone").show()
			$fish_welldone.show()
			$fish_raw.hide()
			state = 1
			one_time_loop_state1 = 1
			
			
func _on_Timer_timeout():
	fish_time += 0.05
	if fish_time <= wait_time_welldone :
		$TextureProgress1.value = fish_time * progress_welldone
	elif fish_time <= wait_time_welldone + wait_time_scorched:
		$TextureProgress2.show()
		$TextureProgress1.hide()
		$TextureProgress2.value = (fish_time-wait_time_welldone) * progress_scorched
	else :
		$TextureProgress2.hide()
	pass
