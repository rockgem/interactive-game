extends Panel


func _ready():
	ManagerGameManager.connect("in_game_menu_pop", self, "show")


func _on_Menu_pressed():
	ManagerGameManager.emit_signal("load_main_menu")
	$"/root/Click".play()
	hide()


func _on_Close_pressed():
	$"/root/Click".play()
	hide()
