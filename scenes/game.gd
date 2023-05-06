extends Node

var score = 0
var max_player_height = 0

func _ready():
	if State.settings["film_grain"] >= 0:
		$CanvasLayer/GrainRect.visible = true
		$CanvasLayer/GrainRect.modulate.a = round(State.settings["film_grain"]*255)
	else:
		$CanvasLayer/GrainRect.visible = false
	State.state = "playing"

func _process(_delta):
	update_score()
	update_coins()

func update_score():
	var player_height = get_node("World/Character").position.y
	if player_height < max_player_height:
		max_player_height = player_height
	if player_height > max_player_height + 1000:
		die()
	score = round(-max_player_height/10)
	get_node("CanvasLayer/MarginContainer/HBoxContainer/ScoreLabel").text = str(score)
	
func update_coins():
	$CanvasLayer/MarginContainer/HBoxContainer/CoinLabel.text = str(State.coins)
	
func die():
	if State.state != "dead":
		State.state = "dead"
		save("score",score)
		Database.insert_score(score)
		TransitionScene.transition("res://scenes/death.tscn")
		#get_node("GameAnimationPlayer").play("death")
	
func save(field,value):
	# Save score locally
	var file = FileAccess.open("user://scores.pand", FileAccess.WRITE)
	file.store_string(str(field) + ":" + str(value))
	
func pause():
	Sound.ui_back()
	get_tree().paused = true
	get_node("CanvasLayer/Pause").visible = true
	get_node("CanvasLayer/Pause/PauseAnimationPlayer").play("pause")
	
func resume():
	Sound.ui_forward()
	get_tree().paused = false
	get_node("CanvasLayer/Pause/PauseAnimationPlayer").play("resume")

func _on_pause_animation_player_animation_finished(anim_name):
	match(anim_name):
		"pause":
			print("pause animation finished")
		"resume":
			print("resume animation finished")
			get_node("CanvasLayer/Pause").visible = false

func _on_pause_button_pressed():
	pause()

func _on_resume_button_pressed():
	resume()

func _on_menu_button_pressed():
	Sound.ui_back()
	TransitionScene.transition("res://scenes/menu.tscn")
	resume()
