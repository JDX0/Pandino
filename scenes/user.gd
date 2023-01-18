extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_login_button_pressed():
	Database.sign_in(get_node("MarginContainer/VBoxContainer/EmailEdit").text,get_node("MarginContainer/VBoxContainer/PasswordEdit").text)
	TransitionScene.transition("res://scenes/menu.tscn")

func _on_sign_up_button_pressed():
	Database.sign_up(get_node("MarginContainer/VBoxContainer/EmailEdit").text,get_node("MarginContainer/VBoxContainer/PasswordEdit").text)
	TransitionScene.transition("res://scenes/account_info.tscn")
	
func _on_testing_login_button_pressed():
	Database.sign_in("dowagav865@fom8.com","password")
	TransitionScene.transition("res://scenes/menu.tscn")
