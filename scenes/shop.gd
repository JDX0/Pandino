extends Control

func _ready():
	$TextureRect.texture = load("res://assets/ui/ui_background_"+State.settings["selected_world"]+".png")
	$MarginContainer/VBoxContainer/CoinLabel.text = str(State.coins)
	
func _process(_delta):
	pass

func _on_back_button_pressed():
	Sound.ui_back()
	TransitionScene.transition("res://scenes/menu.tscn")
