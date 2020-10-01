extends Tween

signal moved_through_vent

onready var to_control: PhysicsBody2D = get_parent()

func move_to_point(point: Vector2):
	_set_enabled(false)
# warning-ignore:return_value_discarded
	interpolate_property(to_control, "global_position", null, point, 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
# warning-ignore:return_value_discarded
	start()

func _on_PhysicsBodyMover_tween_all_completed():
	_set_enabled(true)
	emit_signal("moved_through_vent")

func _set_enabled(is_enabled: bool):
	to_control.set_physics_process(is_enabled)
	to_control.set_process_input(is_enabled)
	to_control.set_process(is_enabled)
	for c in to_control.get_children():
		if c is CollisionShape2D:
			c.disabled = not is_enabled
