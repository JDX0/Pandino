extends Node2D

var next_scene
var next_scene_args
var current_scene
var in_animation
var out_animations = ["FadeOut","InstantOut"]
var aplayer
var loading = false
var not_deferred = false

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	aplayer = get_node("AnimationPlayer")

func transition(next,out_anim = "FadeOut",in_anim = "FadeIn"):
	State.save()
	next_scene = next
	in_animation = in_anim
	aplayer.play(out_anim)
	

func _on_animation_player_animation_finished(anim):
	if not loading:
		aplayer.play("RESET")
	if out_animations.has(anim):
		if not_deferred:
			switch_to_scene(next_scene)
			not_deferred = false
		else:
			call_deferred("switch_to_scene",next_scene)

func switch_to_scene(scene):
	current_scene.free()
	var s = ResourceLoader.load(scene)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	if current_scene.has_method("init") and next_scene_args != null:
		current_scene.init(next_scene_args)
		next_scene_args = null
	if not loading:
		aplayer.play(in_animation)
	else:
		$Loading.visible = true
		$Timer.start()
		print("vis true")
		
func set_loading(is_loading : bool):
	if is_loading:
		loading = true
	else:
		loading = false
		aplayer.play(in_animation)
		$Loading.visible = false
		$Loading/LongLoading.visible = false
		print("vis false")

func _on_timer_timeout():
	$Loading/LongLoading.visible = true
