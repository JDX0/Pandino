extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_finish_button_pressed():
	Database.replace_account_info(get_node("MarginContainer/VBoxContainer/UsernameEdit").text,get_node("MarginContainer/VBoxContainer/DescriptionEdit").text)
	TransitionScene.transition("res://scenes/menu.tscn")
