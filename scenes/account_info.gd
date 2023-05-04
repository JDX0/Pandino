extends Control

var description_edit
var username_edit
var my = false

func _ready():
	description_edit = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/DescriptionEdit")
	username_edit = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/UsernameEdit")
	
func init(id):
	get_account_info(id)
	if id == State.user.id:
		my = true
		$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/UsernameEdit.editable = true
		$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/DescriptionEdit.editable = true
		

func get_account_info(uuid):
	Supabase.database.connect("selected", _on_account_info_selected)
	var query = SupabaseQuery.new().from("profiles").select().eq("id",uuid)
	Supabase.database.query(query)
	
func _on_account_info_selected(result : Array):
	if result[0]["username"] != null:
		username_edit.text = result[0]["username"]
	if result[0]["description"] != null:
		description_edit.text = result[0]["description"]

func _on_back_button_pressed():
	if my:
		Database.update_account_info(username_edit.text,description_edit.text)
	TransitionScene.transition("res://scenes/menu.tscn")
