extends Sprite

func _process(_delta):
	global_position.x = -get_viewport().canvas_transform.origin.x
