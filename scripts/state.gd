extends Node

var save_manager = Save.new("user://pandino.pansave")
 
var first_run = false

var state = "menu"
var auth = "no_user"
var coins = 0
var user : SupabaseUser
var default_settings = {
	"sensitivity": 1.0,
	"master_volume": 1.0,
	"ui_volume": 1.0,
	"film_grain": 1.0,
	"selected_skin": "panda"
}
var settings = default_settings
func _ready():
	if !save_manager.save_exists():
		first_run = true
		save()
	load_save()
	
func update():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(settings["master_volume"]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("UI"), linear_to_db(settings["ui_volume"]))


func save():
	save_manager.save(get_as_dict())

func load_save():
	set_as_dict(save_manager.load_save())

func reset_save():
	settings = default_settings
	save()
	
func set_as_dict(dict : Dictionary):
	state = dict["state"]
	auth = dict["auth"]
	coins = dict["coins"]
	#user = dict["user"]
	settings = dict["settings"]
	update()

func get_as_dict():
	return {
		"state":state,
		"auth":auth,
		"coins":coins,
		#"user":user,
		"settings":settings
	}

func set_setting(field,value):
	settings[field] = value
	update()

func get_setting(field):
	return settings[field]
	

	
