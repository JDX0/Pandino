extends Node2D

var viewport_rect
var last_platform_height = 200

# Generator Settings
## Difficulty increases over time
var difficulty = 1

var platforms = {"static":preload('res://scenes/platforms/platform.tscn'),"moving":preload('res://scenes/platforms/platform_moving.tscn'),"disappearing":preload('res://scenes/platforms/platform_disappearing.tscn')} # Dictionary of all platforms
var extensions = {"spring":preload('res://scenes/platforms/extensions/spring.tscn')} # Dictionary of all platform extensions
var detached_extensions = {"coin":preload('res://scenes/platforms/coin.tscn')} # Dictinary of all platform extensions
var platform_height_delta = -450
## The region in which moving platforms bounce around
## Relative to platform height
var move_area = Rect2(-540,0,1080,10)

var spring_chance = 0.1
var coin_chance = 0.34

func _ready():
	randomize()
	viewport_rect = get_viewport().get_camera_2d().get_viewport_transform()
	print(viewport_rect)

func _process(_delta):
	generate()

func generate():
	var player_height = get_node("Character").position.y
	
	if player_height < last_platform_height + 1000:
		var height = last_platform_height+platform_height_delta
		var platform_type = get_random_key_from_dict(platforms)
		var platform = platforms[platform_type].instantiate()
		if platform_type == "moving":
			var current_platform_move_area = move_area
			current_platform_move_area.position.y = height
			platform.init(current_platform_move_area)
		var randx = int(randi_range(-380+platform.get_size().x,380-platform.get_size().x))
		if randx < 0:
			platform.scale.x = -platform.scale.x
		platform.set_position(Vector2(randx,height))
		platform.add_to_group("interactable")
		
		# Generate spring
		if randf() < spring_chance:
			var gen_extension = get_random_from_dict(extensions).instantiate()
			var platform_size_x = platform.get_child(2).shape.get_rect().size.x
			gen_extension.set_position(Vector2(0.5*platform_size_x-randf()*platform_size_x,platform.EXTENSION_HEIGHT))
			gen_extension.add_to_group("interactable")
			platform.add_child(gen_extension)
			
		# Generate coin
		if randf() < coin_chance:
			var gen_coin = get_random_from_dict(detached_extensions).instantiate()
			gen_coin.set_position(Vector2(randf()*1080-540,height - randf()*800))
			gen_coin.add_to_group("interactable")
			add_child(gen_coin)
		
		add_child(platform)
		last_platform_height = height
		
func get_random_from_dict(d : Dictionary):
	return d[d.keys()[randi()%d.keys().size()]]
	
func get_random_key_from_dict(d : Dictionary):
	return d.keys()[randi()%d.keys().size()]


