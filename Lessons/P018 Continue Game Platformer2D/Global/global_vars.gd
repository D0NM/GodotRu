extends Node

var score : int
var hi_score : int

var config
var path_to_save_file := "user://game.cfg"
var section_name := "game" #!!!

var starts_n = 0  # сколько раз вообще запускали игру
var deaths_n : int = 0 # сколько раз вообще умирал игрок
var kills_n := 0 # сколько игрок убил всего монстров
var saves_n :=  0 # сколько раз сохранялись в игре вообще
var player1_name : String

var last_level : String = "" # последний уровень, на который мы попали

func _ready() -> void:	
#	print("globals.gd автоматически загружен!")
	load_game()
	starts_n += 1

func save_game() -> void:
	saves_n += 1
	config.set_value(section_name, "player_name", player1_name)
	config.set_value(section_name, "starts_n", starts_n)
	config.set_value(section_name, "deaths_n", deaths_n)
	config.set_value(section_name, "kills_n", kills_n)
	config.set_value(section_name, "saves_n", saves_n)	
	config.set_value(section_name, "last_level", last_level);	
	config.save(path_to_save_file)
	
# нельзя использовать имя save 
func load_game() -> void:
	config = ConfigFile.new()
	config.load(path_to_save_file)
	player1_name = config.get_value(section_name, "player_name", "Игрок1")
	starts_n = config.get_value(section_name, "starts_n", 0)
	deaths_n = config.get_value(section_name, "deaths_n", 0)
	kills_n = config.get_value(section_name, "kills_n", 0)
	saves_n = config.get_value(section_name, "saves_n", 0)	
	last_level = config.get_value(section_name, "last_level", "")
