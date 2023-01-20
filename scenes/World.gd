extends Node2D

var platforms = [preload('res://scenes/platforms/platform.tscn')]
var extensions = [preload('res://scenes/platforms/extensions/spring.tscn')]
var last_platform_height = 200

# Generator Settings
var platform_height_delta = -450

# Called when the node enters the scene tree for the first time.
func _ready():
	#for platform_type in platform_types:
	#	platforms[platform_type]=preload(platform_type)
	randomize()
	#get_tree().paused=true

func generate():
	var player_height = get_node("Character").position.y
	
	if player_height < last_platform_height + 100:
		var height = last_platform_height+platform_height_delta
		var gen_platform
		gen_platform = platforms[0].instantiate()
		var randx = int(randi_range(-500,500))
		if randx < 0:
			gen_platform.scale.x = -gen_platform.scale.x
		gen_platform.set_position(Vector2(randx,height))
		var gen_extension = extensions[0].instantiate()
		gen_extension.set_position(gen_platform.get_child(0).position)
		gen_extension.add_to_group("interactable")
		gen_platform.add_to_group("interactable")
		gen_platform.add_child(gen_extension)
		add_child(gen_platform)
		last_platform_height = height
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	generate()
