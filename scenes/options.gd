extends Control

func _ready():
	$MarginContainer/OptionsContainer/ControlsPanel/MarginContainer/GameOptions/SensitivitySlider.value = State.get_setting("sensitivity")
	$MarginContainer/OptionsContainer/SoundPanel/MarginContainer/SoundOptions/MasterSlider.value = State.get_setting("master_volume")

func _process(_delta):
	pass

func _on_back_button_pressed():
	TransitionScene.transition("res://scenes/menu.tscn")

func _on_account_info_button_pressed():
	TransitionScene.transition("res://scenes/account_info.tscn")

func _on_sensitivity_slider_drag_ended(value_changed):
	if value_changed:
		State.set_setting("sensitivity",$MarginContainer/OptionsContainer/ControlsPanel/MarginContainer/GameOptions/SensitivitySlider.value)

func _on_master_slider_drag_ended(value_changed):
	if value_changed:
		State.set_setting("master_volume",$MarginContainer/OptionsContainer/SoundPanel/MarginContainer/SoundOptions/MasterSlider.value)

func _on_delete_save_button_pressed():
	State.reset_save()
