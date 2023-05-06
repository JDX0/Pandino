extends Node

func ui_forward():
	if State.settings["vibrate"]:
		Input.vibrate_handheld(100)
	$UIForward.play()

func ui_back():
	if State.settings["vibrate"]:
		Input.vibrate_handheld(100)
	$UIBack.play()
	
func ui_warn():
	if State.settings["vibrate"]:
		Input.vibrate_handheld(300)
	$UIWarn.play()
