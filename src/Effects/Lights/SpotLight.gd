extends Light2D

export var flicker_noise: OpenSimplexNoise

var _time: float = 0.0
onready var _base_texture_scale: float = texture_scale

func _ready():
	_time = global_position.x + global_position.y # starting offset varies by position

func _process(delta):
	_time += delta
	texture_scale = _base_texture_scale + flicker_noise.get_noise_1d(_time*30.0)*0.05
