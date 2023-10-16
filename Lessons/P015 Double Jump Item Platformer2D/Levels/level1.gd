extends Node2D

var SCROLL_SPEED_H := 100
var SCROLL_SPEED_V:= 230

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ParallaxBackground/CloudsParallaxLayer.motion_offset.x += SCROLL_SPEED_H * delta
	
