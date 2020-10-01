extends Area2D

onready var _rect_shape: CollisionShape2D = $CollisionShape2D

func _physics_process(_delta):
	for b in get_overlapping_bodies():
		if _tracks_water_state(b):
			b.distance_to_water_surface = abs(b.global_position.y - (global_position.y - _rect_shape.shape.extents.y))

func _on_InWaterArea_body_exited(b):
	if _tracks_water_state(b):
		b.distance_to_water_surface = -1.0

func _tracks_water_state(body: Node):
	return "distance_to_water_surface" in body
