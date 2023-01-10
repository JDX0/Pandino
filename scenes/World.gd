extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var platform = preload('res://scenes/platform.tscn')
var last_platform_height = 200
# Generator Settings
var platform_height_delta = -450

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#get_tree().paused=true

func generate():
	var player_height = get_node("Character").position.y
	
	if player_height < last_platform_height + 100:
		var height = last_platform_height+platform_height_delta
		var gen_platform
		gen_platform = platform.instantiate()
		var randx = int(randi_range(-500,500))
		if randx < 0:
			gen_platform.scale.x = -gen_platform.scale.x
		gen_platform.set_position(Vector2(randx,height))
		add_child(gen_platform)
		last_platform_height = height
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	generate()
