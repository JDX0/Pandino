class_name Save
extends Node

const SAVE_PATH := "user://pandino.pansave"

func save_exists() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func save(data : Dictionary):
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		printerr(SAVE_PATH, FileAccess.get_open_error())
		return
	file.store_var(data)

func load_save() -> Dictionary:
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = file.get_var()
	return data
