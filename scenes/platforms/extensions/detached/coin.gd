extends Area2D

const INTERACT_TYPE = "coin"

func _ready():
	pass

func _process(_delta):
	pass
	
func interact():
	var parent_response = get_parent().interact()
	$AnimationPlayer.play("Take")
	return [INTERACT_TYPE,parent_response[0]]
	
	
func _on_animation_player_animation_finished(anim_name):
	queue_free()
