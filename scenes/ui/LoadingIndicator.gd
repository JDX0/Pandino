extends Control

var animation

func _ready():
	set_animation("CircularLoading")

func set_animation(animname : String):
	animation = animname
	$AnimationPlayer.play(animation)
