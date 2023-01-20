extends Camera2D

var character_max_height = 0

func _ready():
	pass

func _process(_delta):
	
	var character_height = get_node("../Character").position.y
	if State.state == "playing":
		if character_height <= character_max_height:
			position.y = character_height
			character_max_height = character_height
	else:
		position.y = character_height
