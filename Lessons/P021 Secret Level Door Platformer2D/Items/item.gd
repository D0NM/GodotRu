extends Area2D

enum item_type {ITEM_FRUIT, ITEM_KEY, ITEM_D_JUMP, ITEM_BONUS}
@export var type : item_type

@export var points : int = 1
var is_picked : bool = false

func _ready() -> void:
	pass # Replace with function body.

func on_pickup(body):
	if is_picked:
		return
	is_picked = true
	var tween1 = get_tree().create_tween().set_parallel(true)
	tween1.tween_property($".", "position:y", position.y - 20, 1)
	tween1.tween_property($AnimatedSprite2D, "self_modulate:a", 0.0, 1)
	
	GlobalVars.score += points
	if(GlobalVars.score > GlobalVars.hi_score):
		GlobalVars.hi_score = GlobalVars.score
		$OnRecord.play()
		await $OnRecord.finished
	else:
		$Sound.play()
		await $Sound.finished
	await tween1.finished
	
	match type:
		item_type.ITEM_FRUIT:
			pass
		item_type.ITEM_KEY:
			body.has_key = true
			print_debug("Взяли ключ")
		item_type.ITEM_BONUS:	
			pass
		item_type.ITEM_D_JUMP:
			body.has_double_jump = true
			await get_tree().create_timer(10.0).timeout
			body.has_double_jump = false
			
	queue_free()
