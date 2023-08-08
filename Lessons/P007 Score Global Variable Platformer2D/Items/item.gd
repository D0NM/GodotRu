extends Area2D

@export var points : int = 1
var is_picked : bool = false

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func on_pickup(body):
	if is_picked:
		return
	is_picked = true
	$Sound.play()
	await $Sound.finished
	GlobalVars.score += points
	if(GlobalVars.score > GlobalVars.hi_score):
		GlobalVars.hi_score = GlobalVars.score
		$OnRecord.play()
		await $OnRecord.finished
	queue_free()
