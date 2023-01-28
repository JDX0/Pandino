extends Camera2D

#func _process(_delta):
#	if position.y > %Character.get_position().y:
#		position = Vector2(0,%Character.get_position().y)

var character_max_height = 0

func _process(_delta):
	var character_height = get_node("../Character").position.y
	if State.state == "playing":
		if character_height <= character_max_height:
			position.y = character_height
			character_max_height = character_height
	else:
		position.y = character_height
