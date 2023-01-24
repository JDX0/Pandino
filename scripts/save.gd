class_name Save
extends Node

## Class to handle saving and loading save data
##
## This is used to permanently store save data into the file system and to read from it.[br]
## Used to store game save data and settings as dictionaries.

## The path from which the save is read and to which the save is written.
var save_path: String 

func _init(path : String):
	save_path = path
	
## Returns [code]true[/code] if the save exists
func save_exists() -> bool:
	return FileAccess.file_exists(save_path)

## Saves the provided data to save_path.
func save(data : Dictionary):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file == null:
		printerr(save_path, FileAccess.get_open_error())
		return
	file.store_var(data)

## Returns previously saved data from save_path.
func load_save() -> Dictionary:
	var file = FileAccess.open(save_path, FileAccess.READ)
	var data = file.get_var()
	return data
