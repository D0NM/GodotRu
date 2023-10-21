extends Node2D

func _ready():
	pass

func _process(delta):
#	var frogs = get_tree().get_nodes_in_group("frogs")
#	var turtles = get_tree().get_nodes_in_group("turtles")
#	var both = frogs + turtles
#	for f in both:
#		f.queue_free()	
	pass

func _on_button_test_pressed():
	get_tree().call_group("turtles", "queue_free")
	pass


func _on_button_hide_pressed():
	$Turtle.hide()
	pass

func _on_button_show_pressed():
	$Turtle.show()
	pass


func _on_button_hide_turtles_pressed():
	var turtles = get_tree().get_nodes_in_group("turtles")
	for f in turtles:
		f.hide()
	pass

func _on_button_hide_hard_pressed():
	var ddd = get_tree().get_nodes_in_group("hard")
#	var frogs = get_tree().get_nodes_in_group("frogs")
	for f in ddd:
		f.hide()

