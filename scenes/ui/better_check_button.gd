extends Button
		
var stupid = false
		
func init(pressed):
	button_pressed = pressed
	if pressed:
		stupid = true
		$AnimationPlayer.play("RESET")
	else:
		$AnimationPlayer.play("RESET_REVERSE")

func _on_toggled(button_pressed):
	if button_pressed:
		if stupid:
			stupid = false
			print("stupid")
		else:
			Sound.ui_forward()
			print("not stupid")
		$AnimationPlayer.play("disable")
	else:
		Sound.ui_back()
		$AnimationPlayer.play("enable")
