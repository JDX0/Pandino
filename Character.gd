extends CharacterBody2D

const SPEED = 1000
const JUMP_VELOCITY = -1000
const SPRING_VELOCITY = -2500

var sensitivity = State.get_setting("sensitivity")
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
		
	var direction = gyro.y/8*sensitivity + Input.get_axis("ui_left", "ui_right")*sensitivity # Gyroscope + Keyboard
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var last_collision = get_last_slide_collision()
	if last_collision != null:
		var last_collider = last_collision.get_collider()
		if last_collider != previous_collider:
			previous_collider = last_collider
			if last_collider.is_in_group("interactable"):
				var interact_type = last_collider.interact()
				match interact_type[0]:
					"spring":
						velocity.y = SPRING_VELOCITY
					"coin":
						State.coins += 1
						print("coin")
	else:
		previous_collider = null
		
	move_and_slide()
		
	if position.x < -680 or position.x > 680:
		position.x = -position.x

