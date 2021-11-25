extends Control



export(Array, Texture) var textures_arr: Array = []
export(int) var slide_id = 0

var sub_count: int = 0
var current_index: int = 0

var can_click = false

export(String) var level_id = "Level0"

export(bool) var is_last = false
export(String) var towards_level_id = ""


func _ready():
	ManagerGameManager.connect("visual_story_trigger", self, "visual_story_trigger")
	ManagerGameManager.connect("visual_story_deactivate", self, "visual_story_deactivate")
	ManagerGameManager.connect("increase", self, "increase")


func increase(num: int, num_identifier: int):
	$TextureRect.rect_position = Vector2.ZERO
	current_index = num
	
	$Go.show()
	$Back.show()
	
	if num <= 0:
		ManagerGameManager.emit_signal("visual_story_deactivate")
	
	if num > textures_arr.size():
		ManagerGameManager.emit_signal("visual_story_deactivate")
		if is_last:
			if towards_level_id != "":
				ManagerGameManager.emit_signal("load_level_activate", towards_level_id)
				return
		
		return
	
	if num_identifier > 0:
		$Tween.interpolate_property($TextureRect, "rect_position", Vector2(-90, 0), Vector2(0, 0), .2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.start()
	else:
		$Tween.interpolate_property($TextureRect, "rect_position", Vector2(90, 0), Vector2.ZERO, .2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.start()
	
	if level_id == "Level1":
		match(num):
			7:
				animate_sprite()
				$AnimatedSprite.play("subcount")
			8:
				animate_sprite()
				$AnimatedSprite.play("ads")
	elif level_id == "Level2":
		match(num):
			5:
				$OptionalAnimatedTexture.texture = load("res://assets/ui/popups/search.PNG")
				$OptionalAnimatedTexture/SearchbarTyping.text = "How do I make interesting content?"
				$OptionalAnimatedTexture/Tween.interpolate_property($OptionalAnimatedTexture/SearchbarTyping, "percent_visible", 0, 1, 1.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
				$OptionalAnimatedTexture/Tween.start()
				$OptionalAnimatedTexture/SearchbarTyping.show()
				animate_texture()
			8:
				$OptionalAnimatedTexture.texture = load("res://assets/ui/popups/search.PNG")
				$OptionalAnimatedTexture/SearchbarTyping.text = "What not to post online?"
				$OptionalAnimatedTexture/Tween.interpolate_property($OptionalAnimatedTexture/SearchbarTyping, "percent_visible", 0, 1, 1.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
				$OptionalAnimatedTexture/Tween.start()
				$OptionalAnimatedTexture/SearchbarTyping.show()
				animate_texture()
			_:
				$AnimatedSprite.hide()
				$AnimatedSprite.stop()
				$OptionalAnimatedTexture.hide()
				$OptionalAnimatedTexture/SearchbarTyping.hide()
				$OptionalAnimatedTexture/Label.hide()
	elif level_id == "Level3":
		match(num):
			3:
				$OptionalAnimatedTexture.texture = load("res://assets/ui/popups/level3popups/1.jpg")
				animate_texture()
			4:
				$OptionalAnimatedTexture.texture = load("res://assets/ui/popups/level3popups/2.jpg")
				animate_texture()
			5,7:
				$OptionalAnimatedTexture.texture = load("res://assets/ui/popups/level3popups/3.jpg")
				animate_texture()
			8,9:
				$OptionalAnimatedTexture.hide()
				animate_sprite()
				$AnimatedSprite.play("streaming")
			10:
				$OptionalAnimatedTexture.texture = load("res://assets/ui/popups/level3popups/5.jpg")
				animate_texture()
			11:
				$OptionalAnimatedTexture.texture = load("res://assets/ui/popups/level3popups/6.jpg")
				animate_texture()
			_:
				$AnimatedSprite.hide()
				$AnimatedSprite.stop()
				$OptionalAnimatedTexture.hide()
				$OptionalAnimatedTexture/SearchbarTyping.hide()
				$OptionalAnimatedTexture/Label.hide()
	
	$TextureRect.texture = textures_arr[num - 1]


func visual_story_trigger(id: int):
	if id != slide_id:
		return
	can_click = true
	show()
	increase(1, 1)


func visual_story_deactivate():
	if slide_id == 1:
		ManagerGameManager.emit_signal("arrow_indicator")
	$Go.hide()
	$TextureRect.texture = null
	can_click = false
	current_index = 0
	hide()


func animate_sprite():
	$Pop.play()
	$OptionalAnimatedTexture.hide()
	$Tween.interpolate_property($AnimatedSprite, "scale", Vector2(0.1, 0.1), Vector2(0.58, 0.58), .5, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$AnimatedSprite.show()
	$Tween.start()

func animate_texture():
	$OptionalAnimatedTexture.rect_pivot_offset.x = $OptionalAnimatedTexture.rect_size.x / 2
	$OptionalAnimatedTexture.rect_pivot_offset.y = $OptionalAnimatedTexture.rect_size.y / 2
	$Pop.play()
	$AnimatedSprite.hide()
	$AnimatedSprite.stop()
	$OptionalAnimatedTexture.show()
	$Tween.interpolate_property($OptionalAnimatedTexture, "rect_scale", Vector2(0.1, 0.1), Vector2(1.0, 1.0), .5, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()


func _on_Tween_tween_step(object, key, elapsed, value):
	$OptionalAnimatedTexture/Label.text = str(stepify(value, 1))


func _on_Tween_tween_completed(object, key):
	$OptionalAnimatedTexture/Label.text = "100,000"


func _on_SlideshowHolder_gui_input(event):
	if can_click:
		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			increase(current_index + 1, 1)
			$"/root/SwooshSfx".play()
		elif event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT:
			increase(current_index - 1, 1)
			$"/root/SwooshSfx".play()


func _on_Go_pressed():
	increase(current_index + 1, 1)
	$"/root/SwooshSfx".play()


func _on_Back_pressed():
	increase(current_index - 1, 1)
	$"/root/SwooshSfx".play()
