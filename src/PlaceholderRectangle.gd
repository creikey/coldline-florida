tool
extends CollisionShape2D

export var color := Color(1, 1, 1) setget set_color

func set_color(new_color):
	color = new_color
	if has_node("ColorRect"):
		$ColorRect.color = color

func _ready():
	_update_color_extents()

func _process(_delta):
	if Engine.editor_hint:
		_update_color_extents()

func _update_color_extents():
	$ColorRect.rect_size = shape.extents*2.0
	$ColorRect.rect_position = -$ColorRect.rect_size/2.0
