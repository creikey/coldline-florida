extends KinematicBody2D

class_name PhysicalBody2D

# physical stuff
var vel := Vector2()
var accel := Vector2()

# set by water areas
var distance_to_water_surface: float = 0.0

func _is_underwater() -> bool:
	return distance_to_water_surface > 1.0 # more than 1 pixel underwater

func _physics_process(delta):
	vel += accel*delta
