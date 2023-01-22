extends Control

func _ready():
	get_node("MarginContainer/OptionsContainer/ControlsPanel/MarginContainer/GameOptions/SensitivitySlider").value = State.get_setting("sensitivity")

func _process(_delta):
	pass

func _on_back_button_pressed():
	TransitionScene.transition("res://scenes/menu.tscn")

func _on_account_info_button_pressed():
	TransitionScene.transition("res://scenes/account_info.tscn")

func _on_sensitivity_slider_drag_ended(value_changed):
	if value_changed:
		State.set_setting("sensitivity",get_node("MarginContainer/OptionsContainer/ControlsPanel/MarginContainer/GameOptions/SensitivitySlider").value)
