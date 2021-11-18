extends Panel


var is_loading: bool = false

var loader

func _ready():
	ManagerGameManager.connect("load_level_activate", self, "load_level_activate")
	ManagerGameManager.connect("load_main_menu", self, "main_menu_scene")
	
	set_process(false)


func _process(delta):
	if is_loading:
		
		var err = loader.poll()
		
		if err == OK:
			$ProgressBar.value = float(loader.get_stage())
		elif err == ERR_FILE_EOF:
			is_loading = false
			get_tree().change_scene_to(loader.get_resource())
			set_process(false)
		


func load_level_activate(level_id: String):
	if level_id == "MainMenu":
		main_menu_scene()
		return
	loader = ResourceLoader.load_interactive("res://scenes/levels/%s.tscn" % level_id)
	is_loading = true
	
	$ProgressBar.max_value = float(loader.get_stage_count())
	
	var level_name: String
	match(level_id):
		"Level1": level_name = "Part 1"
		"Level2": level_name = "Part 2"
		"Level3": level_name = "Part 3"
		
	
	$Label2.text = level_name
	show()
	set_process(true)


func main_menu_scene():
	loader = ResourceLoader.load_interactive("res://scenes/Title.tscn")
	is_loading = true
	
	$ProgressBar.max_value = float(loader.get_stage_count())
	
	$Label2.text = "Main Menu"
	show()
	set_process(true)
