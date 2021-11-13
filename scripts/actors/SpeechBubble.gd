extends TextureRect

var is_showing: bool = false

var player_node

export(String) var speech_id: String



func _ready():
	ManagerGameManager.connect("speech_pop", self, "speech_pop")
	ManagerGameManager.connect("stopper_activate", self, "hide")
	
	rect_pivot_offset.x = rect_size.x / 2
	rect_pivot_offset.y = rect_size.y / 2


func speech_pop(id: String):
	if id == speech_id:
		show()
		$AnimationPlayer.play("pop")
	else:
		hide()


func init_from_stopper(message: String):
	show()


#
#
#func _draw():
#	draw_line(rect_global_position - (rect_size / 2), ManagerGameManager.player_pos, Color(1,1,1,1), 10)










