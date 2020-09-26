extends CanvasLayer

export (NodePath) var player_path

onready var player: Node2D = get_node(player_path)

func _process(_delta):
	$RestartLabel.visible = player.dead
