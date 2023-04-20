extends Control

var email_edit
var password_edit
var error_label

func _ready():
	email_edit = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/EmailEdit")
	password_edit = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/PasswordEdit")
	error_label = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ErrorLabel")
	Supabase.auth.connect("signed_in", _on_signed_in)
	Supabase.auth.connect("error", _on_auth_error)
	TransitionScene.aplayer.play("UncoverIn")
	%Loading.set_animation("HorizontalLoading")

func _process(_delta):
	pass
	
func sign_up(email,password):
	error_label.visible = false
	%Loading.visible = true
	Supabase.auth.connect("signed_up", _on_signed_up)
	var _auth_task: AuthTask = await Supabase.auth.sign_up(
		email,
		password
	).completed
	

func _on_login_button_pressed():
	sign_in(email_edit.text,password_edit.text)
	
func _on_sign_up_button_pressed():
	sign_up(email_edit.text,password_edit.text)
	
func _on_testing_login_button_pressed():
	sign_in("asecvqy669@tmail9.com","ciscocisco")
	
func sign_in(email,password):
	error_label.visible = false
	%Loading.visible = true
	Supabase.auth.sign_in(email,password)
	
func _on_signed_in(user : SupabaseUser):
	%Loading.visible = false
	State.user = user
	print(State.user)
	TransitionScene.transition("res://scenes/menu.tscn")
	
func _on_signed_up(user : SupabaseUser):
	%Loading.visible = false
	State.user = user
	print(State.user)
	Database.insert_account_info("Unnamed Panda","Desc")
	TransitionScene.transition("res://scenes/account_info.tscn")
	
func _on_auth_error(error : SupabaseAuthError):
	%Loading.visible = false
	error_label.visible = true
	error_label.text = error.hint
	print(error.hint)

