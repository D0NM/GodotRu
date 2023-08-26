extends Node

@onready var score = $HBoxContainer/MarginContainer2/Score
@onready var hi_score = $HBoxContainer/MarginContainer3/HiScore

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		# показать меню подтверждения по ESC
		if not $ConfirmationMenu.visible:
			show_confirmation_menu()
		else:
			hide_confirmation_menu()

	if not score or not hi_score:
		return
	score.text = "Очки: " + str( GlobalVars.score )
	hi_score.text = "Рекорд: " +str( GlobalVars.hi_score )
	
func show_confirmation_menu():
	$VBoxContainer/HBoxContainer/MarginContainer/ButtonToMenu.disabled = true
	$ConfirmationMenu.show()
	get_tree().paused = true # для ОСТАНОВА process во всей игре
	
func hide_confirmation_menu():
	$ConfirmationMenu.hide() # для запуска process
	$VBoxContainer/HBoxContainer/MarginContainer/ButtonToMenu.disabled = false
	get_tree().paused = false

func _on_button_to_menu_pressed() -> void:
	show_confirmation_menu()

func _on_button_no_pressed() -> void:
	hide_confirmation_menu()

func _on_button_yes_pressed() -> void:
	get_tree().paused = false # для запуска process
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
