extends Button
		
func init(pressed):
	button_pressed = pressed
	if pressed:
		$AnimationPlayer.play("RESET")
	else:
		$AnimationPlayer.play("RESET_REVERSE")

func _on_toggled(button_pressed):
	if button_pressed:
		Sound.ui_forward()
		$AnimationPlayer.play("disable")
	else:
		Sound.ui_back()
		$AnimationPlayer.play("enable")
