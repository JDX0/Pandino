extends Control

var current = 0
var next = 0
var moving = false
enum Direction {LEFT = -1,RIGHT = 1}

func _ready():
	pass

func move(direction):
	Sound.ui_forward()
	moving = true
	next = current + direction
	if next > State.data["items"].size()-1:
		next = 0
	if next < 0:
		next = State.data["items"].size()-1
	if State.data["items"][next].bought:
		%NextSelectButton.text = "Select"
	else:
		%NextSelectButton.text = str(State.data["items"][next].price) + "P"
	%NextNameLabel.text = State.data["items"][next].name
	%NextImage.set_texture(load(State.data["items"][next].image))
	current = next
	
func buy():
	if State.data["items"][current]["price"] <= State.coins:
		State.coins -= State.data["items"][current]["price"]
		get_node("../MarginContainer/VBoxContainer/CoinLabel").text = str(State.coins)
		State.data["items"][current]["bought"] = true
		%SelectButton.text = "Select"
		%NextSelectButton.text = "Select"
		Sound.ui_forward()
		return true
	else:
		Sound.ui_warn()
		#indicate not enough coins
		return false
	
func select():
	if State.data["items"][current]["bought"]:
		Sound.ui_forward()
		State.settings["selected_skin"] = State.data["items"][current].id
	else:
		if buy():
			select()

func _on_left_button_pressed():
	if not moving:
		move(Direction.LEFT)
		$AnimationPlayer.play("left")

func _on_right_button_pressed():
	if not moving:
		move(Direction.RIGHT)
		$AnimationPlayer.play("right")

func _on_animation_player_animation_finished(anim_name):
	%NameLabel.text = %NextNameLabel.text
	%Image.set_texture(%NextImage.get_texture())
	%SelectButton.text = %NextSelectButton.text
	$AnimationPlayer.play("RESET")
	moving = false
