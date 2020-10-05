extends ItemInHand

onready var _placeholder_feedback: ColorRect = $PlaceholderFeedback
onready var _punch_sound: AudioStreamPlayer = $PunchSound

func use():
	_placeholder_feedback.modulate.a = 1.0
	_punch_sound.play()

func _process(delta):
	_placeholder_feedback.modulate.a = lerp(_placeholder_feedback.modulate.a, 0.0, delta*2.0)
