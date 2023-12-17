extends CanvasLayer

var SCROLL_SPEED_H := 10
var SCROLL_SPEED_V:= 23

func _ready() -> void:
	if GlobalVars.last_level == 1:
		$MarginContainer/VBoxContainer/ContinueGame.visible = false

func _on_start_game_pressed() -> void:
	GlobalVars.score = 0
	if not GlobalVars.hi_score:
		GlobalVars.hi_score = 0
	GlobalVars.last_level = 1
	GlobalVars.save_game()
	get_tree().change_scene_to_file( GlobalVars.get_level_path(GlobalVars.last_level) )
	
func _on_continue_game_pressed() -> void:
	GlobalVars.score = 0
	if not GlobalVars.hi_score:
		GlobalVars.hi_score = 0
	GlobalVars.load_game()
	get_tree().change_scene_to_file( GlobalVars.get_level_path(GlobalVars.last_level) )

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_hi_score_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/hall_of_fame.tscn")

func _process(delta: float) -> void:
	$ParallaxBackground.scroll_offset.x += SCROLL_SPEED_H * delta
	$ParallaxBackground.scroll_offset.y += SCROLL_SPEED_V * delta
	pass

