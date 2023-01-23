extends Node



var state = "menu"
var auth = "no_user"
var coins 
var user : SupabaseUser
var settings = {
	"sensitivity": 66
} 

func save():
	#var file = FileAccess.open_encrypted_with_pass("user://pandino.pand", FileAccess.WRITE, "pswd")
	var file = FileAccess.open_compressed("user://pandino.pand", FileAccess.WRITE)
	file.store_var(get_as_dict())

func get_save():
	#var file = FileAccess.open_encrypted_with_pass("user://pandino.pand", FileAccess.READ, "pswd")
	var file = FileAccess.open_compressed("user://pandino.pand", FileAccess.READ)
	print(file.get_var())
	
func set_as_dict(dict : Dictionary):
	state = dict["state"]
	auth = dict["auth"]
	coins = dict["coins"]
	user = dict["user"]
	settings = dict["settings"]

func get_as_dict():
	return {
		"state":state,
		"auth":auth,
		"coins":coins,
		"user":user,
		"settings":settings
	}

func set_setting(field,value):
	settings[field] = value

func get_setting(field):
	return settings[field]
