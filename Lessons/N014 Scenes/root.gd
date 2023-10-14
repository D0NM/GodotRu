extends Node2D

func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time = Time.get_datetime_dict_from_system()
	$ArrowSeconds.rotation_degrees = (time.second / 60.0) * 360.0 -90
	var hour = time.hour
	if hour >= 12:
		hour -= 12
	$ArrowHours.rotation_degrees = ((hour + time.minute / 60.0) / 12.0) * 360.0 - 90
	$ArrowMinutes.rotation_degrees = (time.minute / 60.0) * 360.0 - 90
	$Label.text = "" + str(time.hour) + ":" + str(time.minute) + ":" + str(time.second)
	
	$Cursor.global_position = get_viewport().get_mouse_position()
	
	$Eye.look_at($Cursor.global_position)
	$Eye/Zrachok/Blik.global_rotation = 0
	
	$Eye2.look_at($Cursor.global_position)
	$Eye2/Zrachok/Blik.global_rotation = 0
	
