extends AnimatableBody2D

const INTERACT_TYPE = "spring"

func _ready():
	pass

func _process(_delta):
	pass
	
func interact():
	var parent_response = get_parent().interact()
	return [INTERACT_TYPE,parent_response[0]]
