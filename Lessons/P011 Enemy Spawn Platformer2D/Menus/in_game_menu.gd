extends Node

@onready var score = $HBoxContainer/MarginContainer2/Score
@onready var hi_score = $HBoxContainer/MarginContainer3/HiScore


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
	queue_free()

func _process(delta: float) -> void:
	if not score or not hi_score:
		return
	score.text = "Очки: " + str( GlobalVars.score )
	hi_score.text = "Рекорд: " +str( GlobalVars.hi_score )
