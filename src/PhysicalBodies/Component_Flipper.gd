extends Node

class_name Component_Flipper

export (NodePath) var _sprite_path
export (NodePath) var _item_holder_path

onready var _sprite: AnimatedSprite = get_node(_sprite_path)
onready var _item_holder: Node2D = get_node(_item_holder_path)

var flipped: bool = false setget set_flipped

static func _get_flip_float(flip: bool) -> float:
	return float(not flip)*2.0 - 1.0

func set_flipped(new_flipped):
	var flip_float := _get_flip_float(new_flipped)
	_sprite.flip_h = new_flipped
	_item_holder.position.x = abs(_item_holder.position.x) * sign(flip_float)
	_item_holder.scale.x = flip_float
	flipped = new_flipped
	
