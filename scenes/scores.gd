extends Control

func _ready():
	get_online_scores()

func _process(_delta):
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
	var time_passed = get_time_passed_from_datetime_string(row["created_at"])
	
	get_node("MarginContainer/VBox/ScrollContainer/ScoreList").add_item(str(row["value"]))
	get_node("MarginContainer/VBox/ScrollContainer/ScoreList").add_item(str(time_passed))
	get_node("MarginContainer/VBox/ScrollContainer/ScoreList").add_item(str(row["profiles"]["username"]))

func get_time_passed_from_datetime_string(datetime_string : String):
	var unix_created = Time.get_unix_time_from_datetime_string(datetime_string)
	var seconds_passed = Time.get_unix_time_from_system()-unix_created
	if seconds_passed < 60: # less than 1 minute
	#	return str(floor(seconds_passed))+" s"
		return "now"
	if seconds_passed < 3600: # less than 1 hour
		return str(floor(seconds_passed/60))+" m"
	if seconds_passed < 86400: # less than 1 day
		return str(floor(seconds_passed/3600))+" h"
	#if seconds_passed < 604800: # less than 1 week
	if seconds_passed < 31556952: # less than 1 average year (Gregorian calendar) ~365.2425 days
		return str(floor(seconds_passed/86400))+" d"
	#if seconds_passed < 2629757: # less than 1 average month (Gregorian calendar) ~30.437 days
	#	return str(floor(seconds_passed/604800))+" week"
	#if seconds_passed < 31556952: # less than 1 average year (Gregorian calendar) ~365.2425 days
	#	return str(floor(seconds_passed/2629757))+" month"
	return str(floor(seconds_passed/31556952))+" y" # more than 1 year
	
func _on_back_button_pressed():
	TransitionScene.transition("res://scenes/menu.tscn")
