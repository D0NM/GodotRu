extends Node

var config
var path_to_save_file := "user://game.cfg"
var section_name := "game" #имя секции не может содержать пробелы
#const password = "КряЁ!!!"

var starts_n = 0  # сколько раз вообще запускали игру
var deaths_n : int = 0 # сколько раз вообще умирал игрок
var kills_n := 0 # сколько игрок убил всего монстров
var saves_n :=  0 # сколько раз сохранялись в игре вообще
var player1_name : String
var self_modulate_r := 1.0 # красный цвет
var scale_x := 1.0 # масштаб по Х

func _ready() -> void:	
	print("globals.gd автоматически загружен!")
	load_game()
	starts_n += 1

func save_game() -> void:
	saves_n += 1
	config.set_value(section_name, "player_name", player1_name)
	config.set_value(section_name, "starts_n", starts_n)
	config.set_value(section_name, "deaths_n", deaths_n)
	config.set_value(section_name, "kills_n", kills_n)
	config.set_value(section_name, "saves_n", saves_n)	
	# добавил ширину и красноту
	config.set_value(section_name, "self_modulate_r", self_modulate_r)
	config.set_value(section_name, "scale_x", scale_x)	
#	config.save_encrypted_pass(path_to_save_file, password)
	config.save_encrypted_pass(path_to_save_file, OS.get_unique_id())
	print("Игра сохранена!")

# нельзя использовать имя save 
func load_game() -> void:
	config = ConfigFile.new()
#	config.load_encrypted_pass(path_to_save_file, password)
	config.load_encrypted_pass(path_to_save_file, OS.get_unique_id())
	player1_name = config.get_value(section_name, "player_name", "Игрок1")
	starts_n = config.get_value(section_name, "starts_n", 0)
	deaths_n = config.get_value(section_name, "deaths_n", 0)
	kills_n = config.get_value(section_name, "kills_n", 0)
	saves_n = config.get_value(section_name, "saves_n", 0)	
	# добавил ширину и красноту	
	self_modulate_r = config.get_value(section_name, "self_modulate_r", 1.0)
	scale_x = config.get_value(section_name, "scale_x", 1.0)
	print("Игра загружена!")
