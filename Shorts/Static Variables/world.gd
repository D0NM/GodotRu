extends Node2D

func _start():
	$CanvasLayer/LabelGlobalN.text = "Global N: " + str( PlayerVariables.number_of_globbies )

func _process(delta):
	# узнать значение из переменной из autoload
	$CanvasLayer/LabelGlobalN.text = "Global N: " + str( PlayerVariables.number_of_globbies )
	# узнать значение статичной переменной из 1го узла Stattie (если есть)
	var stat = get_node_or_null("Stattie")	
	if stat:
		$CanvasLayer/LabelStaticN.text = "Static N: " + str(stat.number_of_statties)
	else: #если нет такого юнита, то и узнать кол-во неоткуда
		$CanvasLayer/LabelStaticN.text = "Static N: " + "?"

## спавн юнита в случайную позицию	
func spawn_unit(res_txt):
	var unit = load(res_txt).instantiate()
	unit.position = Vector2(randf_range(100, 400), randf_range(100, 400) )
	add_child(unit)

func _on_button_add_globbie_pressed():
	spawn_unit("res://Globbie/globbie.tscn")

func _on_button_add_stattie_pressed():
	spawn_unit("res://Stattie/stattie.tscn")
