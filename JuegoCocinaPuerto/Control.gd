extends Control

var s = Vector2()
var ref_s = Vector2(1.4,1.4)
var check_click = 0
var size = 0
var btn 


func animate(c):
	btn = c
	check_click = 1
	size = 1.4
	pass

func _process(delta):
	size += delta
	if check_click == 1:
		s.x = size
		s.y = size
		if btn == 1 :
			$Button_fish/sprite_fish.scale = s
			#$button_sprite.scale = s
			if  s.x > 1.5 :
				check_click = 0
				$Button_fish/sprite_fish.scale = ref_s
	pass
