#для канала Уроки GODOT для всех https://www.youtube.com/@GODOTru

extends CharacterBody2D

const SPEED = 4500.0

func _physics_process(delta):
	if randf() < 0.01:
		velocity.y = SPEED * delta * randf_range(-1.0, 1.0)
	if randf() < 0.01:
		velocity.x = SPEED * delta * randf_range(-1.0, 1.0)
	move_and_slide()
