extends TextureRect

var is_showing: bool = false

var player_node

export(String) var speech_id: String



func _ready():
	ManagerGameManager.connect("speech_pop", self, "speech_pop")
	ManagerGameManager.connect("stopper_activate", self, "hide")


func speech_pop(id: String):
	if id == speech_id:
		show()
		set_physics_process(true)
	else:
		hide()
		set_physics_process(false)


func init_from_stopper(message: String):
	show()


#
#
#func _draw():
#	draw_line(rect_global_position - (rect_size / 2), ManagerGameManager.player_pos, Color(1,1,1,1), 10)










