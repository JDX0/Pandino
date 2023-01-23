extends Node2D

var platforms = [preload('res://scenes/platforms/platform.tscn')] # array of all platforms
var extensions = [preload('res://scenes/platforms/extensions/spring.tscn')] # array of all platform extensions
var detached_extensions = [preload('res://scenes/platforms/extensions/detached/coin.tscn')] # array of all platform extensions
var last_platform_height = 200

# Generator Settings
var platform_height_delta = -450

var spring_chance = 0.1
var coin_chance = 0.34

func _ready():
	randomize()

func _process(_delta):
	generate()

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
		gen_platform.add_to_group("interactable")
		if randf() < spring_chance:
			var gen_extension = extensions[0].instantiate()
			var platform_size_x = gen_platform.get_child(2).shape.get_rect().size.x
			gen_extension.set_position(Vector2(0.5*platform_size_x-randf()*platform_size_x,gen_platform.EXTENSION_HEIGHT))
			gen_extension.add_to_group("interactable")
			gen_platform.add_child(gen_extension)
		if randf() < coin_chance:
			var gen_extension = detached_extensions[0].instantiate()
			var platform_size_x = gen_platform.get_child(2).shape.get_rect().size.x
			gen_extension.set_position(Vector2(0.5*platform_size_x-randf()*platform_size_x,platform_height_delta*randf()))
			gen_extension.add_to_group("interactable")
			gen_platform.add_child(gen_extension)
		
		
		add_child(gen_platform)
		last_platform_height = height


