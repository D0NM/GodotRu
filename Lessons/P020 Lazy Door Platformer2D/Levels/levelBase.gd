extends Node2D

var SCROLL_SPEED_H := 100
var SCROLL_SPEED_V:= 230

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	$ParallaxBackground/CloudsParallaxLayer.motion_offset.x += SCROLL_SPEED_H * delta
