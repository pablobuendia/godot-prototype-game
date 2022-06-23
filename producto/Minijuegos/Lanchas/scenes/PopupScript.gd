extends Control


func _ready():
	hide()

func hide():
	$RichTextLabel.hide()

func notify(pos,message):
	self.set_position(pos)
	$RichTextLabel.text = message
	$RichTextLabel.show()
	$AnimationPlayer.play("PopupAnim")

func _on_AnimationPlayer_animation_finished(anim_name):
	$RichTextLabel.hide()
