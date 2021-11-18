extends AnimationPlayer




func _ready():
	ManagerGameManager.connect("arrow_indicator", self, "arrow_indicator")


func arrow_indicator():
	play("indicator")
