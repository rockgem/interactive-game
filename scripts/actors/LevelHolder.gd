extends Panel



export(String) var level_id = "Level1"


func _on_LevelHolder_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		ManagerGameManager.load_level(level_id)
