extends Control

func _ready():
	$TextureRect.texture = load("res://assets/ui/ui_background_"+State.settings["selected_world"]+".png")

func _process(_delta):
	pass

func _on_play_button_pressed():
	Sound.ui_forward()
	TransitionScene.transition("res://scenes/game.tscn")

func _on_scores_button_pressed():
	Sound.ui_forward()
	TransitionScene.transition("res://scenes/scores.tscn")

func _on_menu_button_pressed():
	Sound.ui_back()
	TransitionScene.transition("res://scenes/menu.tscn")
