extends Node2D

var viewport_rect
var last_platform_height = 200

# Generator Settings
## Difficulty increases over time
var difficulty = 0

var platforms = {"static":preload('res://scenes/platforms/platform.tscn'),"moving":preload('res://scenes/platforms/platform_moving.tscn'),"disappearing":preload('res://scenes/platforms/platform_disappearing.tscn')} # Dictionary of all platforms
var extensions = {"spring":preload('res://scenes/platforms/extensions/spring.tscn')} # Dictionary of all platform extensions
var detached_extensions = {"coin":preload('res://scenes/platforms/coin.tscn')} # Dictinary of all platform extensions
var platform_height_delta = -450
## The region in which moving platforms bounce around
## Relative to platform height
var move_area = Rect2(-600,0,1200,10)

var spring_chance = 0.1
var coin_chance = 0.34

func _ready():
	match State.settings["selected_world"]:
		"forest":
			$Branches/ParallaxLayer.modulate.a = 0.9
			$Branches/ParallaxLayer2.modulate.a = 0.75
			$Branches/ParallaxLayer3.modulate.a = 0.8
			$Wind/ParallaxLayer.modulate = Color("#00276730")
			$Wind/ParallaxLayer2.modulate = Color("#00276730")
			$Wind/ParallaxLayer3.modulate = Color("#00276730")
		"desert":
			$Branches/ParallaxLayer.modulate.a = 0.2
			$Branches/ParallaxLayer2.modulate.a = 0.15
			$Branches/ParallaxLayer3.modulate.a = 0.1
	randomize()
	viewport_rect = get_viewport().get_camera_2d().get_viewport_transform()
	print(viewport_rect)

func _process(_delta):
	$Wind/ParallaxLayer2.motion_offset.x += 10
	$Wind/ParallaxLayer3.motion_offset.x += 10
	$Wind/ParallaxLayer.motion_offset.x += 10
	
	difficulty = get_parent().score
	generate()

func generate():
	var player_height = get_node("Character").position.y
	
	if player_height < last_platform_height + 1500:
		platform_height_delta = clamp(-difficulty,-490,-150)
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
		if randf() < spring_chance and not platform_type == "moving":
			var gen_extension = get_random_from_dict(extensions).instantiate()
			var platform_size_x = platform.get_child(2).shape.get_rect().size.x
			var platform_offset = platform.get_child(1).position
			gen_extension.set_position(Vector2(0.5*platform_size_x-randf()*platform_size_x-platform_offset.x,platform.EXTENSION_HEIGHT-platform_offset.y))
			gen_extension.add_to_group("interactable")
			platform.get_child(1).add_child(gen_extension)
			
		# Generate coin
		if randf() < coin_chance:
			var gen_coin = get_random_from_dict(detached_extensions).instantiate()
			gen_coin.set_position(Vector2(randf()*1080-540,height - randf()*800))
			gen_coin.add_to_group("interactable")
			gen_coin.init(randi()%3+1)
			add_child(gen_coin)
		
		add_child(platform)
		last_platform_height = height
		
func get_random_from_dict(d : Dictionary):
	return d[d.keys()[randi()%d.keys().size()]]
	
func get_random_key_from_dict(d : Dictionary):
	return d.keys()[randi()%d.keys().size()]


