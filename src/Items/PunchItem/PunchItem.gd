extends ItemInHand

onready var _placeholder_feedback: ColorRect = $PlaceholderFeedback
onready var _punch_sound: AudioStreamPlayer = $PunchSound

var _waiting_to_punch: bool = false

func use():
	_placeholder_feedback.modulate.a = 1.0
	_waiting_to_punch = true
	_punch_sound.play()

func _physics_process(delta):
	if _waiting_to_punch:
		_waiting_to_punch = false
		var space_state = get_world_2d().direct_space_state
		var result: Dictionary = space_state.intersect_ray(to_global(Vector2(0, 0)), to_global(Vector2(40, 0)))
		if not result.empty() and result.collider.is_in_group("knockoutable"):
			result.collider.knock_out()

func _process(delta):
	_placeholder_feedback.modulate.a = lerp(_placeholder_feedback.modulate.a, 0.0, delta*2.0)
