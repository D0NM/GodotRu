extends CharacterBody2D


const SPEED = 300.0

var last_direction: String = "down"

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#if direction:
	velocity = direction * SPEED
	
	var anim_type := "idle_"
	if velocity:
		anim_type = "walk_"
		if velocity.y > 0:
			last_direction = "down"
		elif velocity.y < 0:
			last_direction = "up"
		if velocity.x > 0:
			last_direction = "right"
		elif velocity.x < 0:
			last_direction = "left"
	%AnimatedSprite2D.play(anim_type + last_direction)
	
	move_and_slide()
