extends PhysicalBody2D

const GRAVITY: float = 1500.0
const WATER_LEVEL: float = 635.0
const BUOYANCY_CONSTANT: float = 300.0 # for underwater buoyancyness
var horizontal: float = 1.0

var angry: bool = false setget set_angry
var dead: bool = false
var time: float = 0.0
var my_normal_speed: float = 100.0
var my_angry_speed: float = 270.0

func set_angry(new_angry):
	angry = new_angry
	if not has_node("FireTimer"):
		return
	if angry:
		if $FireTimer.is_stopped():
			_on_FireTimer_timeout()
			$FireTimer.start()
	else:
		$FireTimer.stop()

func _physics_process(delta):
	if dead:
		return
	time += delta
	accel = Vector2()
	accel += Vector2(0, GRAVITY)
	accel += Vector2(0, -sqrt(max(0, global_position.y - WATER_LEVEL))*BUOYANCY_CONSTANT)
	
	if global_position.y > WATER_LEVEL:
		accel += -vel.normalized()*800.0
		if angry:
			accel.y += sin(time)*1500.0

	if is_on_wall() or (not $FloorRaycast.is_colliding() and is_on_floor()):
		horizontal *= -1.0
		$Component_EnemyFlipper.flipped = horizontal < 0.0
#		scale.x *= -1.0
	if $PlayerVisionRaycast.is_colliding() and $PlayerVisionRaycast.get_collider().is_in_group("players"):
		self.angry = true
#		$SeeingRaycast.cast_to.x *= -1.0
#	var horizontal: float = float(Input.is_action_pressed("g_right")) - float(Input.is_action_pressed("g_left"))
	var speed: float = 100.0
	if angry:
		speed = 250.0
		if is_on_floor() and rand_range(0, 1) < 0.1:
			vel.y = -rand_range(600.0, 1200.0)
#	if $JumpRaycast.is_colliding() and $JumpRaycast.get_collider().is_in_group("enemies"):
#		vel.x = 0.0 # this will let them stack on top of eachother
#	else:
	vel.x = speed*horizontal
#	var printing: bool = name == "Enemy"
#	var printing: bool = true
#	if printing:
#		printt("before", vel)
	vel = move_and_slide(vel, Vector2(0, -1))
#	if printing:
#		printt("after", vel)
#		print()

func _ready():
	randomize()
	my_normal_speed = rand_range(90, 170)
	my_angry_speed = rand_range(230, 280)

func _input(event):
	return
	if dead:
		if event.is_action_pressed("g_restart"):
			get_tree().reload_current_scene()
		return
	elif event.is_action_pressed("g_enter_gateway"):
		var gateway: Area2D = $GatewayGrabber.get_gateway_in_range()
		if gateway == null:
			return
		$PhysicsBodyMover.move_to_point(gateway.get_target_position(global_transform.origin))


func _on_PhysicsBodyMover_moved_through_vent():
	vel = Vector2()


func _on_FireTimer_timeout():
	if $BulletPackClearCast.is_colliding():
		return
	$FireTimer.wait_time = rand_range(0.8, 1.5)
	var new_bullet: Node2D = preload("res://Effects/Bullet/Bullet.tscn").instance()
	get_parent().add_child(new_bullet)
	new_bullet.global_position = $BulletSpawnPoint.global_transform.origin
	new_bullet.rotation = Vector2(horizontal, 0).angle()
	
