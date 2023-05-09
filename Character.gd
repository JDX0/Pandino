extends CharacterBody2D

const SPEED = 1000
const JUMP_VELOCITY = -1000
const SPRING_VELOCITY = -2500

var sensitivity = State.get_setting("sensitivity")
var gyro = Vector3(0,0,0)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var previous_collider
var sprite_scale : Vector2

func _ready():
	$Sprite2D.texture = load("res://assets/character/Skins/"+State.settings["selected_skin"]+".png")
	sprite_scale = $Sprite2D.scale

func _physics_process(delta):
	var gyrodelta = Input.get_gyroscope()
	gyro = gyro + gyrodelta

	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_floor() and velocity.y>=0:
		velocity.y = JUMP_VELOCITY
		var last_collision = get_last_slide_collision()
		if last_collision != null:
			var last_collider = last_collision.get_collider()
			if last_collider != previous_collider and last_collider != null:
				previous_collider = last_collider
				if last_collider.is_in_group("interactable"):
					var interact_type = last_collider.interact()
					match interact_type[0]:
						"spring":
							velocity.y = SPRING_VELOCITY
		else:
			previous_collider = null
		
	var direction = gyro.y/8*sensitivity + Input.get_axis("ui_left", "ui_right")*sensitivity # Gyroscope + Keyboard
	velocity.x = direction * SPEED
	
	if direction > 0:
		$Sprite2D.scale.x = sprite_scale.x
	if direction < 0:
		$Sprite2D.scale.x = -sprite_scale.x
		
	move_and_slide()
		
	if position.x < -680 or position.x > 680:
		position.x = -position.x


func _on_non_physical_collision_detector_area_entered(area):
	print(gravity)
	if area.is_in_group("interactable"):
		var interact_type = area.interact()
		match interact_type[0]:
			"coin":
				State.coins += area.value
