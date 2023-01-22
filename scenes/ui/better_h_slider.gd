extends HSlider


var label
var grabber_width = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	label = get_node("Label")
	_on_value_changed(value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_drag_started():
	label.visible = true


func _on_drag_ended(value_changed):
	label.visible = false


func _on_value_changed(value):
	label.text = str(value)
	label.position.x = (get_rect().size.x-grabber_width)*get_as_ratio()-0.5*label.get_rect().size.x+0.5*grabber_width
