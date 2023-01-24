extends Control

var email_edit
var password_edit

func _ready():
	email_edit = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/EmailEdit")
	password_edit = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/PasswordEdit")

func _process(_delta):
	pass
	
func sign_up(email,password):
	var auth_task: AuthTask = await Supabase.auth.sign_up(
		email,
		password
	).completed
	State.user = auth_task.user
	Database.insert_account_info("Unnamed Panda","Desc")
	print(State.user)
	TransitionScene.transition("res://scenes/account_info.tscn")

func _on_login_button_pressed():
	Database.sign_in(email_edit.text,password_edit.text)
	TransitionScene.transition("res://scenes/menu.tscn")

func _on_sign_up_button_pressed():
	sign_up(email_edit.text,password_edit.text)
	
func _on_testing_login_button_pressed():
	Database.sign_in("dowagav865@fom8.com","password")
	TransitionScene.transition("res://scenes/menu.tscn")
