extends KinematicBody2D

const GRAVITY: float = 1500.0
const WATER_LEVEL: float = 635.0
const BUOYANCY_CONSTANT: float = 300.0 # for underwater buoyancyness
var accel := Vector2()
var vel := Vector2()

var dead: bool = false

onready var _jump_raycast: RayCast2D = $JumpRaycast

func _physics_process(delta):
	if dead:
		return
	accel = Vector2()
	accel += Vector2(0, GRAVITY)
	accel += Vector2(0, -sqrt(max(0, global_position.y - WATER_LEVEL))*BUOYANCY_CONSTANT)
	
	if global_position.y > WATER_LEVEL:
		accel += -vel.normalized()*800.0
		var vertical: float = float(Input.is_action_pressed("g_down")) - float(Input.is_action_pressed("g_up"))
		accel.y += vertical*1500.0

	vel += accel*delta
	
	var horizontal: float = float(Input.is_action_pressed("g_right")) - float(Input.is_action_pressed("g_left"))
	vel.x = horizontal*300.0
	
	vel = move_and_slide(vel, Vector2(0, -1))

func _input(event):
	if dead:
		if event.is_action_pressed("g_restart"):
			get_tree().reload_current_scene()
		return
	if _jump_raycast.is_colliding() and event.is_action_pressed("g_up"):
		vel.y = -800.0
	elif event.is_action_pressed("g_enter_gateway"):
		var gateway: Area2D = $GatewayGrabber.get_gateway_in_range()
		if gateway == null:
			return
		$PhysicsBodyMover.move_to_point(gateway.get_target_position(global_transform.origin))


func _on_PhysicsBodyMover_moved_through_vent():
	vel = Vector2()
