extends Area2D


var speech_bubble_holder = load("res://actors/ui/SpeechBubble.tscn")

var current_speech_bubble_ref = null

export(int) var max_index = 1
var index = 0

var dialogs_list: Dictionary = {
	1: {"key": "player", "text": "Alexa, how can I make content online? By the way, what is content?"},
	2: {"key": "npc", "text": "Digital content is information that is digitally broadcast, streamed, or contained in computer files. Such as videos, music, images and text."},
	3: {"key": "img_pop", "text": ""},
	4: {"key": "player", "text": "Cool, cool… so can make doh from it?"},
	5: {"key": "npc", "text": "Searching “All recipes” for dough…"},
	6: {"key": "img_pop", "text": ""},
	7: {"key": "player", "text": "No, no, no! How do I make money from online content?"},
	8: {"key": "npc", "text": "You can make money by generating subscribers (animation of subscribers number increases from 0 – 100,000)"},
	9: {"key": "img_pop", "text": ""},
	10: {"key": "npc", "text": "Selling ads (animation of ads being circled on a webpage) or selling content itself"},
	11: {"key": "img_pop", "text": ""},

}

func _ready():
	ManagerGameManager.connect("stopper_forward", self, "move")


func move(num: int):
	index += num
	if current_speech_bubble_ref != null:
		current_speech_bubble_ref.queue_free()
		current_speech_bubble_ref = null
	
	if index <= 0:
		ManagerGameManager.can_move = true
		$CollisionShape2D.disabled = true
		$Timer.start(.2)
		return
	
	var new_bubble = speech_bubble_holder.instance()
	
	var obj = dialogs_list.get(index)
	var key = obj.get("key")
	
	if key == "player":
		$Player.add_child(new_bubble)
	elif key == "npc":
		$NPC.add_child(new_bubble)
	elif key == "img_pop":
		pass
	
	new_bubble.init_from_stopper(obj.get("text"))
	current_speech_bubble_ref = new_bubble
	


func _on_Stopper_area_entered(area):
	ManagerGameManager.emit_signal("stopper_activate")
	ManagerGameManager.can_move = false


func _on_Timer_timeout():
	$CollisionShape2D.disabled = false


func _on_Stopper_area_exited(area):
	index = 0
