extends AnimatableBody2D

const INTERACT_TYPE = "platform_moving"
const EXTENSION_HEIGHT = -30
var speed : Vector2 = Vector2(-333,0)
var sprite_rect_size : Vector2
var move_area : Rect2

func init(move_area_rect : Rect2 = Rect2(0,0,1080,10)):
	move_area = move_area_rect

func _ready():
	sprite_rect_size = $Sprite2D.get_rect().size*$Sprite2D.get_scale()

func _process(_delta):
	#print(position.x)
	pass
	
func _physics_process(delta):
	if position.x > move_area.size.x + move_area.position.x - sprite_rect_size.x*0.5 or position.x < move_area.position.x+sprite_rect_size.x*0.5:
		speed = -speed
	position += speed*delta

func interact():
	return [INTERACT_TYPE]

func get_size():
	return sprite_rect_size

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
