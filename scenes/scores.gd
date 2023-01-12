extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_online_scores()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_online_scores():
	Supabase.database.connect("selected", self._on_selected)
	var query = SupabaseQuery.new().from("scores").select()
	Supabase.database.query(query)

func _on_selected(result : Array):
	print(result)
	for row in result:
		add_to_list(row)
	
func add_to_list(row : Dictionary):
	var score_value = row["value"]
	get_node("MarginContainer/ScoreList").add_item(str(score_value))
	var datetime_string = row["created_at"]
	Time.get_datetime_dict_from_datetime_string(datetime_string, false)
	
	get_node("MarginContainer/ScoreList").add_item(str(datetime_string))

func _on_back_button_pressed():
	pass # Replace with function body.
