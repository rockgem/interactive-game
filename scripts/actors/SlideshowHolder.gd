extends Control



export(Array, Texture) var textures_arr: Array = []



func _ready():
	ManagerGameManager.connect("visual_story_trigger", self, "visual_story_trigger")
	ManagerGameManager.connect("visual_story_deactivate", self, "visual_story_deactivate")
	ManagerGameManager.connect("increase", self, "increase")


func increase(num: int):
	$TextureRect.rect_position = Vector2.ZERO
	if num > textures_arr.size():
		return
	
	$Tween.interpolate_property($TextureRect, "rect_position", null, Vector2(-90, 0), .2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	$TextureRect.texture = textures_arr[num - 1]


func visual_story_trigger():
	show()


func visual_story_deactivate():
	$TextureRect.texture = null
