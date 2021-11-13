extends Node
# SINGLETON -------------------- !!



signal speech_pop
signal narrate_pop
signal stopper_activate
signal visual_story_trigger
signal visual_story_deactivate
signal load_level_activate

signal stopper_forward
signal increase


var can_move: bool = true

var player_pos: Vector2



func load_level(level_id: String):
	emit_signal("load_level_activate", level_id)
