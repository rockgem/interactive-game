extends Node
# SINGLETON -------------------- !!



signal speech_pop
signal narrate_pop
signal stopper_activate
signal visual_story_trigger
signal visual_story_deactivate
signal load_level_activate
signal in_game_menu_pop
signal load_main_menu
signal arrow_indicator

signal stopper_forward
signal increase


var can_move: bool = true

var player_pos: Vector2


func _unhandled_key_input(event):
	if event is InputEventKey and event.is_action_released("ui_cancel"):
		emit_signal("in_game_menu_pop")


func load_level(level_id: String):
	emit_signal("load_level_activate", level_id)
