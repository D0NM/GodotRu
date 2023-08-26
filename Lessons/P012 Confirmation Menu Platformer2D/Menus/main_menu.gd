extends CanvasLayer

func _on_start_game_pressed() -> void:
	GlobalVars.score = 0
	if not GlobalVars.hi_score:
		GlobalVars.hi_score = 0
	get_tree().change_scene_to_file("res://Levels/level1.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_hi_score_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/hall_of_fame.tscn")
