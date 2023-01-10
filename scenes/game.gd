extends Node

var score = 0
var max_player_height = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	update_score()

func update_score():
	var player_height = get_node("World/Character").position.y
	if player_height < max_player_height:
		max_player_height = player_height
	score = round(-max_player_height/100)
	get_node("CanvasLayer/MarginContainer/ScoreLabel").text = str(score)
	
func pause():
	get_tree().paused = true
	get_node("CanvasLayer/Pause").visible = true
	#get_node("CanvasLayer/Pause/MarginContainer2/ResumeButton").disabled = false
	get_node("CanvasLayer/Pause/PauseAnimationPlayer").play("pause")
	
func resume():
	get_tree().paused = false
	get_node("CanvasLayer/Pause/PauseAnimationPlayer").play("resume")

func _on_pause_animation_player_animation_finished(anim_name):
	match(anim_name):
		"pause":
			print("pause animation finished")
		"resume":
			print("resume animation finished")
			get_node("CanvasLayer/Pause").visible = false
			#get_node("CanvasLayer/Pause/MarginContainer2/ResumeButton").disabled = true

func _on_pause_button_pressed():
	pause()


func _on_resume_button_pressed():
	resume()
