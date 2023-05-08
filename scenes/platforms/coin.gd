extends Area2D

const INTERACT_TYPE = "coin"

func _ready():
	pass

func _process(_delta):
	pass
	
func interact():
	$AnimationPlayer.play("Take")
	return [INTERACT_TYPE]
	
	
func _on_animation_player_animation_finished(_anim_name):
	queue_free()
