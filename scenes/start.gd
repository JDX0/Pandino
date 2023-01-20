extends Control

func _ready():
	pass

func _process(_delta):
	TransitionScene.transition("res://scenes/user.tscn")
