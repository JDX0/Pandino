extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_options_button_pressed():
	TransitionScene.transition("res://scenes/options.tscn")


func _on_play_button_pressed():
	TransitionScene.transition("res://scenes/game.tscn")


func _on_scores_button_pressed():
	TransitionScene.transition("res://scenes/scores.tscn")
