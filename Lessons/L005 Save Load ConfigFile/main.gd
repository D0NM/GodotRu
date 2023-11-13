extends Node2D # Урок L5 СОХРАНЕНИЕ ИГРЫ

func _process(delta: float) -> void:
	$Morda.rotation += 0.1 * delta; $Morda.scale.y = 1.0 + sin($Morda.rotation*15) / 3.0
	$VBoxContainer/StartsN.text = "Игра запускалась " + str(Globals.starts_n) +" раз"
	$VBoxContainer/DeathsN.text = "Игрок умер " + str(Globals.deaths_n) +" раз"
	$VBoxContainer/KillsN.text = "Игрок убил монстров " + str(Globals.kills_n) +" раз"
	$VBoxContainer/SavesN.text = "Игру сохраняли " + str(Globals.saves_n) +" раз"
	if Globals.player1_name:
		$Morda/Name.text = Globals.player1_name
	
func _on_ширина_text_changed() -> void:
	$Morda.scale.x = float( $"Ширина".text )
func _on_злость_text_changed() -> void:
	$Morda.self_modulate.r = float( $"Злость".text )
func _on_имяигрока1_text_changed() -> void:
	Globals.player1_name = $"ИмяИгрока1".text

func _on_kill_mob_pressed() -> void:
		Globals.kills_n += 1	
func _on_died_pressed() -> void:
		Globals.deaths_n += 1

func _on_save_pressed() -> void:
	Globals.save_game()

func _on_load_pressed() -> void:
	Globals.load_game()

func _ready() -> void:
	#пусто почему??? где LOAD ^__^
	pass


func _on_save_encrypt_pressed() -> void:
	Globals.save_encrypt_game()
