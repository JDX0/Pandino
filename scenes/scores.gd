extends Control

var scrolling = false
var loading = false
var page_size = 100
var page = 0

func _ready():
	$TextureRect.texture = load("res://assets/ui/ui_background_"+State.settings["selected_world"]+".png")
	Supabase.database.connect("selected", _on_selected)
	Supabase.database.connect("error", _on_database_error)
	get_online_scores_page(page,page_size)

func _process(_delta):
	if %ListValue.get_global_rect().position.y+%ListValue.get_global_rect().size.y<2000 and not loading:
		page += 1
		get_online_scores_page(page, page_size)
		pass
		
func get_online_scores_page(page_n:int,pg_size:int):
	var query = SupabaseQuery.new().from("scores").select(PackedStringArray(["value,created_at,user_id,profiles(username)"])).order('value',1).range(page_n*pg_size,page_n*pg_size+pg_size-1)
	Supabase.database.query(query)																				#,[count:'exact']
	page += 1
	show_loading(true)

func _on_selected(result : Array):
	for row in result:
		print(row)
		add_to_list(row)
	show_loading(false)
	
func add_to_list(row : Dictionary):
	var time_passed = get_time_passed_from_datetime_string(row["created_at"])
	
	var index = %ListUser.add_item(str(row["profiles"]["username"]))
	%ListUser.set_item_metadata(index,row["user_id"])
	%ListValue.add_item(str(row["value"]))
	%ListTime.add_item(str(time_passed))
	if row["user_id"] == State.user.id:
		%ListUser.set_item_custom_bg_color(index,Color.CORNFLOWER_BLUE)
		%ListValue.set_item_custom_bg_color(index,Color.CORNFLOWER_BLUE)
		%ListTime.set_item_custom_bg_color(index,Color.CORNFLOWER_BLUE)
	

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
	

func show_loading(showl:bool):
	loading = showl
	$MarginContainer/VBox/ScrollContainer/VBoxContainer/Loading/LoadingIndicator.visible = showl
	

func _on_database_error(error : SupabaseDatabaseError):
	print(error)


func _on_back_button_pressed():
	Sound.ui_back()
	TransitionScene.transition("res://scenes/menu.tscn")


func _on_scroll_container_scroll_started():
	scrolling = true


func _on_scroll_container_scroll_ended():
	scrolling = false


func _on_list_user_item_clicked(index, _at_position, _mouse_button_index):
	Sound.ui_forward()
	TransitionScene.set_loading(true)
	print("Showing profile of user "+%ListUser.get_item_metadata(index))
	TransitionScene.next_scene_args = %ListUser.get_item_metadata(index)
	TransitionScene.transition("res://scenes/account_info.tscn")
	

