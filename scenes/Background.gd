extends Sprite2D

func _process(_delta):
	position = Vector2(0,%CharacterCamera.get_screen_center_position().y)
