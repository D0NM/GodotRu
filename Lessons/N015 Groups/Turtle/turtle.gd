extends Node2D

func _ready():
	print("Turtle: ", get_groups())
	rotation = randf()	
#	remove_from_group("turtles")
#	print("Turtle: ", get_groups())

func _process(delta):
	rotation += 1 * delta
#	modulate.r = 111.0
#	hide()
#	if is_in_group("hard"):
#		print(name, " в группе hard")

func get_red():
	modulate.r = 200
