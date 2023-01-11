extends Camera2D

var character_max_height = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var character_height = get_node("../Character").position.y
	if State.state == "playing":
		if character_height <= character_max_height:
			position.y = character_height
			character_max_height = character_height
	else:
		position.y = character_height
