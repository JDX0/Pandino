extends Control

var current = 0
var next = 0
enum Direction {LEFT = -1,RIGHT = 1}

var carousel_data = [
	{"id":"panda","name": "Panda","image": "res://assets/character/Skins/panda.png","price":0,"bought":true},
	{"id":"panda_red","name": "Red Panda","image": "res://assets/character/Skins/panda_red.png","price":125,"bought":false}
]

func _ready():
	pass

func move(direction):
	next = current + direction
	if next > carousel_data.size()-1:
		next = 0
	if next < 0:
		next = carousel_data.size()-1
	if carousel_data[next].bought:
		%NextSelectButton.text = "Select"
	else:
		%NextSelectButton.text = str(carousel_data[next].price) + "P"
	%NextNameLabel.text = carousel_data[next].name
	%NextImage.set_texture(load(carousel_data[next].image))
	current = next
	
func buy():
	pass
	
func select():
	State.settings["selected_skin"] = carousel_data[current].id

func _on_left_button_pressed():
	move(Direction.LEFT)
	$AnimationPlayer.play("left")

func _on_right_button_pressed():
	move(Direction.RIGHT)
	$AnimationPlayer.play("right")

func _on_animation_player_animation_finished(anim_name):
	%NameLabel.text = %NextNameLabel.text
	%Image.set_texture(%NextImage.get_texture())
	%SelectButton.text = %NextSelectButton.text
	$AnimationPlayer.play("RESET")
