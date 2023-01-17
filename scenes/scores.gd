extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_online_scores()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_online_scores():
	Supabase.database.connect("selected", self._on_selected)
	var query = SupabaseQuery.new().from("scores").select(PackedStringArray(["value,created_at,profiles(username)"])).order('value',1)
	Supabase.database.query(query)

func _on_selected(result : Array):
	print(result)
	for row in result:
		add_to_list(row)
	
func add_to_list(row : Dictionary):
	var time_ago = (Time.get_unix_time_from_system()-Time.get_unix_time_from_datetime_string(row["created_at"]))/60
	get_node("MarginContainer/VBox/ScoreList").add_item(str(row["value"]))
	get_node("MarginContainer/VBox/ScoreList").add_item(str(round(time_ago))+"m")
	get_node("MarginContainer/VBox/ScoreList").add_item(str(row["profiles"]["username"]))

func _on_back_button_pressed():
	TransitionScene.transition("res://scenes/menu.tscn")
