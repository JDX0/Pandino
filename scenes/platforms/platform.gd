extends AnimatableBody2D

const INTERACT_TYPE = "platform"
const EXTENSION_HEIGHT = -30

var sprite_rect_size : Vector2

func _ready():
	sprite_rect_size = $Sprite2D.get_rect().size*$Sprite2D.get_scale()

func _process(_delta):
	pass

func interact():
	return [INTERACT_TYPE]

func get_size():
	return sprite_rect_size

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
