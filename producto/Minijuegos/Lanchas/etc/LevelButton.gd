extends Control


export var label = "ESCAPE DEL LOBO"
export (StreamTexture) var img
signal on_press

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = label
	$TextureButton.texture_normal = img


func _on_TextureButton_pressed():
	emit_signal("on_press")
