extends Area2D


var index = 0


func _ready():
	ManagerGameManager.connect("stopper_forward", self, "move")


func move(num: int):
	index += num
	
	if index <= 0:
		ManagerGameManager.can_move = true
		$CollisionShape2D.disabled = true
		$Timer.start(.2)
		return
	
	ManagerGameManager.emit_signal("increase", index)


func _on_VisualStoryTrigger_area_entered(area):
	ManagerGameManager.can_move = false
	ManagerGameManager.emit_signal("visual_story_trigger")


func _on_VisualStoryTrigger_area_exited(area):
	index = 0
	ManagerGameManager.emit_signal("visual_story_deactivate")


func _on_Timer_timeout():
	$CollisionShape2D.disabled = false
