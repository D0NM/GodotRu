extends Node2D

func _ready():
	rotation = randf_range(0, 2*PI)

func _process(delta):
	rotation += 1.1 * delta
	$Label.rotation = -rotation
	$Label.text = name + ": " + str( scale.x )
