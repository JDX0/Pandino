extends Control

var current = 0
var next = 0
var moving = false
enum Direction {LEFT = -1,RIGHT = 1}

func _ready():
	current = State.data["worlds"].keys().find(State.settings["selected_world"])
	%NameLabel.text = State.data["worlds"][State.data["worlds"].keys()[current]].name
	%Image.set_texture(load(State.data["worlds"][State.data["worlds"].keys()[current]].image))
	%SelectButton.text = "Select"
	$AnimationPlayer.play("RESET")

func move(direction):
	Sound.ui_forward()
	moving = true
	next = current + direction
	if next > State.data["worlds"].size()-1:
		next = 0
	if next < 0:
		next = State.data["worlds"].size()-1
	if State.data["worlds"][State.data["worlds"].keys()[next]].bought:
		%NextSelectButton.text = "Select"
	else:
		%NextSelectButton.text = str(State.data["worlds"][State.data["worlds"].keys()[next]].price) + "P"
	%NextNameLabel.text = State.data["worlds"][State.data["worlds"].keys()[next]].name
	%NextImage.set_texture(load(State.data["worlds"][State.data["worlds"].keys()[next]].image))
	current = next
	
#TODO
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
	if State.data["worlds"][State.data["worlds"].keys()[current]]["bought"]:
		Sound.ui_forward()
		var keys = State.data["worlds"].keys()
		State.settings["selected_world"] = keys[current]
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
	if anim_name != "RESET":
		%NameLabel.text = %NextNameLabel.text
		%Image.set_texture(%NextImage.get_texture())
		%SelectButton.text = %NextSelectButton.text
		$AnimationPlayer.play("RESET")
	moving = false
