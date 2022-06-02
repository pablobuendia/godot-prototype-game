extends Control

var index = 0
signal dialog_terminated

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("AnchorIdle")
	pass # Replace with function body.


var frases = ["buen dia","mi nombre es ralsei","te doy la bienvenida al puerto de mar del plata"]



func _on_Panel_pressed():
	if (index < frases.size()):
		$Panel/RichTextLabel.text = frases[index]
		index+=1
	else:
		emit_signal("dialog_terminated")
