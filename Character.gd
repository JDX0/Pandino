extends CharacterBody2D

const SPEED = 1000
const JUMP_VELOCITY = -1000
const SPRING_VELOCITY = -1000

var gyro = Vector3(0,0,0)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var previous_collider

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
	
	if position.x < -680 or position.x > 680:
		position.x = -position.x
	
	var last_collision = get_last_slide_collision()
	if last_collision != null:
		var last_collider = last_collision.get_collider()
		if last_collider != previous_collider:
			previous_collider = last_collider
			if last_collider.is_in_group("interactable"):
				print(last_collider.interact())
	else:
		previous_collider = null

