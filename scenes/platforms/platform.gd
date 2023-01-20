extends AnimatableBody2D

const INTERACT_TYPE = "platform"

func _ready():
	pass

func _process(_delta):
	pass

func interact():
	return [INTERACT_TYPE]

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
