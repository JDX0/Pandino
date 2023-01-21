extends Node

var state = "menu"
var auth = "no_user"
var user : SupabaseUser
var settings = {
	"sensitivity": 1
} 

func set_setting(field,value):
	settings[field] = value

func get_setting(field):
	return settings[field]
