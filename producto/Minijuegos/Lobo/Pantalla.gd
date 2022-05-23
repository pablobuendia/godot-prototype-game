extends ParallaxLayer

var speed = -300

func _process(delta):
	get_parent().scroll_base_offset.x += speed*delta
