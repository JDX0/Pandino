extends Control

func _ready():
	pass

func _process(_delta):
	pass

func _on_back_button_pressed():
	TransitionScene.transition("res://scenes/menu.tscn")

func _on_account_info_button_pressed():
	TransitionScene.transition("res://scenes/account_info.tscn")
