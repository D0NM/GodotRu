extends Node

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
