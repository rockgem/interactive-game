extends Control






func _on_Control_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		hide()
		$"/root/Click".play()
