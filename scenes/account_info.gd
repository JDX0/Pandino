extends Control

func _ready():
	get_account_info(State.user.id)

func _process(_delta):
	pass

func get_account_info(uuid):
	Supabase.database.connect("selected", _on_account_info_selected)
	var query = SupabaseQuery.new().from("profiles").select().eq("id",uuid)
	Supabase.database.query(query)
	
func _on_account_info_selected(result : Array):
	get_node("MarginContainer/VBoxContainer/UsernameEdit").text = result[0]["username"]
	get_node("MarginContainer/VBoxContainer/DescriptionEdit").text = result[0]["description"]

func _on_finish_button_pressed():
	Database.upsert_account_info(get_node("MarginContainer/VBoxContainer/UsernameEdit").text,get_node("MarginContainer/VBoxContainer/DescriptionEdit").text)
	TransitionScene.transition("res://scenes/menu.tscn")
