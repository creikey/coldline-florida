tool
extends StaticBody2D

export var extents := Vector2(50, 50) setget set_extents
export var wall_thickness: float = 3.0 setget set_wall_thickness

func set_wall_thickness(new_wall_thickness):
	wall_thickness = new_wall_thickness
	self.set_extents(extents)

func set_extents(new_extents):
	extents = new_extents
	if has_node("Line2D"):
		var line: Line2D = $Line2D
		line.points[0] = -extents
		line.points[1] = Vector2(-extents.x, extents.y)
		line.points[2] = extents
		line.points[3] = Vector2(extents.x, -extents.y)
		line.points[4] = line.points[0]
		
		# the shapes are shared among parallel walls, so only needs to edit one
		$LeftWall.shape.extents.y = extents.y
		$LeftWall.shape.extents.x = wall_thickness
		$LeftWall.position = Vector2(-extents.x, 0)
		$RightWall.position = Vector2(extents.x, 0)
		
		$TopWall.shape.extents.x = extents.x
		$TopWall.shape.extents.y = wall_thickness
		$TopWall.position = Vector2(0, -extents.y)
		$BottomWall.position = Vector2(0, extents.y)
		
#		$CollisionPolygon2D.polygon = line.points
		$LightOccluder2D.occluder = $LightOccluder2D.occluder.duplicate(true)
		$LightOccluder2D.occluder.polygon = line.points
