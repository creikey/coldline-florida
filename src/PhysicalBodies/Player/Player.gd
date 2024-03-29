extends PhysicalBody2D

const MAX_SPEED: float = 1500.0
const BUOYANCY_CONSTANT: float = 900.0 # for underwater buoyancyness
const MOVE_SPEED: float = 450.0
const JUMP_HEIGHT: float = 200.0
const JUMP_AIR_TRAVEL: float = 200.0

const JUMP_GRAVITY: float =  -(-2.0 * JUMP_HEIGHT * pow(MOVE_SPEED, 2.0))/pow(JUMP_AIR_TRAVEL, 2.0)
const NORMAL_GRAVITY: float = JUMP_GRAVITY*2.0
const JUMP_INITIAL_VEL: float = (2.0 * JUMP_HEIGHT * MOVE_SPEED)/JUMP_AIR_TRAVEL

var _jumped: bool = false
var dead: bool = false

func _physics_process(_delta):
	if dead:
		return
	accel = Vector2()
	if _jumped:
		accel += Vector2(0, JUMP_GRAVITY)
	else:
		accel += Vector2(0, NORMAL_GRAVITY)
	if _jumped and is_on_floor() and vel.y > -1.0:
		_jumped = false
	accel += Vector2(0, -sqrt(max(0, distance_to_water_surface))*BUOYANCY_CONSTANT)

	if _is_underwater():
		accel += -vel.normalized()*2500.0
		var vertical: float = float(Input.is_action_pressed("g_down")) - float(Input.is_action_pressed("g_up"))
		accel.y += vertical*2500.0
	
	var horizontal: float = float(Input.is_action_pressed("g_right")) - float(Input.is_action_pressed("g_left"))

	if vel.length() > MAX_SPEED:
		vel = vel.normalized()*MAX_SPEED

	if abs(horizontal) > 0.0:
		$AnimatedSprite.play("walking")
		$Component_Flipper.flipped = horizontal < 0.0
	else:
		$AnimatedSprite.play("idle")
	
	vel.x = horizontal*MOVE_SPEED
	
	vel = move_and_slide(vel, Vector2(0, -1))

func _input(event):
	if dead:
		if event.is_action_pressed("g_restart"):
			var _err = get_tree().reload_current_scene()
		return
	if is_on_floor() and event.is_action_pressed("g_jump"):
		_jump()
	if event.is_action_released("g_jump"):
		_jumped = false
	elif event.is_action_pressed("g_use_item"):
		$ItemHolder.use_item()
	elif event.is_action_pressed("g_enter_gateway"):
		var gateway: Area2D = $GatewayGrabber.get_gateway_in_range()
		if gateway == null:
			return
		$PhysicsBodyMover.move_to_point(gateway.get_target_position(global_transform.origin))

func _jump():
	if _jumped:
		return
	_jumped = true
	vel.y = -JUMP_INITIAL_VEL

func _on_PhysicsBodyMover_moved_through_vent():
	vel = Vector2()
	_jumped = false
