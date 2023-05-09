extends Area2D

const INTERACT_TYPE = "coin"
var value = 1

func init(val : int):
	match val:
		1: value = 1
		2: value = 2
		3: value = 5
	$Sprite2D.texture = load("res://assets/world/platforms/extensions/pandcoin"+str(value)+".png")
	
func interact():
	$AnimationPlayer.play("Take")
	return [INTERACT_TYPE]
	
	
func _on_animation_player_animation_finished(_anim_name):
	queue_free()
