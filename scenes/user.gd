extends Control

func _ready():
	pass

func _process(_delta):
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
