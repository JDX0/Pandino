extends Sprite2D

func _ready():
	texture = load("res://assets/world/background_"+State.settings["selected_world"]+".png")

func _process(_delta):
	position = Vector2(0,%CharacterCamera.get_screen_center_position().y)
