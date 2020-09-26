tool
extends StaticBody2D

export var extents := Vector2(50, 50) setget set_extents

func set_extents(new_extents):
	extents = new_extents
	if has_node("Line2D"):
		var line: Line2D = $Line2D
		line.points[0] = -extents
		line.points[1] = Vector2(-extents.x, extents.y)
		line.points[2] = extents
		line.points[3] = Vector2(extents.x, -extents.y)
		line.points[4] = line.points[0]
		$CollisionPolygon2D.polygon = line.points
