extends AnimatableBody2D

const INTERACT_TYPE = "platform_disappearing"
const EXTENSION_HEIGHT = 0

var sprite_rect_size : Vector2

func _ready():
	$Sprite2D.texture = load("res://assets/world/platforms/platform_disappearing_"+State.settings["selected_world"]+".png")
	sprite_rect_size = $Sprite2D.get_rect().size*$Sprite2D.get_scale()

func _process(_delta):
	pass

func interact():
	disappear()
	return [INTERACT_TYPE]

func get_size():
	return sprite_rect_size

func disappear():
	$AnimationPlayer.play("disappear")

func _on_animation_player_animation_finished(_anim_name):
	queue_free()
