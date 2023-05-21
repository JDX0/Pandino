extends Control

var description_edit
var username_edit
var my = false

func _ready():
	$TextureRect.texture = load("res://assets/ui/ui_background_"+State.settings["selected_world"]+".png")
	description_edit = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/DescriptionEdit")
	username_edit = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/UsernameEdit")
	
func init(id):
	Supabase.database.connect("selected", _on_selected)
	if id == State.user.id:
		my = true
		load_countries()
		$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/UsernameEdit.editable = true
		$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/DescriptionEdit.editable = true
		%CountryOptionButton.disabled = false
	get_account_info(id)

func get_account_info(uuid):
	var query = SupabaseQuery.new().from("profiles").select(PackedStringArray(["id,created_at,username,description,data,countries(name,id)"])).eq("id",uuid)
	Supabase.database.query(query)
	
func load_countries():
	var query = SupabaseQuery.new().from("countries").select(PackedStringArray(["id,name"])).order('name')
	Supabase.database.query(query)
	
func _on_selected(result : Array):
	if result[0].has("username"):
		print(result[0])
		if result[0]["username"] != null:
			username_edit.text = result[0]["username"]
		if result[0]["countries"]["name"] != null:
			%CountryOptionButton.set_item_text(0,result[0]["countries"]["name"])
		if result[0]["description"] != null:
			description_edit.text = result[0]["description"]
		TransitionScene.set_loading(false)
	else:
		for row in result:
			%CountryOptionButton.add_item(row["name"],row["id"])
		

func _on_back_button_pressed():
	Sound.ui_back()
	if my:
		Database.update_account_info(username_edit.text,description_edit.text,%CountryOptionButton.get_selected_id())
	TransitionScene.transition("res://scenes/menu.tscn")
