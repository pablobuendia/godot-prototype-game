extends ParallaxLayer

var speed = -280

func _process(delta):
	get_parent().scroll_base_offset.x += speed*delta
