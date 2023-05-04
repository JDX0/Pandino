extends Node

var save_manager = Save.new("user://pandino.pansave")
 
var first_run = false

var state = "menu"
var auth = "no_user"
var coins = 0
var user : SupabaseUser
var settings = {
	"sensitivity": 1,
	"master_volume": 100,
	"selected_skin": "panda"
}
func _ready():
	if !save_manager.save_exists():
		first_run = true
		save()
	load_save()

func save():
	save_manager.save(get_as_dict())

func load_save():
	set_as_dict(save_manager.load_save())

func reset_save():
	settings = {
	"sensitivity": 1,
	"master_volume": 100,
	"selected_skin": "panda"
	}
	save()
	
func set_as_dict(dict : Dictionary):
	state = dict["state"]
	auth = dict["auth"]
	coins = dict["coins"]
	#user = dict["user"]
	settings = dict["settings"]

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

func get_setting(field):
	return settings[field]
	

	
