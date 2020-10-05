extends Node2D

class_name ItemHolder

export (PackedScene) var _default_item_pack

var _current_item: ItemInHand = null

func _ready():
	_equip_item_from_pack(_default_item_pack)

func use_item():
	_current_item.use()

func _equip_item_from_pack(pack: PackedScene):
	if _current_item != null:
		_current_item.queue_free()
	_current_item = pack.instance()
	add_child(_current_item)
