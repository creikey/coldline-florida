extends Node2D

class_name LightHider

onready var _player: Node2D = get_node("/root/Main/Player")
onready var _to_control: CanvasItem = get_parent()

func _process(_delta):
	_to_control.enabled = _player.global_position.distance_to(global_position) < 2000.0
