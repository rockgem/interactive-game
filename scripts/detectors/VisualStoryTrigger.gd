extends Area2D

export(int) var slide_id = 0

var index = 0
var num = 0


func _ready():
	ManagerGameManager.connect("stopper_forward", self, "move")
	ManagerGameManager.connect("visual_story_deactivate", self, "visual_story_deactivate")


func move(num: int):
	index += num
	
	if index <= 0:
#		visual_story_deactivate()
		return
	
	ManagerGameManager.emit_signal("increase", index, num)


func visual_story_deactivate():
	ManagerGameManager.can_move = true


func _on_VisualStoryTrigger_area_entered(area):
	ManagerGameManager.can_move = false
	ManagerGameManager.emit_signal("visual_story_trigger", slide_id)


func _on_VisualStoryTrigger_area_exited(area):
	index = 0
	ManagerGameManager.emit_signal("visual_story_deactivate")


func _on_Timer_timeout():
	$CollisionShape2D.disabled = false


func _on_VisualStoryTrigger_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		ManagerGameManager.can_move = false
		ManagerGameManager.emit_signal("visual_story_trigger", slide_id)
		$"/root/Click".play()


func _on_VisualStoryTrigger_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_VisualStoryTrigger_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
