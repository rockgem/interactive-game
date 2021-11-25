extends Control


func _ready():
	$"/root/Music".play()


func _on_Credits_pressed():
	ManagerGameManager.emit_signal("load_level_activate", "Credits")
