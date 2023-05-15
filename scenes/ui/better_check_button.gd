extends Button
		
func init(press):
	button_pressed = press
	if pressed:
		$AnimationPlayer.play("RESET")
	else:
		$AnimationPlayer.play("RESET_REVERSE")

func _on_toggled(_button_pressed):
	if _button_pressed:
		Sound.ui_forward()
		$AnimationPlayer.play("disable")
	else:
		Sound.ui_back()
		$AnimationPlayer.play("enable")
