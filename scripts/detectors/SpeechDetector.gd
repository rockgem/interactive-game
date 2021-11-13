extends Area2D

export(String) var speech_id: String






func _on_SpeechDetector_area_entered(area):
	ManagerGameManager.emit_signal("speech_pop", speech_id)
