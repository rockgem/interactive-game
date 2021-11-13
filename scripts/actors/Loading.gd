extends Panel


var is_loading: bool = false

var loader

func _ready():
	ManagerGameManager.connect("load_level_activate", self, "load_level_activate")
	
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
	loader = ResourceLoader.load_interactive("res://scenes/levels/%s.tscn" % level_id)
	is_loading = true
	
	$ProgressBar.max_value = float(loader.get_stage_count())
	
	show()
	set_process(true)
