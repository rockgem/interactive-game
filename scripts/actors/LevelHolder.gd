extends Panel



export(String) var level_id = "Level1"

func _ready():
	rect_pivot_offset = rect_size / 2
	$Panel.rect_pivot_offset = $Panel.rect_size / 2


func _on_LevelHolder_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		ManagerGameManager.load_level(level_id)
		$"/root/Click".play()


func _on_LevelHolder_mouse_entered():
	$Tween.interpolate_property(self, "rect_scale", null, Vector2(1.2,1.2), .2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Panel/TextureRect, "rect_scale", null, Vector2(0.8,0.8), .2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	$"/root/SwooshSfx".play()


func _on_LevelHolder_mouse_exited():
	$Tween.interpolate_property(self, "rect_scale", null, Vector2(1.0,1.0), .2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Panel/TextureRect, "rect_scale", null, Vector2(1.0,1.0), .2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
