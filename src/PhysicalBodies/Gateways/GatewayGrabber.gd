extends Area2D

func get_gateway_in_range() -> Area2D:
	for a in get_overlapping_areas():
		if not a.is_in_group("gateways"):
			continue
		return a
	return null
