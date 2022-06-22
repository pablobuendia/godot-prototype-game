extends AudioStreamPlayer

onready var tween_out = get_node("Tween")

export var transition_duration = 1.00
export var transition_type = 1 # TRANS_SINE

signal just_faded_out

func _ready():
	pass

func fade_out():
	var current_vol = self.volume_db
	tween_out.interpolate_property(self, "volume_db", current_vol, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()


func _on_Tween_tween_completed(object, key):
	emit_signal("just_faded_out")
	object.stop()
