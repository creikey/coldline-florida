extends Component_Flipper

export (NodePath) var _vision_light_path
export (NodePath) var _vision_raycast_path
export (NodePath) var _bullet_spawnpoint_path
export (NodePath) var _floor_raycast_path

onready var _vision_light: Light2D = get_node(_vision_light_path)
onready var _vision_raycast: RayCast2D = get_node(_vision_raycast_path)
onready var _bullet_spawnpoint: Node2D = get_node(_bullet_spawnpoint_path)
onready var _floor_raycast: RayCast2D = get_node(_floor_raycast_path)

func set_flipped(new_flipped):
	var flip_float: float = _get_flip_float(new_flipped)
	flip_float = sign(flip_float)
	_vision_light.scale.x = flip_float
	_vision_light.position.x = abs(_vision_light.position.x) * flip_float
	_vision_raycast.cast_to.x = abs(_vision_raycast.cast_to.x) * flip_float
	_bullet_spawnpoint.position.x = abs(_bullet_spawnpoint.position.x) * flip_float
	_floor_raycast.position.x = abs(_floor_raycast.position.x) * flip_float
	.set_flipped(new_flipped)
