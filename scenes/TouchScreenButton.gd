extends TouchScreenButton

var radius = Vector2(124, 124)

var drag = -1

onready var boundary = get_parent().texture.get_size()

func _ready():
	if !visible:
		get_parent().hide()


func _process(delta):
	if drag == -1:
		global_position = get_parent().global_position - normal.get_size() / 2 * global_scale


func _input(event):
	if event is InputEventScreenDrag:
		global_position = event.position - normal.get_size() / 2 * global_scale
		
		drag = event.index
	
	if event is InputEventScreenTouch and !event.is_pressed() and drag == event.index:
		drag = -1


func get_pos() -> float:
	var dif = get_parent().global_position.direction_to(global_position)
	dif.normalized()
	print(dif)
	
	return dif
