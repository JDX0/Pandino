extends HSlider


var label
var grabber_width = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	label = get_node("Label")
	_on_value_changed(value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_drag_started():
	Sound.ui_warn()
	label.visible = true
	$AnimationPlayer.play("show_label")


func _on_drag_ended(_val_changed):
	Sound.ui_forward()
	$AnimationPlayer.play("hide_label")


func _on_value_changed(val):
	label.text = str(val)
	label.position.x = (get_rect().size.x-grabber_width)*get_as_ratio()-0.5*label.get_rect().size.x+0.5*grabber_width


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "hide_label":
		label.visible = false
