extends Area2D

const SPEED = 500.0


func _physics_process(delta):
	global_position += Vector2(SPEED*delta, 0).rotated(rotation)
	for b in get_overlapping_bodies():
		if b.is_in_group("players"):
			b.dead = true
		queue_free()
