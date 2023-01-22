extends HSlider


var label


# Called when the node enters the scene tree for the first time.
func _ready():
	label = get_node("Label")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_drag_started():
	label.visible = true


func _on_drag_ended(value_changed):
	label.visible = false


func _on_value_changed(value):
	label.text = str(value)
	label.position.x = (get_rect().size.x-label.get_rect().size.x)*get_as_ratio()