extends Node2D
var толстота := 1.5

func _ready() -> void:
#	var толстота := 2
	$"Пипо".scale.x = толстота
	print(PI)
#	толстота = 2
	$"Пипо2".scale.x = толстота
	
	спецом_для_Пипо3()

#	if 2+4 == 6:
#		var толстота := 4
#		if 2+2 == 4:
#			$"Пипо4".scale.x = толстота
		
	for LOL in 1:
		var толстота := 4
		$"Пипо4".scale.x = толстота

	$"Пипо5".scale.x = толстота

func спецом_для_Пипо3():
	var толстота := 3
	$"Пипо3".scale.x = толстота	