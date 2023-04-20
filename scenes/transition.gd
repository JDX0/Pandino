extends Node2D

var next_scene
var current_scene
var in_animation
var out_animations = ["FadeOut"]

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func transition(next,out_anim = "FadeOut",in_anim = "FadeIn"):
	State.save()
	get_node("AnimationPlayer").play(out_anim)
	next_scene = next
	in_animation = in_anim

func _on_animation_player_animation_finished(anim):
	$AnimationPlayer.play("RESET")
	if out_animations.has(anim):
		call_deferred("switch_to_scene",next_scene)

func switch_to_scene(scene):
	current_scene.free()
	var s = ResourceLoader.load(scene)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_node("AnimationPlayer").play(in_animation)
