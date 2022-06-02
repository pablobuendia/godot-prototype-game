extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Anzuelo_body_entered(body):
	$CollisionShape2D.disabled = true
	self.set_collision_layer_bit(0, false)
	self.set_collision_mask_bit(1, false)
	
	var current_scale = $Anzuelo_sprite.scale
	$Tween.interpolate_property($Anzuelo_sprite, "scale", current_scale, Vector2(0, 0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	queue_free()
