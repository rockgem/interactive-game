extends Node2D


signal arrow_show


func _ready():
	$"/root/Music".play()
#	$Area1/Player.set_camera_bounds($TopLeft.global_position, $BottomRight.global_position)


func _on_Control_gui_input(event):
	pass # Replace with function body.
