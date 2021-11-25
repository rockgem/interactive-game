extends Control

func _ready():
	$"/root/Music".play()
	
	$TextureRect.rect_pivot_offset = $TextureRect.rect_size / 2
	$TextureRect2.rect_pivot_offset = $TextureRect.rect_size / 2
	$TextureRect3.rect_pivot_offset = $TextureRect.rect_size / 2
	
	$Tween.interpolate_property($TextureRect, "rect_scale", Vector2(.1,.1), Vector2(1.0, 1.0), .5, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	$Tween.interpolate_property($TextureRect2, "rect_scale", Vector2(.1,.1), Vector2(1.0, 1.0), .5, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	$Tween.interpolate_property($TextureRect3, "rect_scale", Vector2(.1,.1), Vector2(1.0, 1.0), .5, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	
	$Timer.start()


func _on_Timer_timeout():
	$Tween.interpolate_property($TextureRect, "modulate", null, Color(1.0,1.0,1.0,0.0), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($TextureRect2, "modulate", null, Color(1.0,1.0,1.0,0.0), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($TextureRect3, "modulate", null, Color(1.0,1.0,1.0,0.0), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	$Name.show()
	$Buttons.show()


func _on_Menu_pressed():
	ManagerGameManager.emit_signal("load_level_activate", "MainMenu")


func _on_English_pressed():
	$Name.show()
	$NameSwahi.hide()


func _on_Kish_pressed():
	$Name.hide()
	$NameSwahi.show()
