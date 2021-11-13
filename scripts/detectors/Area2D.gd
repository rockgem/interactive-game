extends Area2D



func _on_Wall_area_entered(area):
	ManagerGameManager.can_move = false
