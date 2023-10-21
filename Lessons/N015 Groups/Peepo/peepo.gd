extends Node2D

var counter = 0.0

func _ready():
	add_to_group("frogs")
	print("Frog: ", get_groups())
	pass

func _process(delta):
	rotation -= 0.17 * delta
	scale.x = 0.3 + sin(counter) / 20.0
	counter += 2.0 * delta
	
func get_red():
	modulate.r = 200
