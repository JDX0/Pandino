extends Control


func _ready():
	$MarginContainer/VBoxContainer/CoinLabel.text = str(State.coins)


func _process(delta):
	pass


func _on_back_button_pressed():
	TransitionScene.transition("res://scenes/menu.tscn")
