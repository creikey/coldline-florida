extends Area2D



func get_target_position(starting_position: Vector2) -> Vector2:
	var exit_point_1: Vector2 = $ExitPoint1.global_transform.origin
	var exit_point_2: Vector2 = $ExitPoint2.global_transform.origin
	
	var distance_to_1: float = starting_position.distance_to(exit_point_1)
	var distance_to_2: float = starting_position.distance_to(exit_point_2)
	
	if distance_to_1 < distance_to_2:
		return exit_point_2
	else:
		return exit_point_1
