extends Control



export(Array, Texture) var textures_arr: Array = []

var sub_count: int = 0
var current_index: int = 0

var can_click = false

export(String) var level_id = "Level0"



func _ready():
	ManagerGameManager.connect("visual_story_trigger", self, "visual_story_trigger")
	ManagerGameManager.connect("visual_story_deactivate", self, "visual_story_deactivate")
	ManagerGameManager.connect("increase", self, "increase")


func increase(num: int, num_identifier: int):
	$TextureRect.rect_position = Vector2.ZERO
	current_index = num
	
	$Label2.show()
	
	if num <= 0:
		ManagerGameManager.emit_signal("visual_story_deactivate")
	
	if num > textures_arr.size():
		ManagerGameManager.emit_signal("visual_story_deactivate")
		return
	
	if num_identifier > 0:
		$Tween.interpolate_property($TextureRect, "rect_position", Vector2(-90, 0), Vector2(0, 0), .2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.start()
	else:
		$Tween.interpolate_property($TextureRect, "rect_position", Vector2(90, 0), Vector2.ZERO, .2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.start()
	
	if level_id == "Level1" and num == 7:
		$OptionalAnimatedTexture.texture = load("res://assets/ui/popups/sub count preview.PNG")
		$OptionalAnimatedTexture.show()
		$OptionalAnimatedTexture/Tween.interpolate_property(self, "sub_count", 0, 100000, 1.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$OptionalAnimatedTexture/Tween.start()
		$OptionalAnimatedTexture/Label.show()
	elif level_id == "Level2" and num == 5:
		$OptionalAnimatedTexture.texture = load("res://assets/ui/popups/search.PNG")
		$OptionalAnimatedTexture.show()
		$OptionalAnimatedTexture/SearchbarTyping.text = "How do I make interesting content?"
		$OptionalAnimatedTexture/Tween.interpolate_property($OptionalAnimatedTexture/SearchbarTyping, "percent_visible", 0, 1, 1.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$OptionalAnimatedTexture/Tween.start()
		$OptionalAnimatedTexture/SearchbarTyping.show()
	elif level_id == "Level2" and num == 8:
		$OptionalAnimatedTexture.texture = load("res://assets/ui/popups/search.PNG")
		$OptionalAnimatedTexture.show()
		$OptionalAnimatedTexture/SearchbarTyping.text = "What not to post online?"
		$OptionalAnimatedTexture/Tween.interpolate_property($OptionalAnimatedTexture/SearchbarTyping, "percent_visible", 0, 1, 1.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$OptionalAnimatedTexture/Tween.start()
		$OptionalAnimatedTexture/SearchbarTyping.show()
	else:
		$OptionalAnimatedTexture.hide()
		$OptionalAnimatedTexture/SearchbarTyping.hide()
		$OptionalAnimatedTexture/Label.hide()
	
	$TextureRect.texture = textures_arr[num - 1]


func visual_story_trigger():
	can_click = true
	show()
	increase(1, 1)


func visual_story_deactivate():
	$Label2.hide()
	$TextureRect.texture = null
	can_click = false
	current_index = 0
	hide()


func _on_Tween_tween_step(object, key, elapsed, value):
	$OptionalAnimatedTexture/Label.text = str(stepify(value, 1))


func _on_Tween_tween_completed(object, key):
	$OptionalAnimatedTexture/Label.text = "100,000"


func _on_SlideshowHolder_gui_input(event):
	if can_click:
		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			increase(current_index + 1, 1)
