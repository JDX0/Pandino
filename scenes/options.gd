extends Control

func _ready():
	$MarginContainer/ScrollContainer/OptionsContainer/ControlsPanel/MarginContainer/GameOptions/SensitivitySlider.value = State.get_setting("sensitivity")
	$MarginContainer/ScrollContainer/OptionsContainer/SoundPanel/MarginContainer/SoundOptions/MasterSlider.value = State.get_setting("master_volume")*100
	$MarginContainer/ScrollContainer/OptionsContainer/SoundPanel/MarginContainer/SoundOptions/UISlider.value = State.get_setting("ui_volume")*100
	$MarginContainer/ScrollContainer/OptionsContainer/GraphicsPanel/MarginContainer/GraphicsOptions/FilmgrainSlider.value = State.get_setting("film_grain")
	$MarginContainer/ScrollContainer/OptionsContainer/SoundPanel/MarginContainer/SoundOptions/VibrateBetterCheckButton.init(State.get_setting("vibrate"))

func _process(_delta):
	pass

func _on_back_button_pressed():
	Sound.ui_back()
	TransitionScene.transition("res://scenes/menu.tscn")

func _on_account_info_button_pressed():
	Sound.ui_forward()
	TransitionScene.next_scene_args = State.user.id
	TransitionScene.transition("res://scenes/account_info.tscn")

func _on_sensitivity_slider_drag_ended(value_changed):
	if value_changed:
		State.set_setting("sensitivity",$MarginContainer/ScrollContainer/OptionsContainer/ControlsPanel/MarginContainer/GameOptions/SensitivitySlider.value)

func _on_master_slider_drag_ended(value_changed):
	if value_changed:
		State.set_setting("master_volume",$MarginContainer/ScrollContainer/OptionsContainer/SoundPanel/MarginContainer/SoundOptions/MasterSlider.value/100)

func _on_ui_slider_drag_ended(value_changed):
	if value_changed:
		State.set_setting("ui_volume",$MarginContainer/ScrollContainer/OptionsContainer/SoundPanel/MarginContainer/SoundOptions/UISlider.value/100)

func _on_delete_save_button_pressed():
	State.reset_save()

func _on_filmgrain_slider_drag_ended(value_changed):
	if value_changed:
		State.set_setting("film_grain",$MarginContainer/ScrollContainer/OptionsContainer/GraphicsPanel/MarginContainer/GraphicsOptions/FilmgrainSlider.value)

func _on_vibrate_better_check_button_toggled(button_pressed):
	State.set_setting("vibrate",button_pressed)
