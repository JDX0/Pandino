extends Control

var email_edit
var password_edit

func _ready():
	email_edit = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/EmailEdit")
	password_edit = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/PasswordEdit")

func _process(_delta):
	pass

func _on_login_button_pressed():
	Database.sign_in(email_edit.text,password_edit.text)
	TransitionScene.transition("res://scenes/menu.tscn")

func _on_sign_up_button_pressed():
	Database.sign_up(email_edit.text,password_edit.text)
	TransitionScene.transition("res://scenes/account_info.tscn")
	
func _on_testing_login_button_pressed():
	Database.sign_in("dowagav865@fom8.com","password")
	TransitionScene.transition("res://scenes/menu.tscn")
