extends Control

var email_edit
var password_edit
var error_label
var input_container
var info_label

func _ready():
	$TextureRect.texture = load("res://assets/ui/ui_background_"+State.settings["selected_world"]+".png")
	email_edit = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/EmailEdit")
	password_edit = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/PasswordEdit")
	input_container = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer")
	info_label = get_node("MarginContainer/VBoxContainer/InfoLabel")
	error_label = %ErrorLabel
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
	if input_container.visible == true:
		Sound.ui_forward()
		sign_in(email_edit.text,password_edit.text)
	else:
		info_label.text = "Please sign in to your Pandino account."
		show_input()
		%SignUpButton.modulate.a = 0.2
	
func _on_sign_up_button_pressed():
	if input_container.visible == true:
		Sound.ui_forward()
		sign_up(email_edit.text,password_edit.text)
	else:
		info_label.text = "Please input information for the creation of your Pandino account."
		show_input()
		%LoginButton.modulate.a = 0.2
	
func show_input():
	input_container.visible = true
	$AnimationPlayer.play("ShowLogin")
	
func _on_testing_login_button_pressed():
	Sound.ui_forward()
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
	Database.update_account_info("Unnamed Panda","",0)
	TransitionScene.set_loading(true)
	TransitionScene.next_scene_args = State.user.id
	TransitionScene.transition("res://scenes/account_info.tscn")
	
func _on_auth_error(error : SupabaseAuthError):
	print(error)
	Sound.ui_warn()
	%Loading.visible = false
	error_label.visible = true
	if error.hint == "(undefined)" and error.message == "(undefined)":
		error_label.text = "No internet connection"
	elif not error.hint == "(undefined)":
		error_label.text = error.hint
	else:
		error_label.text = error.message
