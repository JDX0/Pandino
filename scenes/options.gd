extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	TransitionScene.transition("res://scenes/menu.tscn")


func _on_account_info_button_pressed():
	TransitionScene.transition("res://scenes/account_info.tscn")
