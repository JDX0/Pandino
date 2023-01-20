extends Control

func _ready():
	pass

func _process(_delta):
	pass

func _on_play_button_pressed():
	TransitionScene.transition("res://scenes/game.tscn")

func _on_scores_button_pressed():
	TransitionScene.transition("res://scenes/scores.tscn")
