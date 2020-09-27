extends Node

class_name Component_Flipper

export (NodePath) var _sprite_path

onready var _sprite: Sprite = get_node(_sprite_path)

var flipped: bool = false setget set_flipped

func set_flipped(new_flipped):
	_sprite.flip_h = new_flipped
	flipped = new_flipped
	
