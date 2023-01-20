extends CharacterBody2D

const SPEED = 1000
const JUMP_VELOCITY = -1000
const SPRING_VELOCITY = -1000

var gyro = Vector3(0,0,0)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	var gyrodelta = Input.get_gyroscope()
	gyro = gyro + gyrodelta
	#if gyro.y > 0:
	#	self.scale.x = 1
	#else:
	#	self.scale.x = -1
		
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction = gyro.y/5 + Input.get_axis("ui_left", "ui_right") # Gyroscope + Keyboard
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
