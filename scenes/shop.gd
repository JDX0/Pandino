extends Control

var snap = false
var n_items

func _ready():
	n_items = %ScrollContainer.get_child(0).get_child_count()
	$MarginContainer/VBoxContainer/CoinLabel.text = str(State.coins)
	print(n_items)
	print(%ScrollContainer.get_child(0).get_rect())
	
func _process(_delta):
	if snap:
		$MarginContainer/SceneLabel.text = str(%ScrollContainer.scroll_horizontal)

func _on_back_button_pressed():
	TransitionScene.transition("res://scenes/menu.tscn")


func _on_scroll_container_scroll_started():
	snap = false


func _on_scroll_container_scroll_ended():
	snap = true
